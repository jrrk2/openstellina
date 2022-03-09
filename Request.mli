type motor' = {
pos: float;
state: string;
stopped: bool;
calib: bool;
}

type motor = {
az: motor' ref;
alt: motor' ref;
der: motor' ref;
map: motor' ref;
}

type sens = {
temp: float ref;
tempd: float ref;
humid: float ref;
humidd: float ref;
defog: string ref;
dewp: float ref;
}

type conn = {
conid: string;
nam: string;
user: string;
}

type settings = {
telname: string option ref;
usbftypes: string list ref;
}

type update = {
instver: string ref;
minver: string ref;
state: string ref;
}

type store = {
size: int;
avail: int;
chng: int option;
}

type storage = {
system: store ref;
data: store ref;
usb: store ref;
}

type op = 
| Open
| Park of (string * Yojson.Basic.t) list
| AutoInit of (string * Yojson.Basic.t) list
| Observation of (string * Yojson.Basic.t) list
| SunMode
| Plan of (string * Yojson.Basic.t) list
| Storage

type attr = {
version: string ref;
api_version: string ref;
id: string ref;
motors: motor;
bootcnt : int ref;
initerr : Yojson.Basic.t ref;
board_initerr : Yojson.Basic.t ref;
debug : bool ref;
ts : int ref;
elap : int ref;
init : bool ref;
shut : bool ref;
connlst : conn list ref;
master_str : string option ref;
sett_lst : settings;
avail : int ref;
update : update;
storage : storage;
sens_lst : sens;
crnt : Yojson.Basic.t ref;
oth_crnt : Yojson.Basic.t list ref;
prev_op_lst : op list ref;
planner : (string * Yojson.Basic.t) list ref;
numfiles : int ref;
bufpos : int ref;
bufsiz : int ref;
lat: float ref;
long: float ref;
autofoctemp: float ref;
unhandled: string list ref;
}

type status = { success: bool; attr: attr }

type req = {
http_method: string ref;
uri: string ref;
path: string ref;
query: string ref;
qtree: string list ref;
line: string list ref;
rline: string list ref;
code: int ref;
rdesc: string ref;
lenh: int ref;
len: int ref;
cookie: string list ref;
ruri: string ref;
fil: attr;
key: string ref;
sec: string ref;
}
