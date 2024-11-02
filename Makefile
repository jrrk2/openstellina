RM=rm
MD=mkdir
CP=cp
SIPS=sips

APPNAME=openstellina

APPBUNDLE=$(PWD)/$(APPNAME).app
APPBUNDLECONTENTS=$(APPBUNDLE)/Contents
APPBUNDLEMACOS=$(APPBUNDLECONTENTS)/MacOS
APPBUNDLERESOURCES=$(APPBUNDLECONTENTS)/Resources
APPBUNDLELIBS=$(APPBUNDLECONTENTS)/MacOS/lib

appbundle: preinstall _build/install/default/bin/$(APPNAME) $(APPNAME).icns
	$(RM) -rf $(APPBUNDLE)
	$(MD) $(APPBUNDLE)
	$(MD) $(APPBUNDLECONTENTS)
	$(MD) $(APPBUNDLEMACOS)
	$(MD) $(APPBUNDLERESOURCES)
	$(MD) $(APPBUNDLELIBS)
	$(CP) Info.plist $(APPBUNDLECONTENTS)/
	$(CP) PkgInfo $(APPBUNDLECONTENTS)/
	$(CP) $(APPNAME).icns $(APPBUNDLERESOURCES)/
	$(CP) _build/install/default/bin/$(APPNAME) $(APPBUNDLEMACOS)/
	./path_change $(APPBUNDLEMACOS)/$(APPNAME)
	for i in $(APPBUNDLELIBS)/*.dylib; do ./path_change $$i;done
	for i in $(APPBUNDLELIBS)/*.dylib; do ./path_change $$i;done
	otool -L $(APPBUNDLEMACOS)/openstellina
	codesign --force --deep --sign - $(APPBUNDLEMACOS)/$(APPNAME)
	chmod 0 /opt/homebrew

$(APPNAME).icns: $(APPNAME).png
	$(RM) -rf $(APPNAME).iconset
	$(MD) $(APPNAME).iconset
	$(SIPS) -z 16 16   $(APPNAME).png --out $(APPNAME).iconset/icon_16x16.png
	$(SIPS) -z 32 32   $(APPNAME).png --out $(APPNAME).iconset/icon_16x16@2x.png
	$(SIPS) -z 32 32   $(APPNAME).png --out $(APPNAME).iconset/icon_32x32.png
	$(SIPS) -z 64 64   $(APPNAME).png --out $(APPNAME).iconset/icon_32x32@2x.png
	$(SIPS) -z 128 128 $(APPNAME).png --out $(APPNAME).iconset/icon_128x128.png
	$(SIPS) -z 256 256 $(APPNAME).png --out $(APPNAME).iconset/icon_128x128@2x.png
	$(SIPS) -z 256 256 $(APPNAME).png --out $(APPNAME).iconset/icon_256x256.png
	$(SIPS) -z 512 512 $(APPNAME).png --out $(APPNAME).iconset/icon_256x256@2x.png
	$(SIPS) -z 512 512 $(APPNAME).png --out $(APPNAME).iconset/icon_512x512.png
	$(CP) $(APPNAME).png $(APPNAME).iconset/icon_512x512@2x.png
	iconutil -c icns -o $(APPNAME).icns $(APPNAME).iconset
	$(RM) -r $(APPNAME).iconset

preinstall:
	chmod a+rx /opt/homebrew
	dune build
