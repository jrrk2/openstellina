#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#include "partial_file.h"
#endif

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

static MYFILE file_table[MYFILE_MAX_FILES];
static int file_count = 0;

#ifdef __EMSCRIPTEN__
EM_JS(void, js_fetch_partial_file, (const char* url, int32_t start, int32_t end, void* buffer_ptr, int* status_ptr), {
    var xhr = new XMLHttpRequest();
#if 0
    console.log('Fetching:', UTF8ToString(url), 'bytes', start, '-', end);
#endif        
    xhr.open('GET', UTF8ToString(url), false);  // Synchronous request
    xhr.setRequestHeader('Range', 'bytes=' + start + '-' + end);
    xhr.overrideMimeType('text/plain; charset=x-user-defined');
    
    try {
        xhr.send();
#if 0
        console.log('Response status:', xhr.status);
        console.log('Response headers:', xhr.getAllResponseHeaders());
#endif        
        if (xhr.status === 206) {
            var response = xhr.response;
#if 0
            console.log('Response length:', response.length);
#endif        
            
            var byteArray = new Uint8Array(response.length);
            for (var i = 0; i < response.length; ++i) {
                byteArray[i] = response.charCodeAt(i) & 0xff;
            }
            HEAPU8.set(byteArray, buffer_ptr);
            HEAP32[status_ptr >> 2] = byteArray.length;
            
#if 0
            console.log('Successfully read', byteArray.length, 'bytes');
            // Debug first few bytes
            if (byteArray.length > 0) {
                console.log('First bytes:', Array.from(byteArray.slice(0, 4)));
            }
#endif        
        } else {
            console.error('HTTP error:', xhr.status);
            HEAP32[status_ptr >> 2] = -xhr.status;
        }
    } catch(e) {
        console.error('XHR error:', e);
        console.error('Error details:', e.message);
        HEAP32[status_ptr >> 2] = -1;
    }
});

EM_JS(int, js_test_file, (const char* url), {
    var xhr = new XMLHttpRequest();
    var file_url = UTF8ToString(url);
#if 0
    console.log('Testing file existence:', file_url);
#endif
    xhr.open('HEAD', file_url, false);
    try {
        xhr.send();
        var status = (xhr.status >= 200 && xhr.status < 300);
#if 0
        console.log('File test result:', status ? 'exists' : 'not found');
#endif
        return status ? 1 : 0;
    } catch(e) {
        console.error('File test error:', e);
        return 0;
    }
});
#endif

MYFILE* myfopen(const char* filename, const char* mode) {
    if (!filename || !mode) {
      if (0) printf("myfopen: Invalid parameters\n");
        return NULL;
    }
    
    if (0) printf("myfopen: Opening %s with mode %s\n", filename, mode);
    
    #ifdef __EMSCRIPTEN__
    if (!js_test_file(filename)) {
        if (0) printf("myfopen: File not found: %s\n", filename);
        return NULL;
    }
    #endif
    
    if (file_count >= MYFILE_MAX_FILES) {
        if (0) printf("myfopen: Too many open files\n");
        return NULL;
    }
    
    MYFILE* file = NULL;
    for (int i = 0; i < MYFILE_MAX_FILES; i++) {
        if (!file_table[i].exists) {
            file = &file_table[i];
            break;
        }
    }
    
    if (!file) {
        if (0) printf("myfopen: No free file slots\n");
        return NULL;
    }
    
    file->filename = strdup(filename);
    file->position = 0;
    file->exists = 1;
    file->error_state = MYFILE_ERROR_NONE;
    
    file_count++;
    if (0) printf("myfopen: Successfully opened %s\n", filename);
    return file;
}

size_t myfread(void* ptr, size_t size, size_t count, MYFILE* file) {
    if (!ptr || !file || !file->exists) {
        if (0) printf("myfread: Invalid parameters: ptr=%p, file=%p, exists=%d\n", 
               ptr, file, file ? file->exists : 0);
        return 0;
    }
    
    const size_t total_bytes = size * count;
    if (0) printf("myfread: Reading %zu bytes at position %d from %s\n", 
           total_bytes, file->position, file->filename);
    
    #ifdef __EMSCRIPTEN__
    int status = 0;
    js_fetch_partial_file(file->filename, 
                         file->position,
                         file->position + total_bytes - 1,
                         ptr,
                         &status);
    
    if (0) printf("myfread: Read status: %d\n", status);
    
    if (status > 0) {
        file->position += status;
        if (0) printf("myfread: Successfully read %d bytes, new position: %d\n", 
               status, file->position);
        return status / size;
    } else {
        file->error_state = MYFILE_ERROR_NETWORK;
        if (0) printf("myfread: Network error occurred\n");
        return 0;
    }
    #else
    file->error_state = MYFILE_ERROR_INVALID;
    return 0;
    #endif
}

int myfseek(MYFILE* file, int32_t offset, int origin) {
    if (!file || !file->exists) {
        return -1;
    }
    
    int32_t new_position;
    
    switch (origin) {
        case SEEK_SET:
            new_position = offset;
            break;
        case SEEK_CUR:
            new_position = file->position + offset;
            break;
        case SEEK_END:
            return -1;  // Not supported without known file size
        default:
            return -1;
    }
    
    if (new_position < 0) {
        return -1;
    }
    
    file->position = new_position;
    return 0;
}

int32_t myftell(MYFILE* file) {
    if (!file || !file->exists) {
        return -1;
    }
    return file->position;
}

int myferror(MYFILE* file) {
    if (!file || !file->exists) {
        return MYFILE_ERROR_INVALID;
    }
    return file->error_state;
}

int myfclose(MYFILE* file) {
    if (!file || !file->exists) {
        return -1;
    }
    
    free(file->filename);
    file->exists = 0;
    file->filename = NULL;
    file_count--;
    
    return 0;
}

int myfeof(MYFILE* file) {
    if (!file || !file->exists) {
        return 1;
    }
    
    if (file->size >= 0 && file->position >= file->size) {
        return 1;
    }
    
    return 0;
}

const char* myfile_strerror(int error_code) {
    switch (error_code) {
        case MYFILE_ERROR_NONE:
            return "No error";
        case MYFILE_ERROR_NOT_FOUND:
            return "File not found";
        case MYFILE_ERROR_NETWORK:
            return "Network error";
        case MYFILE_ERROR_TIMEOUT:
            return "Operation timed out";
        case MYFILE_ERROR_INVALID:
            return "Invalid operation";
        default:
            return "Unknown error";
    }
}

// Rest of the implementation remains the same...
