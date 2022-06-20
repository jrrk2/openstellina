let (captured: Xml.xml list) =
[Xml.Element ("getProperties", [("version", "1.7")], []);
 Xml.Element
  ("defSwitchVector",
   [("device", "Telescope Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("enableBLOB", [("device", "Rotator Simulator")], [Xml.PCData "Never"]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On"])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Rotator Simulator"); ("name", "ABS_ROTATOR_ANGLE");
    ("label", "Goto"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "ANGLE"); ("label", "Angle"); ("format", "%.2f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0"])]);
 Xml.Element
  ("defTextVector",
   [("device", "Rotator Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "Connection"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_rotator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "4096    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Rotator Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "Connection"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_rotator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "4096    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION_MODE");
    ("label", "Connection Mode"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECTION_SERIAL"); ("label", "Serial")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONNECTION_TCP"); ("label", "Network")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION_MODE");
    ("label", "Connection Mode"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECTION_SERIAL"); ("label", "Serial")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONNECTION_TCP"); ("label", "Network")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Rotator Simulator"); ("name", "DEVICE_ADDRESS");
    ("label", "Server"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defText", [("name", "ADDRESS"); ("label", "Address")], []);
    Xml.Element ("defText", [("name", "PORT"); ("label", "Port")], [])]);
 Xml.Element
  ("defTextVector",
   [("device", "Rotator Simulator"); ("name", "DEVICE_ADDRESS");
    ("label", "Server"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defText", [("name", "ADDRESS"); ("label", "Address")], []);
    Xml.Element ("defText", [("name", "PORT"); ("label", "Port")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION_TYPE");
    ("label", "Connection Type"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TCP"); ("label", "TCP")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UDP"); ("label", "UDP")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION_TYPE");
    ("label", "Connection Type"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TCP"); ("label", "TCP")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UDP"); ("label", "UDP")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("label", "LAN Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("label", "LAN Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "Connection"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_focus    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "8    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "Connection"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_focus    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "8    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE");
    ("label", "Connection Mode"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECTION_SERIAL"); ("label", "Serial")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "CONNECTION_TCP"); ("label", "Network")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE");
    ("label", "Connection Mode"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECTION_SERIAL"); ("label", "Serial")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "CONNECTION_TCP"); ("label", "Network")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("label", "System Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "cuwlan-debug"); ("label", "cuwlan-debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "cuBluetooth-Incoming-Port");
       ("label", "cuBluetooth-Incoming-Port")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("label", "System Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "cuwlan-debug"); ("label", "cuwlan-debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "cuBluetooth-Incoming-Port");
       ("label", "cuBluetooth-Incoming-Port")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("label", "Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "PORT"); ("label", "Port")],
      [Xml.PCData "/dev/cuusbserial    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("label", "Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "PORT"); ("label", "Port")],
      [Xml.PCData "/dev/cuusbserial    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("label", "Baud Rate"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "9600"); ("label", "9600")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "19200"); ("label", "19200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "38400"); ("label", "38400")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "57600"); ("label", "57600")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "115200"); ("label", "115200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "230400"); ("label", "230400")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("label", "Baud Rate"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "9600"); ("label", "9600")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "19200"); ("label", "19200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "38400"); ("label", "38400")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "57600"); ("label", "57600")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "115200"); ("label", "115200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "230400"); ("label", "230400")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("label", "Auto Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("label", "Auto Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "Off    "])]);
(*
 Xml.Element
  ("enableBLOB",
   [("device",
     "<defSwitchVector device=\"Focuser Simulator\" name=\"DEVICE_PORT_SCAN\" label=\"Refresh\" group=\"Connection\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"Scan Ports\" label=\"Scan Ports\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"Focuser Simulator\" name=\"Mode\" label=\"Mode\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"All\" label=\"All\">On    </defSwitch>    <defSwitch name=\"Absolute\" label=\"Absolute\">Off    </defSwitch>    <defSwitch name=\"Relative\" label=\"Relative\">Off    </defSwitch>    <defSwitch name=\"Timer\" label=\"Timer\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"Focuser Simulator\" name=\"Mode\" label=\"Mode\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"All\" label=\"All\">On    </defSwitch>    <defSwitch name=\"Absolute\" label=\"Absolute\">Off    </defSwitch>    <defSwitch name=\"Relative\" label=\"Relative\">Off    </defSwitch>    <defSwitch name=\"Timer\" label=\"Timer\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CONNECTION\" label=\"Connection\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"CONNECT\" label=\"Connect\">Off    </defSwitch>    <defSwitch name=\"DISCONNECT\" label=\"Disconnect\">On    </defSwitch></defSwitchVector><defTextVector device=\"CCD Simulator\" name=\"DRIVER_INFO\" label=\"Driver Info\" group=\"General Info\" state=\"Idle\" perm=\"ro\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defText name=\"DRIVER_NAME\" label=\"Name\">CCD Simulator    </defText>    <defText name=\"DRIVER_EXEC\" label=\"Exec\">indi_simulator_ccd    </defText>    <defText name=\"DRIVER_VERSION\" label=\"Version\">1.0    </defText>    <defText name=\"DRIVER_INTERFACE\" label=\"Interface\">22    </defText></defTextVector>Focuser Simulator")],
   [Xml.PCData "Never"]);
 Xml.Element
  ("message",
   [("device",
     "<defSwitchVector device=\"Focuser Simulator\" name=\"DEVICE_PORT_SCAN\" label=\"Refresh\" group=\"Connection\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"Scan Ports\" label=\"Scan Ports\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"Focuser Simulator\" name=\"Mode\" label=\"Mode\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"All\" label=\"All\">On    </defSwitch>    <defSwitch name=\"Absolute\" label=\"Absolute\">Off    </defSwitch>    <defSwitch name=\"Relative\" label=\"Relative\">Off    </defSwitch>    <defSwitch name=\"Timer\" label=\"Timer\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"Focuser Simulator\" name=\"Mode\" label=\"Mode\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"All\" label=\"All\">On    </defSwitch>    <defSwitch name=\"Absolute\" label=\"Absolute\">Off    </defSwitch>    <defSwitch name=\"Relative\" label=\"Relative\">Off    </defSwitch>    <defSwitch name=\"Timer\" label=\"Timer\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CONNECTION\" label=\"Connection\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"CONNECT\" label=\"Connect\">Off    </defSwitch>    <defSwitch name=\"DISCONNECT\" label=\"Disconnect\">On    </defSwitch></defSwitchVector><defTextVector device=\"CCD Simulator\" name=\"DRIVER_INFO\" label=\"Driver Info\" group=\"General Info\" state=\"Idle\" perm=\"ro\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defText name=\"DRIVER_NAME\" label=\"Name\">CCD Simulator    </defText>    <defText name=\"DRIVER_EXEC\" label=\"Exec\">indi_simulator_ccd    </defText>    <defText name=\"DRIVER_VERSION\" label=\"Version\">1.0    </defText>    <defText name=\"DRIVER_INTERFACE\" label=\"Interface\">22    </defText></defTextVector>Focuser Simulator");
    ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device <defSwitchVector device=\"Focuser Simulator\" name=\"DEVICE_PORT_SCAN\" label=\"Refresh\" group=\"Connection\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"Scan Ports\" label=\"Scan Ports\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"Focuser Simulator\" name=\"Mode\" label=\"Mode\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"All\" label=\"All\">On    </defSwitch>    <defSwitch name=\"Absolute\" label=\"Absolute\">Off    </defSwitch>    <defSwitch name=\"Relative\" label=\"Relative\">Off    </defSwitch>    <defSwitch name=\"Timer\" label=\"Timer\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"Focuser Simulator\" name=\"Mode\" label=\"Mode\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"All\" label=\"All\">On    </defSwitch>    <defSwitch name=\"Absolute\" label=\"Absolute\">Off    </defSwitch>    <defSwitch name=\"Relative\" label=\"Relative\">Off    </defSwitch>    <defSwitch name=\"Timer\" label=\"Timer\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CONNECTION\" label=\"Connection\" group=\"Main Control\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"CONNECT\" label=\"Connect\">Off    </defSwitch>    <defSwitch name=\"DISCONNECT\" label=\"Disconnect\">On    </defSwitch></defSwitchVector><defTextVector device=\"CCD Simulator\" name=\"DRIVER_INFO\" label=\"Driver Info\" group=\"General Info\" state=\"Idle\" perm=\"ro\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defText name=\"DRIVER_NAME\" label=\"Name\">CCD Simulator    </defText>    <defText name=\"DRIVER_EXEC\" label=\"Exec\">indi_simulator_ccd    </defText>    <defText name=\"DRIVER_VERSION\" label=\"Version\">1.0    </defText>    <defText name=\"DRIVER_INTERFACE\" label=\"Interface\">22    </defText></defTextVector>Focuser Simulator has no options")],
   []);
*)
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
(*
 Xml.Element
  ("enableBLOB",
   [("device",
     "<defSwitchVector device=\"CCD Simulator\" name=\"CONFIG_PROCESS\" label=\"Configuration\" group=\"Options\" state=\"Idle\" perm=\"rw\" rule=\"AtMostOne\" timeout=\"0\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"CONFIG_LOAD\" label=\"Load\">Off    </defSwitch>    <defSwitch name=\"CONFIG_SAVE\" label=\"Save\">Off    </defSwitch>    <defSwitch name=\"CONFIG_DEFAULT\" label=\"Default\">Off    </defSwitch>    <defSwitch name=\"CONFIG_PURGE\" label=\"Purge\">Off    </defSwitch></defSwitchVector><defTextVector device=\"CCD Simulator\" name=\"ACTIVE_DEVICES\" label=\"Snoop devices\" group=\"Options\" state=\"Ok\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defText name=\"ACTIVE_TELESCOPE\" label=\"Telescope\">Telescope Simulator    </defText>    <defText name=\"ACTIVE_ROTATOR\" label=\"Rotator\">Rotator Simulator    </defText>    <defText name=\"ACTIVE_FOCUSER\" label=\"Focuser\">Focuser Simulator    </defText>    <defText name=\"ACTIVE_FILTER\" label=\"Filter\"/>    <defText name=\"ACTIVE_SKYQUALITY\" label=\"Sky Quality\">SQM    </defText></defTextVector><defNumberVector device=\"CCD Simulator\" name=\"SIMULATOR_SETTINGS\" label=\"Settings\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_XRES\" label=\"CCD X resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1280    </defNumber>    <defNumber name=\"SIM_YRES\" label=\"CCD Y resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1024    </defNumber>    <defNumber name=\"SIM_XSIZE\" label=\"CCD X Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_YSIZE\" label=\"CCD Y Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_MAXVAL\" label=\"CCD Maximum ADU\" format=\"%4.0f\" min=\"255\" max=\"65000\" step=\"1000\">65000    </defNumber>    <defNumber name=\"SIM_SATURATION\" label=\"Saturation Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">1    </defNumber>    <defNumber name=\"SIM_LIMITINGMAG\" label=\"Limiting Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">17    </defNumber>    <defNumber name=\"SIM_NOISE\" label=\"CCD Noise\" format=\"%4.0f\" min=\"0\" max=\"6000\" step=\"500\">10    </defNumber>    <defNumber name=\"SIM_SKYGLOW\" label=\"Sky Glow (magnitudes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">19.5    </defNumber>    <defNumber name=\"SIM_OAGOFFSET\" label=\"Oag Offset (arcminutes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_POLAR\" label=\"PAE (arcminutes)\" format=\"%4.1f\" min=\"-600\" max=\"600\" step=\"100\">0    </defNumber>    <defNumber name=\"SIM_POLARDRIFT\" label=\"PAE Drift (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEPERIOD\" label=\"PE Period (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEMAX\" label=\"PE Max (arcsec)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_TIME_FACTOR\" label=\"Time Factor (x)\" format=\"%2f\" min=\"0.010000000000000000208\" max=\"100\" step=\"10\">1    </defNumber>    <defNumber name=\"SIM_ROTATION\" label=\"CCD Rotation\" format=\"%2f\" min=\"0\" max=\"360\" step=\"10\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"EQUATORIAL_PE\" label=\"EQ PE\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"RA_PE\" label=\"RA (hh:mm:ss)\" format=\"%010.6m\" min=\"0\" max=\"24\" step=\"0\">0    </defNumber>    <defNumber name=\"DEC_PE\" label=\"DEC (dd:mm:ss)\" format=\"%010.6m\" min=\"-90\" max=\"90\" step=\"0\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"SIM_FOCUSING\" label=\"Focus Simulation\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_FOCUS_POSITION\" label=\"Focus\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">36700    </defNumber>    <defNumber name=\"SIM_FOCUS_MAX\" label=\"Max Position\" format=\"%f\" min=\"0\" maCCD Simulator")],
   [Xml.PCData "Never"]);
 Xml.Element
  ("message",
   [("device",
     "<defSwitchVector device=\"CCD Simulator\" name=\"CONFIG_PROCESS\" label=\"Configuration\" group=\"Options\" state=\"Idle\" perm=\"rw\" rule=\"AtMostOne\" timeout=\"0\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"CONFIG_LOAD\" label=\"Load\">Off    </defSwitch>    <defSwitch name=\"CONFIG_SAVE\" label=\"Save\">Off    </defSwitch>    <defSwitch name=\"CONFIG_DEFAULT\" label=\"Default\">Off    </defSwitch>    <defSwitch name=\"CONFIG_PURGE\" label=\"Purge\">Off    </defSwitch></defSwitchVector><defTextVector device=\"CCD Simulator\" name=\"ACTIVE_DEVICES\" label=\"Snoop devices\" group=\"Options\" state=\"Ok\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defText name=\"ACTIVE_TELESCOPE\" label=\"Telescope\">Telescope Simulator    </defText>    <defText name=\"ACTIVE_ROTATOR\" label=\"Rotator\">Rotator Simulator    </defText>    <defText name=\"ACTIVE_FOCUSER\" label=\"Focuser\">Focuser Simulator    </defText>    <defText name=\"ACTIVE_FILTER\" label=\"Filter\"/>    <defText name=\"ACTIVE_SKYQUALITY\" label=\"Sky Quality\">SQM    </defText></defTextVector><defNumberVector device=\"CCD Simulator\" name=\"SIMULATOR_SETTINGS\" label=\"Settings\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_XRES\" label=\"CCD X resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1280    </defNumber>    <defNumber name=\"SIM_YRES\" label=\"CCD Y resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1024    </defNumber>    <defNumber name=\"SIM_XSIZE\" label=\"CCD X Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_YSIZE\" label=\"CCD Y Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_MAXVAL\" label=\"CCD Maximum ADU\" format=\"%4.0f\" min=\"255\" max=\"65000\" step=\"1000\">65000    </defNumber>    <defNumber name=\"SIM_SATURATION\" label=\"Saturation Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">1    </defNumber>    <defNumber name=\"SIM_LIMITINGMAG\" label=\"Limiting Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">17    </defNumber>    <defNumber name=\"SIM_NOISE\" label=\"CCD Noise\" format=\"%4.0f\" min=\"0\" max=\"6000\" step=\"500\">10    </defNumber>    <defNumber name=\"SIM_SKYGLOW\" label=\"Sky Glow (magnitudes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">19.5    </defNumber>    <defNumber name=\"SIM_OAGOFFSET\" label=\"Oag Offset (arcminutes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_POLAR\" label=\"PAE (arcminutes)\" format=\"%4.1f\" min=\"-600\" max=\"600\" step=\"100\">0    </defNumber>    <defNumber name=\"SIM_POLARDRIFT\" label=\"PAE Drift (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEPERIOD\" label=\"PE Period (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEMAX\" label=\"PE Max (arcsec)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_TIME_FACTOR\" label=\"Time Factor (x)\" format=\"%2f\" min=\"0.010000000000000000208\" max=\"100\" step=\"10\">1    </defNumber>    <defNumber name=\"SIM_ROTATION\" label=\"CCD Rotation\" format=\"%2f\" min=\"0\" max=\"360\" step=\"10\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"EQUATORIAL_PE\" label=\"EQ PE\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"RA_PE\" label=\"RA (hh:mm:ss)\" format=\"%010.6m\" min=\"0\" max=\"24\" step=\"0\">0    </defNumber>    <defNumber name=\"DEC_PE\" label=\"DEC (dd:mm:ss)\" format=\"%010.6m\" min=\"-90\" max=\"90\" step=\"0\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"SIM_FOCUSING\" label=\"Focus Simulation\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_FOCUS_POSITION\" label=\"Focus\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">36700    </defNumber>    <defNumber name=\"SIM_FOCUS_MAX\" label=\"Max Position\" format=\"%f\" min=\"0\" maCCD Simulator");
    ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device <defSwitchVector device=\"CCD Simulator\" name=\"CONFIG_PROCESS\" label=\"Configuration\" group=\"Options\" state=\"Idle\" perm=\"rw\" rule=\"AtMostOne\" timeout=\"0\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"CONFIG_LOAD\" label=\"Load\">Off    </defSwitch>    <defSwitch name=\"CONFIG_SAVE\" label=\"Save\">Off    </defSwitch>    <defSwitch name=\"CONFIG_DEFAULT\" label=\"Default\">Off    </defSwitch>    <defSwitch name=\"CONFIG_PURGE\" label=\"Purge\">Off    </defSwitch></defSwitchVector><defTextVector device=\"CCD Simulator\" name=\"ACTIVE_DEVICES\" label=\"Snoop devices\" group=\"Options\" state=\"Ok\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defText name=\"ACTIVE_TELESCOPE\" label=\"Telescope\">Telescope Simulator    </defText>    <defText name=\"ACTIVE_ROTATOR\" label=\"Rotator\">Rotator Simulator    </defText>    <defText name=\"ACTIVE_FOCUSER\" label=\"Focuser\">Focuser Simulator    </defText>    <defText name=\"ACTIVE_FILTER\" label=\"Filter\"/>    <defText name=\"ACTIVE_SKYQUALITY\" label=\"Sky Quality\">SQM    </defText></defTextVector><defNumberVector device=\"CCD Simulator\" name=\"SIMULATOR_SETTINGS\" label=\"Settings\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_XRES\" label=\"CCD X resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1280    </defNumber>    <defNumber name=\"SIM_YRES\" label=\"CCD Y resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1024    </defNumber>    <defNumber name=\"SIM_XSIZE\" label=\"CCD X Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_YSIZE\" label=\"CCD Y Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_MAXVAL\" label=\"CCD Maximum ADU\" format=\"%4.0f\" min=\"255\" max=\"65000\" step=\"1000\">65000    </defNumber>    <defNumber name=\"SIM_SATURATION\" label=\"Saturation Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">1    </defNumber>    <defNumber name=\"SIM_LIMITINGMAG\" label=\"Limiting Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">17    </defNumber>    <defNumber name=\"SIM_NOISE\" label=\"CCD Noise\" format=\"%4.0f\" min=\"0\" max=\"6000\" step=\"500\">10    </defNumber>    <defNumber name=\"SIM_SKYGLOW\" label=\"Sky Glow (magnitudes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">19.5    </defNumber>    <defNumber name=\"SIM_OAGOFFSET\" label=\"Oag Offset (arcminutes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_POLAR\" label=\"PAE (arcminutes)\" format=\"%4.1f\" min=\"-600\" max=\"600\" step=\"100\">0    </defNumber>    <defNumber name=\"SIM_POLARDRIFT\" label=\"PAE Drift (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEPERIOD\" label=\"PE Period (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEMAX\" label=\"PE Max (arcsec)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_TIME_FACTOR\" label=\"Time Factor (x)\" format=\"%2f\" min=\"0.010000000000000000208\" max=\"100\" step=\"10\">1    </defNumber>    <defNumber name=\"SIM_ROTATION\" label=\"CCD Rotation\" format=\"%2f\" min=\"0\" max=\"360\" step=\"10\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"EQUATORIAL_PE\" label=\"EQ PE\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"RA_PE\" label=\"RA (hh:mm:ss)\" format=\"%010.6m\" min=\"0\" max=\"24\" step=\"0\">0    </defNumber>    <defNumber name=\"DEC_PE\" label=\"DEC (dd:mm:ss)\" format=\"%010.6m\" min=\"-90\" max=\"90\" step=\"0\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"SIM_FOCUSING\" label=\"Focus Simulation\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_FOCUS_POSITION\" label=\"Focus\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">36700    </defNumber>    <defNumber name=\"SIM_FOCUS_MAX\" label=\"Max Position\" format=\"%f\" min=\"0\" maCCD Simulator has no options")],
   []);
*)
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "FLIP_HA");
    ("label", "Flip Posn"); ("group", "Simulation"); ("state", "Ok");
    ("perm", "wo"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FLIP_HA"); ("label", "Hour Angle (deg)"); ("format", "%g");
       ("min", "-20"); ("max", "20"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "FLIP_HA");
    ("label", "Flip Posn"); ("group", "Simulation"); ("state", "Ok");
    ("perm", "wo"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FLIP_HA"); ("label", "Hour Angle (deg)"); ("format", "%g");
       ("min", "-20"); ("max", "20"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Telescope Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_GPS"); ("label", "GPS")],
      [Xml.PCData "GPS Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_DOME"); ("label", "DOME")],
      [Xml.PCData "Dome Simulator    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Telescope Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_GPS"); ("label", "GPS")],
      [Xml.PCData "GPS Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_DOME"); ("label", "DOME")],
      [Xml.PCData "Dome Simulator    "])]);
 Xml.Element
  ("setTextVector",
   [("device", "Telescope Simulator"); ("name", "ACTIVE_DEVICES");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneText", [("name", "ACTIVE_GPS")], [Xml.PCData "GPS Simulator    "]);
    Xml.Element
     ("oneText", [("name", "ACTIVE_DOME")],
      [Xml.PCData "Dome Simulator    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setTextVec active")],
   []);
(*
 Xml.Element
  ("enableBLOB",
   [("device",
     "<setTextVector device=\"CCD Simulator\" name=\"ACTIVE_DEVICES\" state=\"Ok\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <oneText name=\"ACTIVE_TELESCOPE\">Telescope Simulator    </oneText>    <oneText name=\"ACTIVE_ROTATOR\">Rotator Simulator    </oneText>    <oneText name=\"ACTIVE_FOCUSER\">Focuser Simulator    </oneText>    <oneText name=\"ACTIVE_FILTER\"/>    <oneText name=\"ACTIVE_SKYQUALITY\">SQM    </oneText></setTextVector><defNumberVector device=\"CCD Simulator\" name=\"SIMULATOR_SETTINGS\" label=\"Settings\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_XRES\" label=\"CCD X resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1280    </defNumber>    <defNumber name=\"SIM_YRES\" label=\"CCD Y resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1024    </defNumber>    <defNumber name=\"SIM_XSIZE\" label=\"CCD X Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_YSIZE\" label=\"CCD Y Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_MAXVAL\" label=\"CCD Maximum ADU\" format=\"%4.0f\" min=\"255\" max=\"65000\" step=\"1000\">65000    </defNumber>    <defNumber name=\"SIM_SATURATION\" label=\"Saturation Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">1    </defNumber>    <defNumber name=\"SIM_LIMITINGMAG\" label=\"Limiting Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">17    </defNumber>    <defNumber name=\"SIM_NOISE\" label=\"CCD Noise\" format=\"%4.0f\" min=\"0\" max=\"6000\" step=\"500\">10    </defNumber>    <defNumber name=\"SIM_SKYGLOW\" label=\"Sky Glow (magnitudes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">19.5    </defNumber>    <defNumber name=\"SIM_OAGOFFSET\" label=\"Oag Offset (arcminutes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_POLAR\" label=\"PAE (arcminutes)\" format=\"%4.1f\" min=\"-600\" max=\"600\" step=\"100\">0    </defNumber>    <defNumber name=\"SIM_POLARDRIFT\" label=\"PAE Drift (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEPERIOD\" label=\"PE Period (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEMAX\" label=\"PE Max (arcsec)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_TIME_FACTOR\" label=\"Time Factor (x)\" format=\"%2f\" min=\"0.010000000000000000208\" max=\"100\" step=\"10\">1    </defNumber>    <defNumber name=\"SIM_ROTATION\" label=\"CCD Rotation\" format=\"%2f\" min=\"0\" max=\"360\" step=\"10\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"EQUATORIAL_PE\" label=\"EQ PE\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"RA_PE\" label=\"RA (hh:mm:ss)\" format=\"%010.6m\" min=\"0\" max=\"24\" step=\"0\">0    </defNumber>    <defNumber name=\"DEC_PE\" label=\"DEC (dd:mm:ss)\" format=\"%010.6m\" min=\"-90\" max=\"90\" step=\"0\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"SIM_FOCUSING\" label=\"Focus Simulation\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_FOCUS_POSITION\" label=\"Focus\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">36700    </defNumber>    <defNumber name=\"SIM_FOCUS_MAX\" label=\"Max Position\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">100000    </defNumber>    <defNumber name=\"SIM_SEEING\" label=\"Seeing (arcsec)\" format=\"%4.2f\" min=\"0\" max=\"60\" step=\"0\">3.5    </defNumber></defNumberVector><defSwitchVector device=\"CCD Simulator\" name=\"SIMULATE_BAYER\" label=\"Bayer\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"INDI_ENABLED\" label=\"Enabled\">Off    </defSwitch>    <defSwitch name=\"INDI_DISABLED\" label=\"Disabled\">On    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CCD_SIMULATE_CRASH\" label=\"Crash\" grouTelescope Simulator")],
   [Xml.PCData "Never"]);
 Xml.Element
  ("message",
   [("device",
     "<setTextVector device=\"CCD Simulator\" name=\"ACTIVE_DEVICES\" state=\"Ok\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <oneText name=\"ACTIVE_TELESCOPE\">Telescope Simulator    </oneText>    <oneText name=\"ACTIVE_ROTATOR\">Rotator Simulator    </oneText>    <oneText name=\"ACTIVE_FOCUSER\">Focuser Simulator    </oneText>    <oneText name=\"ACTIVE_FILTER\"/>    <oneText name=\"ACTIVE_SKYQUALITY\">SQM    </oneText></setTextVector><defNumberVector device=\"CCD Simulator\" name=\"SIMULATOR_SETTINGS\" label=\"Settings\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_XRES\" label=\"CCD X resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1280    </defNumber>    <defNumber name=\"SIM_YRES\" label=\"CCD Y resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1024    </defNumber>    <defNumber name=\"SIM_XSIZE\" label=\"CCD X Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_YSIZE\" label=\"CCD Y Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_MAXVAL\" label=\"CCD Maximum ADU\" format=\"%4.0f\" min=\"255\" max=\"65000\" step=\"1000\">65000    </defNumber>    <defNumber name=\"SIM_SATURATION\" label=\"Saturation Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">1    </defNumber>    <defNumber name=\"SIM_LIMITINGMAG\" label=\"Limiting Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">17    </defNumber>    <defNumber name=\"SIM_NOISE\" label=\"CCD Noise\" format=\"%4.0f\" min=\"0\" max=\"6000\" step=\"500\">10    </defNumber>    <defNumber name=\"SIM_SKYGLOW\" label=\"Sky Glow (magnitudes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">19.5    </defNumber>    <defNumber name=\"SIM_OAGOFFSET\" label=\"Oag Offset (arcminutes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_POLAR\" label=\"PAE (arcminutes)\" format=\"%4.1f\" min=\"-600\" max=\"600\" step=\"100\">0    </defNumber>    <defNumber name=\"SIM_POLARDRIFT\" label=\"PAE Drift (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEPERIOD\" label=\"PE Period (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEMAX\" label=\"PE Max (arcsec)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_TIME_FACTOR\" label=\"Time Factor (x)\" format=\"%2f\" min=\"0.010000000000000000208\" max=\"100\" step=\"10\">1    </defNumber>    <defNumber name=\"SIM_ROTATION\" label=\"CCD Rotation\" format=\"%2f\" min=\"0\" max=\"360\" step=\"10\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"EQUATORIAL_PE\" label=\"EQ PE\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"RA_PE\" label=\"RA (hh:mm:ss)\" format=\"%010.6m\" min=\"0\" max=\"24\" step=\"0\">0    </defNumber>    <defNumber name=\"DEC_PE\" label=\"DEC (dd:mm:ss)\" format=\"%010.6m\" min=\"-90\" max=\"90\" step=\"0\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"SIM_FOCUSING\" label=\"Focus Simulation\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_FOCUS_POSITION\" label=\"Focus\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">36700    </defNumber>    <defNumber name=\"SIM_FOCUS_MAX\" label=\"Max Position\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">100000    </defNumber>    <defNumber name=\"SIM_SEEING\" label=\"Seeing (arcsec)\" format=\"%4.2f\" min=\"0\" max=\"60\" step=\"0\">3.5    </defNumber></defNumberVector><defSwitchVector device=\"CCD Simulator\" name=\"SIMULATE_BAYER\" label=\"Bayer\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"INDI_ENABLED\" label=\"Enabled\">Off    </defSwitch>    <defSwitch name=\"INDI_DISABLED\" label=\"Disabled\">On    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CCD_SIMULATE_CRASH\" label=\"Crash\" grouTelescope Simulator");
    ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device <setTextVector device=\"CCD Simulator\" name=\"ACTIVE_DEVICES\" state=\"Ok\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <oneText name=\"ACTIVE_TELESCOPE\">Telescope Simulator    </oneText>    <oneText name=\"ACTIVE_ROTATOR\">Rotator Simulator    </oneText>    <oneText name=\"ACTIVE_FOCUSER\">Focuser Simulator    </oneText>    <oneText name=\"ACTIVE_FILTER\"/>    <oneText name=\"ACTIVE_SKYQUALITY\">SQM    </oneText></setTextVector><defNumberVector device=\"CCD Simulator\" name=\"SIMULATOR_SETTINGS\" label=\"Settings\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_XRES\" label=\"CCD X resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1280    </defNumber>    <defNumber name=\"SIM_YRES\" label=\"CCD Y resolution\" format=\"%4.0f\" min=\"512\" max=\"8192\" step=\"512\">1024    </defNumber>    <defNumber name=\"SIM_XSIZE\" label=\"CCD X Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_YSIZE\" label=\"CCD Y Pixel Size\" format=\"%4.2f\" min=\"1\" max=\"30\" step=\"5\">5.2000000000000001776    </defNumber>    <defNumber name=\"SIM_MAXVAL\" label=\"CCD Maximum ADU\" format=\"%4.0f\" min=\"255\" max=\"65000\" step=\"1000\">65000    </defNumber>    <defNumber name=\"SIM_SATURATION\" label=\"Saturation Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">1    </defNumber>    <defNumber name=\"SIM_LIMITINGMAG\" label=\"Limiting Mag\" format=\"%4.1f\" min=\"0\" max=\"20\" step=\"1\">17    </defNumber>    <defNumber name=\"SIM_NOISE\" label=\"CCD Noise\" format=\"%4.0f\" min=\"0\" max=\"6000\" step=\"500\">10    </defNumber>    <defNumber name=\"SIM_SKYGLOW\" label=\"Sky Glow (magnitudes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">19.5    </defNumber>    <defNumber name=\"SIM_OAGOFFSET\" label=\"Oag Offset (arcminutes)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_POLAR\" label=\"PAE (arcminutes)\" format=\"%4.1f\" min=\"-600\" max=\"600\" step=\"100\">0    </defNumber>    <defNumber name=\"SIM_POLARDRIFT\" label=\"PAE Drift (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEPERIOD\" label=\"PE Period (minutes)\" format=\"%4.1f\" min=\"0\" max=\"60\" step=\"5\">0    </defNumber>    <defNumber name=\"SIM_PEMAX\" label=\"PE Max (arcsec)\" format=\"%4.1f\" min=\"0\" max=\"6000\" step=\"500\">0    </defNumber>    <defNumber name=\"SIM_TIME_FACTOR\" label=\"Time Factor (x)\" format=\"%2f\" min=\"0.010000000000000000208\" max=\"100\" step=\"10\">1    </defNumber>    <defNumber name=\"SIM_ROTATION\" label=\"CCD Rotation\" format=\"%2f\" min=\"0\" max=\"360\" step=\"10\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"EQUATORIAL_PE\" label=\"EQ PE\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"RA_PE\" label=\"RA (hh:mm:ss)\" format=\"%010.6m\" min=\"0\" max=\"24\" step=\"0\">0    </defNumber>    <defNumber name=\"DEC_PE\" label=\"DEC (dd:mm:ss)\" format=\"%010.6m\" min=\"-90\" max=\"90\" step=\"0\">0    </defNumber></defNumberVector><defNumberVector device=\"CCD Simulator\" name=\"SIM_FOCUSING\" label=\"Focus Simulation\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defNumber name=\"SIM_FOCUS_POSITION\" label=\"Focus\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">36700    </defNumber>    <defNumber name=\"SIM_FOCUS_MAX\" label=\"Max Position\" format=\"%f\" min=\"0\" max=\"100000\" step=\"1\">100000    </defNumber>    <defNumber name=\"SIM_SEEING\" label=\"Seeing (arcsec)\" format=\"%4.2f\" min=\"0\" max=\"60\" step=\"0\">3.5    </defNumber></defNumberVector><defSwitchVector device=\"CCD Simulator\" name=\"SIMULATE_BAYER\" label=\"Bayer\" group=\"Simulator Config\" state=\"Idle\" perm=\"rw\" rule=\"OneOfMany\" timeout=\"60\" timestamp=\"2022-06-15T18:44:17\">    <defSwitch name=\"INDI_ENABLED\" label=\"Enabled\">Off    </defSwitch>    <defSwitch name=\"INDI_DISABLED\" label=\"Disabled\">On    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CCD_SIMULATE_CRASH\" label=\"Crash\" grouTelescope Simulator has no options")],
   []);
*)
 Xml.Element
  ("setSwitchVector",
   [("device", "Telescope Simulator"); ("name", "SIM_PIER_SIDE");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "PS_OFF")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "PS_ON")], [Xml.PCData "On    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "MOUNT_MODEL");
    ("label", "Mount Model"); ("group", "Simulation"); ("state", "Ok");
    ("perm", "wo"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "MM_IH"); ("label", "Ha Zero (IH)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_ID"); ("label", "Dec Zero (ID)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_CH"); ("label", "Cone (CH)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_NP"); ("label", "Ha/Dec (NP)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_MA"); ("label", "Pole Azm (MA)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_ME"); ("label", "Pole elev (ME)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "MOUNT_MODEL");
    ("label", "Mount Model"); ("group", "Simulation"); ("state", "Ok");
    ("perm", "wo"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "MM_IH"); ("label", "Ha Zero (IH)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_ID"); ("label", "Dec Zero (ID)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_CH"); ("label", "Cone (CH)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_NP"); ("label", "Ha/Dec (NP)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_MA"); ("label", "Pole Azm (MA)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "MM_ME"); ("label", "Pole elev (ME)"); ("format", "%g");
       ("min", "-5"); ("max", "5"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("setNumberVector",
   [("device", "Telescope Simulator"); ("name", "MOUNT_MODEL");
    ("state", "Ok"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneNumber", [("name", "MM_IH")], [Xml.PCData "0    "]);
    Xml.Element ("oneNumber", [("name", "MM_ID")], [Xml.PCData "0    "]);
    Xml.Element ("oneNumber", [("name", "MM_CH")], [Xml.PCData "0    "]);
    Xml.Element ("oneNumber", [("name", "MM_NP")], [Xml.PCData "0    "]);
    Xml.Element ("oneNumber", [("name", "MM_MA")], [Xml.PCData "0    "]);
    Xml.Element ("oneNumber", [("name", "MM_ME")], [Xml.PCData "0    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "MOUNT_AXES");
    ("label", "Mount Axes"); ("group", "Simulation"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PRIMARY"); ("label", "Primary (Ha)"); ("format", "%g");
       ("min", "-180"); ("max", "180"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SECONDARY"); ("label", "Secondary (Dec)"); ("format", "%g");
       ("min", "-180"); ("max", "180"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "MOUNT_AXES");
    ("label", "Mount Axes"); ("group", "Simulation"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PRIMARY"); ("label", "Primary (Ha)"); ("format", "%g");
       ("min", "-180"); ("max", "180"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SECONDARY"); ("label", "Secondary (Dec)"); ("format", "%g");
       ("min", "-180"); ("max", "180"); ("step", "0.010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "FLIP_HA");
    ("label", "Flip Posn"); ("group", "Simulation"); ("state", "Ok");
    ("perm", "wo"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FLIP_HA"); ("label", "Hour Angle (deg)"); ("format", "%g");
       ("min", "-20"); ("max", "20"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "FLIP_HA");
    ("label", "Flip Posn"); ("group", "Simulation"); ("state", "Ok");
    ("perm", "wo"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FLIP_HA"); ("label", "Hour Angle (deg)"); ("format", "%g");
       ("min", "-20"); ("max", "20"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("setNumberVector",
   [("device", "Telescope Simulator"); ("name", "FLIP_HA"); ("state", "Ok");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneNumber", [("name", "FLIP_HA")], [Xml.PCData "0    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_INFO");
    ("label", "Scope Properties"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_APERTURE"); ("label", "Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_FOCAL_LENGTH"); ("label", "Focal Length (mm)");
       ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_APERTURE"); ("label", "Guider Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_FOCAL_LENGTH");
       ("label", "Guider Focal Length (mm)"); ("format", "%g");
       ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_INFO");
    ("label", "Scope Properties"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_APERTURE"); ("label", "Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_FOCAL_LENGTH"); ("label", "Focal Length (mm)");
       ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_APERTURE"); ("label", "Guider Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_FOCAL_LENGTH");
       ("label", "Guider Focal Length (mm)"); ("format", "%g");
       ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "])]);
 Xml.Element
  ("newSwitchVector", [("device", "Focuser Simulator"); ("name", "Mode")],
   [Xml.Element
     ("oneSwitch", [("name", "Absolute")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "Mode"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "All")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Absolute")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "Relative")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Timer")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector", [("device", "Focuser Simulator"); ("name", "Mode")],
   [Xml.Element
     ("oneSwitch", [("name", "Relative")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "Mode"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "All")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Absolute")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Relative")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "Timer")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector", [("device", "Focuser Simulator"); ("name", "Mode")],
   [Xml.Element ("oneSwitch", [("name", "Timer")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "Mode"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "All")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Absolute")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Relative")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Timer")], [Xml.PCData "On    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector", [("device", "Focuser Simulator"); ("name", "Mode")],
   [Xml.Element ("oneSwitch", [("name", "All")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "Mode"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "All")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "Absolute")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Relative")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "Timer")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECTION_TCP")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_ADDRESS");
    ("label", "Server"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defText", [("name", "ADDRESS"); ("label", "Address")], []);
    Xml.Element ("defText", [("name", "PORT"); ("label", "Port")], [])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_ADDRESS");
    ("label", "Server"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defText", [("name", "ADDRESS"); ("label", "Address")], []);
    Xml.Element ("defText", [("name", "PORT"); ("label", "Port")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_TYPE");
    ("label", "Connection Type"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TCP"); ("label", "TCP")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UDP"); ("label", "UDP")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_TYPE");
    ("label", "Connection Type"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TCP"); ("label", "TCP")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UDP"); ("label", "UDP")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("label", "LAN Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("label", "LAN Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT_SCAN");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT_SCAN");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECTION_SERIAL")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONNECTION_TCP")], [Xml.PCData "On    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECTION_SERIAL")],
      [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("label", "System Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "cuwlan-debug"); ("label", "cuwlan-debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "cuBluetooth-Incoming-Port");
       ("label", "cuBluetooth-Incoming-Port")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("label", "System Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "cuwlan-debug"); ("label", "cuwlan-debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "cuBluetooth-Incoming-Port");
       ("label", "cuBluetooth-Incoming-Port")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("label", "Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "PORT"); ("label", "Port")],
      [Xml.PCData "/dev/cuusbserial    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("label", "Ports"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "PORT"); ("label", "Port")],
      [Xml.PCData "/dev/cuusbserial    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("label", "Baud Rate"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "9600"); ("label", "9600")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "19200"); ("label", "19200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "38400"); ("label", "38400")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "57600"); ("label", "57600")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "115200"); ("label", "115200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "230400"); ("label", "230400")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("label", "Baud Rate"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "9600"); ("label", "9600")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "19200"); ("label", "19200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "38400"); ("label", "38400")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "57600"); ("label", "57600")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "115200"); ("label", "115200")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "230400"); ("label", "230400")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("label", "Auto Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("label", "Auto Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT_SCAN");
    ("label", "Refresh"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "Scan Ports"); ("label", "Scan Ports")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT_SCAN");
    ("label", "Refresh"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "Scan Ports"); ("label", "Scan Ports")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_ADDRESS");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_ADDRESS");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_TYPE");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_TYPE");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECTION_SERIAL")], [Xml.PCData "On    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONNECTION_TCP")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECTION_TCP")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_ADDRESS");
    ("label", "Server"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defText", [("name", "ADDRESS"); ("label", "Address")], []);
    Xml.Element ("defText", [("name", "PORT"); ("label", "Port")], [])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_ADDRESS");
    ("label", "Server"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defText", [("name", "ADDRESS"); ("label", "Address")], []);
    Xml.Element ("defText", [("name", "PORT"); ("label", "Port")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_TYPE");
    ("label", "Connection Type"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TCP"); ("label", "TCP")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UDP"); ("label", "UDP")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_TYPE");
    ("label", "Connection Type"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TCP"); ("label", "TCP")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UDP"); ("label", "UDP")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("label", "LAN Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEVICE_LAN_SEARCH");
    ("label", "LAN Search"); ("group", "Connection"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "SYSTEM_PORTS");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_BAUD_RATE");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_AUTO_SEARCH");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT_SCAN");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("delProperty",
   [("device", "Focuser Simulator"); ("name", "DEVICE_PORT_SCAN");
    ("timestamp", "2022-01-01T00:00:00")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION_MODE");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECTION_SERIAL")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONNECTION_TCP")], [Xml.PCData "On    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONFIG_PROCESS")],
   [Xml.Element
     ("oneSwitch", [("name", "CONFIG_LOAD")], [Xml.PCData "      Off  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_SAVE")], [Xml.PCData "      On  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_DEFAULT")], [Xml.PCData "      Off  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_PURGE")], [Xml.PCData "      Off  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Saving device configuration")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Saving device configuration")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Device configuration saved")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Device configuration saved")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONFIG_PROCESS");
    ("state", "Ok"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneSwitch", [("name", "CONFIG_LOAD")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_SAVE")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_DEFAULT")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_PURGE")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector", [("device", "CCD Simulator"); ("name", "DEBUG")],
   [Xml.Element
     ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Debug is enabled")],
   []);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Debug is enabled")],
   []);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("setSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("state", "Ok");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "DISABLE")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector", [("device", "Focuser Simulator"); ("name", "DEBUG")],
   [Xml.Element
     ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Debug is enabled")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Debug is enabled")],
   []);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEBUG"); ("state", "Ok");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "DISABLE")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Telescope Simulator"); ("name", "MOUNT_TYPE")],
   [Xml.Element ("oneSwitch", [("name", "ALTAZ")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Telescope Simulator"); ("name", "MOUNT_TYPE");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "ALTAZ")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "EQ_FORK")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "EQ_GEM")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] update mount and pier side: Pier Side On, mount type 0")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] update mount and pier side: Pier Side On, mount type 0")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] AltAz mount type not implemented yet")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] AltAz mount type not implemented yet")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Telescope Simulator"); ("name", "SIM_PIER_SIDE")],
   [Xml.Element
     ("oneSwitch", [("name", "PS_OFF")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Telescope Simulator"); ("name", "SIM_PIER_SIDE");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "PS_OFF")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "PS_ON")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] update mount and pier side: Pier Side Off, mount type 0")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] update mount and pier side: Pier Side Off, mount type 0")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] AltAz mount type not implemented yet")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] AltAz mount type not implemented yet")],
   []);
 Xml.Element
  ("newSwitchVector", [("device", "Telescope Simulator"); ("name", "DEBUG")],
   [Xml.Element
     ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Debug is enabled")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Debug is enabled")],
   []);
 Xml.Element
  ("defSwitchVector",
   [("device", "Telescope Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_EXTRA_1"); ("label", "Scope Verbose")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Telescope Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_EXTRA_1"); ("label", "Scope Verbose")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Telescope Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_EXTRA_1"); ("label", "Scope Verbose")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Telescope Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_EXTRA_1"); ("label", "Scope Verbose")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Telescope Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Telescope Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("setSwitchVector",
   [("device", "Telescope Simulator"); ("name", "DEBUG"); ("state", "Ok");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "ENABLE")], [Xml.PCData "On    "]);
    Xml.Element ("oneSwitch", [("name", "DISABLE")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Telescope Simulator"); ("name", "CONFIG_PROCESS")],
   [Xml.Element
     ("oneSwitch", [("name", "CONFIG_LOAD")], [Xml.PCData "      Off  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_SAVE")], [Xml.PCData "      On  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_DEFAULT")], [Xml.PCData "      Off  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_PURGE")], [Xml.PCData "      Off  "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Saving device configuration")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Saving device configuration")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Device configuration saved")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] Device configuration saved")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Telescope Simulator"); ("name", "CONFIG_PROCESS");
    ("state", "Ok"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneSwitch", [("name", "CONFIG_LOAD")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_SAVE")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_DEFAULT")], [Xml.PCData "Off    "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_PURGE")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Rotator Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector", [("device", "CCD Simulator"); ("name", "CONNECTION")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("newSwitchVector",
   [("device", "Telescope Simulator"); ("name", "CONNECTION")],
   [Xml.Element
     ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "      On  "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "newSwitchVec _")],
   []);
 Xml.Element
  ("setSwitchVector",
   [("device", "Rotator Simulator"); ("name", "CONNECTION"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "On    "]);
    Xml.Element
     ("oneSwitch", [("name", "DISCONNECT")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Rotator Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("defNumberVector",
   [("device", "Rotator Simulator"); ("name", "ABS_ROTATOR_ANGLE");
    ("label", "Goto"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "ANGLE"); ("label", "Angle"); ("format", "%2f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Rotator Simulator"); ("name", "ABS_ROTATOR_ANGLE");
    ("label", "Goto"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "ANGLE"); ("label", "Angle"); ("format", "%2f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "ROTATOR_ABORT_MOTION");
    ("label", "Abort Motion"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "ROTATOR_ABORT_MOTION");
    ("label", "Abort Motion"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Rotator Simulator"); ("name", "SYNC_ROTATOR_ANGLE");
    ("label", "Sync"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "ANGLE"); ("label", "Angle"); ("format", "%2f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Rotator Simulator"); ("name", "SYNC_ROTATOR_ANGLE");
    ("label", "Sync"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "ANGLE"); ("label", "Angle"); ("format", "%2f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Rotator Simulator"); ("name", "Presets");
    ("label", "Presets"); ("group", "Presets"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PRESET_1"); ("label", "Preset 1"); ("format", "%f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_2"); ("label", "Preset 2"); ("format", "%f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_3"); ("label", "Preset 3"); ("format", "%f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Rotator Simulator"); ("name", "Presets");
    ("label", "Presets"); ("group", "Presets"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PRESET_1"); ("label", "Preset 1"); ("format", "%f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_2"); ("label", "Preset 2"); ("format", "%f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_3"); ("label", "Preset 3"); ("format", "%f");
       ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "Goto"); ("label", "Goto");
    ("group", "Presets"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "Preset 1"); ("label", "Preset 1")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 2"); ("label", "Preset 2")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 3"); ("label", "Preset 3")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Rotator Simulator"); ("name", "Goto"); ("label", "Goto");
    ("group", "Presets"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "Preset 1"); ("label", "Preset 1")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 2"); ("label", "Preset 2")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 3"); ("label", "Preset 3")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("setSwitchVector",
   [("device", "Focuser Simulator"); ("name", "CONNECTION"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "On    "]);
    Xml.Element
     ("oneSwitch", [("name", "DISCONNECT")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_MOTION");
    ("label", "Direction"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FOCUS_INWARD"); ("label", "Focus In")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FOCUS_OUTWARD"); ("label", "Focus Out")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_MOTION");
    ("label", "Direction"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FOCUS_INWARD"); ("label", "Focus In")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FOCUS_OUTWARD"); ("label", "Focus Out")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_SPEED");
    ("label", "Speed"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_SPEED_VALUE"); ("label", "Focus Speed");
       ("format", "%3.0f"); ("min", "1"); ("max", "5"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_SPEED");
    ("label", "Speed"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_SPEED_VALUE"); ("label", "Focus Speed");
       ("format", "%3.0f"); ("min", "1"); ("max", "5"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "REL_FOCUS_POSITION");
    ("label", "Relative Position"); ("group", "Main Control");
    ("state", "Ok"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_RELATIVE_POSITION"); ("label", "Steps");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "REL_FOCUS_POSITION");
    ("label", "Relative Position"); ("group", "Main Control");
    ("state", "Ok"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_RELATIVE_POSITION"); ("label", "Steps");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "ABS_FOCUS_POSITION");
    ("label", "Absolute Position"); ("group", "Main Control");
    ("state", "Ok"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_ABSOLUTE_POSITION"); ("label", "Steps");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "50000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "ABS_FOCUS_POSITION");
    ("label", "Absolute Position"); ("group", "Main Control");
    ("state", "Ok"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_ABSOLUTE_POSITION"); ("label", "Steps");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "50000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_MAX");
    ("label", "Max Position"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_MAX_VALUE"); ("label", "Steps"); ("format", "%f");
       ("min", "1000"); ("max", "1000000"); ("step", "10000")],
      [Xml.PCData "100000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_MAX");
    ("label", "Max Position"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FOCUS_MAX_VALUE"); ("label", "Steps"); ("format", "%f");
       ("min", "1000"); ("max", "1000000"); ("step", "10000")],
      [Xml.PCData "100000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "Presets");
    ("label", "Presets"); ("group", "Presets"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PRESET_1"); ("label", "Preset 1"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_2"); ("label", "Preset 2"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_3"); ("label", "Preset 3"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "Presets");
    ("label", "Presets"); ("group", "Presets"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PRESET_1"); ("label", "Preset 1"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_2"); ("label", "Preset 2"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "PRESET_3"); ("label", "Preset 3"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1000")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "Goto"); ("label", "Goto");
    ("group", "Presets"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "Preset 1"); ("label", "Preset 1")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 2"); ("label", "Preset 2")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 3"); ("label", "Preset 3")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "Goto"); ("label", "Goto");
    ("group", "Presets"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "Preset 1"); ("label", "Preset 1")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 2"); ("label", "Preset 2")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "Preset 3"); ("label", "Preset 3")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "USEJOYSTICK");
    ("label", "Joystick"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "USEJOYSTICK");
    ("label", "Joystick"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "SNOOP_JOYSTICK");
    ("label", "Snoop Joystick"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "SNOOP_JOYSTICK_DEVICE"); ("label", "Device")],
      [Xml.PCData "Joystick    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "Focuser Simulator"); ("name", "SNOOP_JOYSTICK");
    ("label", "Snoop Joystick"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "SNOOP_JOYSTICK_DEVICE"); ("label", "Device")],
      [Xml.PCData "Joystick    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "SEEING_SETTINGS");
    ("label", "Seeing"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_SEEING"); ("label", "arcseconds"); ("format", "%4.2f");
       ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "3.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "SEEING_SETTINGS");
    ("label", "Seeing"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_SEEING"); ("label", "arcseconds"); ("format", "%4.2f");
       ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "3.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FWHM"); ("label", "FWHM");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_FWHM"); ("label", "arcseconds"); ("format", "%4.2f");
       ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "7.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FWHM"); ("label", "FWHM");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_FWHM"); ("label", "arcseconds"); ("format", "%4.2f");
       ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "7.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TEMPERATURE"); ("label", "Celsius"); ("format", "%6.2f");
       ("min", "-50"); ("max", "70"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Focuser Simulator"); ("name", "FOCUS_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TEMPERATURE"); ("label", "Celsius"); ("format", "%6.2f");
       ("min", "-50"); ("max", "70"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("setSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "CONNECT")], [Xml.PCData "On    "]);
    Xml.Element
     ("oneSwitch", [("name", "DISCONNECT")], [Xml.PCData "Off    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_EXPOSURE");
    ("label", "Expose"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_EXPOSURE");
    ("label", "Expose"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME"); ("label", "Frame");
    ("group", "Image Settings"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME"); ("label", "Frame");
    ("group", "Image Settings"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_RESET");
    ("label", "Frame Values"); ("group", "Image Settings");
    ("state", "Idle"); ("perm", "wo"); ("rule", "OneOfMany");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RESET"); ("label", "Reset")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_RESET");
    ("label", "Frame Values"); ("group", "Image Settings");
    ("state", "Idle"); ("perm", "wo"); ("rule", "OneOfMany");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RESET"); ("label", "Reset")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_BINNING");
    ("label", "Binning"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_BINNING");
    ("label", "Binning"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FITS_HEADER");
    ("label", "FITS Header"); ("group", "General Info"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FITS_OBSERVER"); ("label", "Observer")],
      [Xml.PCData "Unknown    "]);
    Xml.Element
     ("defText", [("name", "FITS_OBJECT"); ("label", "Object")],
      [Xml.PCData "Unknown    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FITS_HEADER");
    ("label", "FITS Header"); ("group", "General Info"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FITS_OBSERVER"); ("label", "Observer")],
      [Xml.PCData "Unknown    "]);
    Xml.Element
     ("defText", [("name", "FITS_OBJECT"); ("label", "Object")],
      [Xml.PCData "Unknown    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_EXPOSURE");
    ("label", "Guide Head"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDER_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_EXPOSURE");
    ("label", "Guide Head"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDER_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME");
    ("label", "Frame"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME");
    ("label", "Frame"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "0"); ("max", "0"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_TEMPERATURE_VALUE"); ("label", "Temperature (C)");
       ("format", "%5.2f"); ("min", "-50"); ("max", "50"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_TEMPERATURE_VALUE"); ("label", "Temperature (C)");
       ("format", "%5.2f"); ("min", "-50"); ("max", "50"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COOLER"); ("label", "Cooler");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "wo");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "COOLER_ON"); ("label", "ON")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "COOLER_OFF"); ("label", "OFF")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COOLER"); ("label", "Cooler");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "wo");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "COOLER_ON"); ("label", "ON")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "COOLER_OFF"); ("label", "OFF")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_GAIN"); ("label", "Gain");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GAIN"); ("label", "value"); ("format", "%f"); ("min", "0");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "90    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_GAIN"); ("label", "Gain");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GAIN"); ("label", "value"); ("format", "%f"); ("min", "0");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "90    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_OFFSET"); ("label", "Offset");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "OFFSET"); ("label", "value"); ("format", "%f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_OFFSET"); ("label", "Offset");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "OFFSET"); ("label", "value"); ("format", "%f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "CCD_DIRECTORY_LOCATION");
    ("label", "Directory"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "LOCATION"); ("label", "Location")],
      [Xml.PCData "/Users/jonathan    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "CCD_DIRECTORY_LOCATION");
    ("label", "Directory"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "LOCATION"); ("label", "Location")],
      [Xml.PCData "/Users/jonathan    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "GUIDE_RATE");
    ("label", "Guiding Rate"); ("group", "Motion Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDE_RATE_WE"); ("label", "W/E Rate"); ("format", "%g");
       ("min", "0"); ("max", "1"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDE_RATE_NS"); ("label", "N/S Rate"); ("format", "%g");
       ("min", "0"); ("max", "1"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "GUIDE_RATE");
    ("label", "Guiding Rate"); ("group", "Motion Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDE_RATE_WE"); ("label", "W/E Rate"); ("format", "%g");
       ("min", "0"); ("max", "1"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDE_RATE_NS"); ("label", "N/S Rate"); ("format", "%g");
       ("min", "0"); ("max", "1"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.5    "])]);
 Xml.Element
  ("setNumberVector",
   [("device", "Telescope Simulator"); ("name", "GUIDE_RATE");
    ("state", "Ok"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneNumber", [("name", "GUIDE_RATE_WE")], [Xml.PCData "0.5    "]);
    Xml.Element
     ("oneNumber", [("name", "GUIDE_RATE_NS")], [Xml.PCData "0.5    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("setNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneNumber",
      [("name", "X"); ("min", "0"); ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber",
      [("name", "Y"); ("min", "0"); ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber",
      [("name", "WIDTH"); ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("oneNumber",
      [("name", "HEIGHT"); ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("setNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("state", "Idle");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneNumber", [("name", "CCD_MAX_X")], [Xml.PCData "500    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_MAX_Y")], [Xml.PCData "290    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE")], [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE_X")], [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE_Y")], [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_BITSPERPIXEL")], [Xml.PCData "0    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("setNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME"); ("state", "Idle");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneNumber",
      [("name", "X"); ("min", "0"); ("max", "499"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber",
      [("name", "Y"); ("min", "0"); ("max", "289"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber",
      [("name", "WIDTH"); ("min", "1"); ("max", "500"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("oneNumber",
      [("name", "HEIGHT"); ("min", "1"); ("max", "290"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("setNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME"); ("state", "Idle");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneNumber", [("name", "X")], [Xml.PCData "0    "]);
    Xml.Element ("oneNumber", [("name", "Y")], [Xml.PCData "0    "]);
    Xml.Element ("oneNumber", [("name", "WIDTH")], [Xml.PCData "500    "]);
    Xml.Element ("oneNumber", [("name", "HEIGHT")], [Xml.PCData "290    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("setNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("state", "Idle");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneNumber", [("name", "CCD_MAX_X")], [Xml.PCData "500    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_MAX_Y")], [Xml.PCData "290    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE_X")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE_Y")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_BITSPERPIXEL")], [Xml.PCData "0    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("setNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("state", "Idle");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneNumber", [("name", "CCD_MAX_X")], [Xml.PCData "500    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_MAX_Y")], [Xml.PCData "290    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE_X")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_PIXEL_SIZE_Y")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("oneNumber", [("name", "CCD_BITSPERPIXEL")], [Xml.PCData "16    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FILTER_SLOT");
    ("label", "Filter Slot"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FILTER_SLOT_VALUE"); ("label", "Filter");
       ("format", "%3.0f"); ("min", "1"); ("max", "8"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FILTER_SLOT");
    ("label", "Filter Slot"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FILTER_SLOT_VALUE"); ("label", "Filter");
       ("format", "%3.0f"); ("min", "1"); ("max", "8"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("enableBLOB", [("device", "CCD Simulator"); ("name", "CCD1")],
   [Xml.PCData "Only"]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%.2f"); ("min", "0.010000000000000000208");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "1"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%.2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0"])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off"])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max. Width"); ("format", "%.f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max. Height"); ("format", "%.f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%.f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16"])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Ok"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("getProperties", [("version", "1.7"); ("device", "CCD Simulator")], []);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%.2f"); ("min", "0.010000000000000000208");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "1"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%.2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0"])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off"])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max. Width"); ("format", "%.f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max. Height"); ("format", "%.f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%.f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16"])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Ok"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "General Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "CCD Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_ccd    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "22    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "General Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "CCD Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_ccd    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "22    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "General Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "CCD Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_ccd    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "22    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "General Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "CCD Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_ccd    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "22    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMP_RAMP");
    ("label", "Temp Ramp"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RAMP_SLOPE"); ("label", "Max dT (C/min)"); ("format", "%f");
       ("min", "0"); ("max", "30"); ("step", "1")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "RAMP_THRESHOLD"); ("label", "Threshold (C)");
       ("format", "%1f"); ("min", "0.10000000000000000555"); ("max", "2");
       ("step", "0.10000000000000000555")],
      [Xml.PCData "0.2000000000000000111    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMP_RAMP");
    ("label", "Temp Ramp"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RAMP_SLOPE"); ("label", "Max dT (C/min)"); ("format", "%f");
       ("min", "0"); ("max", "30"); ("step", "1")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "RAMP_THRESHOLD"); ("label", "Threshold (C)");
       ("format", "%1f"); ("min", "0.10000000000000000555"); ("max", "2");
       ("step", "0.10000000000000000555")],
      [Xml.PCData "0.2000000000000000111    "])]);
 Xml.Element
  ("enableBLOB", [("device", "CCD Simulator"); ("name", "CCD2")],
   [Xml.PCData "Only"]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%.2f"); ("min", "0.010000000000000000208");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "1"]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%.2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0"])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator"]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off"])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max. Width"); ("format", "%.f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max. Height"); ("format", "%.f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188"]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%.f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16"])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Ok"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
(*
 Xml.Element
  ("newSwitchVector",
   [("device",
     "<defSwitchVector device=\"CCD Simulator\" name=\"CONFIG_PROCESS\" label=\"Configuration\" group=\"Options\" state=\"Idle\" perm=\"rw\" rule=\"AtMostOne\" timeout=\"0\" timestamp=\"2022-06-15T18:47:04\">    <defSwitch name=\"CONFIG_LOAD\" label=\"Load\">Off    </defSwitch>    <defSwitch name=\"CONFIG_SAVE\" label=\"Save\">Off    </defSwitch>    <defSwitch name=\"CONFIG_DEFAULT\" label=\"Default\">Off    </defSwitch>    <defSwitch name=\"CONFIG_PURGE\" label=\"Purge\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CONFIG_PROCESS\" label=\"Configuration\" group=\"Options\" state=\"Idle\" perm=\"rw\" rule=\"AtMostOne\" timeout=\"0\" timestamp=\"2022-06-15T18:47:04\">    <defSwitch name=\"CONFIG_LOAD\" label=\"Load\">Off    </defSwitch>    <defSwitch name=\"CONFIG_SAVE\" label=\"Save\">Off    </defSwitch>    <defSwitch name=\"CONFIG_DEFAULT\" label=\"Default\">Off    </defSwitch>    <defSwitch name=\"CONFIG_PURGE\" label=\"Purge\">Off    </defSwitch></defSwitchVector>Rotator Simulator");
    ("name", "CONFIG_PROCESS")],
   [Xml.Element
     ("oneSwitch", [("name", "CONFIG_LOAD")], [Xml.PCData "      On  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_SAVE")], [Xml.PCData "      Off  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_DEFAULT")], [Xml.PCData "      Off  "]);
    Xml.Element
     ("oneSwitch", [("name", "CONFIG_PURGE")], [Xml.PCData "      Off  "])]);
 Xml.Element
  ("message",
   [("device",
     "<defSwitchVector device=\"CCD Simulator\" name=\"CONFIG_PROCESS\" label=\"Configuration\" group=\"Options\" state=\"Idle\" perm=\"rw\" rule=\"AtMostOne\" timeout=\"0\" timestamp=\"2022-06-15T18:47:04\">    <defSwitch name=\"CONFIG_LOAD\" label=\"Load\">Off    </defSwitch>    <defSwitch name=\"CONFIG_SAVE\" label=\"Save\">Off    </defSwitch>    <defSwitch name=\"CONFIG_DEFAULT\" label=\"Default\">Off    </defSwitch>    <defSwitch name=\"CONFIG_PURGE\" label=\"Purge\">Off    </defSwitch></defSwitchVector><defSwitchVector device=\"CCD Simulator\" name=\"CONFIG_PROCESS\" label=\"Configuration\" group=\"Options\" state=\"Idle\" perm=\"rw\" rule=\"AtMostOne\" timeout=\"0\" timestamp=\"2022-06-15T18:47:04\">    <defSwitch name=\"CONFIG_LOAD\" label=\"Load\">Off    </defSwitch>    <defSwitch name=\"CONFIG_SAVE\" label=\"Save\">Off    </defSwitch>    <defSwitch name=\"CONFIG_DEFAULT\" label=\"Default\">Off    </defSwitch>    <defSwitch name=\"CONFIG_PURGE\" label=\"Purge\">Off    </defSwitch></defSwitchVector>Rotator Simulator");
    ("timestamp", "2022-01-01T00:00:00"); ("message", "newSwitchVec _")],
   []);
*)
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_CAPTURE_FORMAT");
    ("label", "Format"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_MONO"); ("label", "Mono")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_CAPTURE_FORMAT");
    ("label", "Format"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_MONO"); ("label", "Mono")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("label", "Info");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "290    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%3.0f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("label", "Info");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "290    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%3.0f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIM_FOCUSING");
    ("label", "Focus Simulation"); ("group", "Simulator Config");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_POSITION"); ("label", "Focus"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "36700    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_MAX"); ("label", "Max Position");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "100000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SEEING"); ("label", "Seeing (arcsec)");
       ("format", "%4.2f"); ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "3.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIM_FOCUSING");
    ("label", "Focus Simulation"); ("group", "Simulator Config");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_POSITION"); ("label", "Focus"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "36700    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_MAX"); ("label", "Max Position");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "100000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SEEING"); ("label", "Seeing (arcsec)");
       ("format", "%4.2f"); ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "3.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIM_FOCUSING");
    ("label", "Focus Simulation"); ("group", "Simulator Config");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_POSITION"); ("label", "Focus"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "36700    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_MAX"); ("label", "Max Position");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "100000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SEEING"); ("label", "Seeing (arcsec)");
       ("format", "%4.2f"); ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "3.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIM_FOCUSING");
    ("label", "Focus Simulation"); ("group", "Simulator Config");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_POSITION"); ("label", "Focus"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "36700    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_FOCUS_MAX"); ("label", "Max Position");
       ("format", "%f"); ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "100000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SEEING"); ("label", "Seeing (arcsec)");
       ("format", "%4.2f"); ("min", "0"); ("max", "60"); ("step", "0")],
      [Xml.PCData "3.5    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "SIMULATE_BAYER");
    ("label", "Bayer"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "SIMULATE_BAYER");
    ("label", "Bayer"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "SIMULATE_BAYER");
    ("label", "Bayer"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "SIMULATE_BAYER");
    ("label", "Bayer"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_SIMULATE_CRASH");
    ("label", "Crash"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "wo"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CRASH"); ("label", "Crash driver")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_SIMULATE_CRASH");
    ("label", "Crash"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "wo"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CRASH"); ("label", "Crash driver")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_SIMULATE_CRASH");
    ("label", "Crash"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "wo"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CRASH"); ("label", "Crash driver")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_SIMULATE_CRASH");
    ("label", "Crash"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "wo"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CRASH"); ("label", "Crash driver")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG_LEVEL");
    ("label", "Debug Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DBG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DBG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOGGING_LEVEL");
    ("label", "Logging Levels"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "LOG_ERROR"); ("label", "Errors")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_WARNING"); ("label", "Warnings")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_SESSION"); ("label", "Messages")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "LOG_DEBUG"); ("label", "Driver Debug")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "LOG_OUTPUT");
    ("label", "Log Output"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AnyOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CLIENT_DEBUG"); ("label", "To Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FILE_DEBUG"); ("label", "To Log File")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_EXPOSURE");
    ("label", "Expose"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_EXPOSURE");
    ("label", "Expose"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_EXPOSURE");
    ("label", "Expose"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_EXPOSURE");
    ("label", "Expose"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME"); ("label", "Frame");
    ("group", "Image Settings"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME"); ("label", "Frame");
    ("group", "Image Settings"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME"); ("label", "Frame");
    ("group", "Image Settings"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME"); ("label", "Frame");
    ("group", "Image Settings"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_RESET");
    ("label", "Frame Values"); ("group", "Image Settings");
    ("state", "Idle"); ("perm", "wo"); ("rule", "OneOfMany");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RESET"); ("label", "Reset")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_RESET");
    ("label", "Frame Values"); ("group", "Image Settings");
    ("state", "Idle"); ("perm", "wo"); ("rule", "OneOfMany");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RESET"); ("label", "Reset")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_BINNING");
    ("label", "Binning"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_BINNING");
    ("label", "Binning"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_RESET");
    ("label", "Frame Values"); ("group", "Image Settings");
    ("state", "Idle"); ("perm", "wo"); ("rule", "OneOfMany");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RESET"); ("label", "Reset")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_RESET");
    ("label", "Frame Values"); ("group", "Image Settings");
    ("state", "Idle"); ("perm", "wo"); ("rule", "OneOfMany");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RESET"); ("label", "Reset")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_BINNING");
    ("label", "Binning"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_BINNING");
    ("label", "Binning"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FITS_HEADER");
    ("label", "FITS Header"); ("group", "General Info"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FITS_OBSERVER"); ("label", "Observer")],
      [Xml.PCData "Unknown    "]);
    Xml.Element
     ("defText", [("name", "FITS_OBJECT"); ("label", "Object")],
      [Xml.PCData "Unknown    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FITS_HEADER");
    ("label", "FITS Header"); ("group", "General Info"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FITS_OBSERVER"); ("label", "Observer")],
      [Xml.PCData "Unknown    "]);
    Xml.Element
     ("defText", [("name", "FITS_OBJECT"); ("label", "Object")],
      [Xml.PCData "Unknown    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_EXPOSURE");
    ("label", "Guide Head"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDER_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_EXPOSURE");
    ("label", "Guide Head"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDER_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME");
    ("label", "Frame"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "499"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "289"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "500"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "290"); ("step", "0")],
      [Xml.PCData "290    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME");
    ("label", "Frame"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "499"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "289"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "500"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "290"); ("step", "0")],
      [Xml.PCData "290    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_TEMPERATURE_VALUE"); ("label", "Temperature (C)");
       ("format", "%5.2f"); ("min", "-50"); ("max", "50"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_TEMPERATURE_VALUE"); ("label", "Temperature (C)");
       ("format", "%5.2f"); ("min", "-50"); ("max", "50"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMP_RAMP");
    ("label", "Temp Ramp"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RAMP_SLOPE"); ("label", "Max dT (C/min)"); ("format", "%f");
       ("min", "0"); ("max", "30"); ("step", "1")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "RAMP_THRESHOLD"); ("label", "Threshold (C)");
       ("format", "%1f"); ("min", "0.10000000000000000555"); ("max", "2");
       ("step", "0.10000000000000000555")],
      [Xml.PCData "0.2000000000000000111    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMP_RAMP");
    ("label", "Temp Ramp"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RAMP_SLOPE"); ("label", "Max dT (C/min)"); ("format", "%f");
       ("min", "0"); ("max", "30"); ("step", "1")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "RAMP_THRESHOLD"); ("label", "Threshold (C)");
       ("format", "%1f"); ("min", "0.10000000000000000555"); ("max", "2");
       ("step", "0.10000000000000000555")],
      [Xml.PCData "0.2000000000000000111    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_CAPTURE_FORMAT");
    ("label", "Format"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_MONO"); ("label", "Mono")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_CAPTURE_FORMAT");
    ("label", "Format"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_MONO"); ("label", "Mono")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAM_DELAY");
    ("label", "Video Stream Delay"); ("group", "Streaming");
    ("state", "Idle"); ("perm", "ro"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAM_DELAY_TIME"); ("label", "Delay (s)");
       ("format", "%3f"); ("min", "0"); ("max", "60");
       ("step", "0.0010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAM_DELAY");
    ("label", "Video Stream Delay"); ("group", "Streaming");
    ("state", "Idle"); ("perm", "ro"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAM_DELAY_TIME"); ("label", "Delay (s)");
       ("format", "%3f"); ("min", "0"); ("max", "60");
       ("step", "0.0010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FITS_HEADER");
    ("label", "FITS Header"); ("group", "General Info"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FITS_OBSERVER"); ("label", "Observer")],
      [Xml.PCData "Unknown    "]);
    Xml.Element
     ("defText", [("name", "FITS_OBJECT"); ("label", "Object")],
      [Xml.PCData "Unknown    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FITS_HEADER");
    ("label", "FITS Header"); ("group", "General Info"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FITS_OBSERVER"); ("label", "Observer")],
      [Xml.PCData "Unknown    "]);
    Xml.Element
     ("defText", [("name", "FITS_OBJECT"); ("label", "Object")],
      [Xml.PCData "Unknown    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_EXPOSURE");
    ("label", "Guide Head"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDER_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_EXPOSURE");
    ("label", "Guide Head"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GUIDER_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%5.2f"); ("min", "0.010000000000000000208");
       ("max", "3600"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_ABORT_EXPOSURE");
    ("label", "Abort"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ABORT"); ("label", "Abort")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME");
    ("label", "Frame"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "499"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "289"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "500"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "290"); ("step", "0")],
      [Xml.PCData "290    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME");
    ("label", "Frame"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left "); ("format", "%4.0f"); ("min", "0");
       ("max", "499"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%4.0f"); ("min", "0");
       ("max", "289"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "500"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "290"); ("step", "0")],
      [Xml.PCData "290    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_TEMPERATURE_VALUE"); ("label", "Temperature (C)");
       ("format", "%5.2f"); ("min", "-50"); ("max", "50"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMPERATURE");
    ("label", "Temperature"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_TEMPERATURE_VALUE"); ("label", "Temperature (C)");
       ("format", "%5.2f"); ("min", "-50"); ("max", "50"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMP_RAMP");
    ("label", "Temp Ramp"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RAMP_SLOPE"); ("label", "Max dT (C/min)"); ("format", "%f");
       ("min", "0"); ("max", "30"); ("step", "1")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "RAMP_THRESHOLD"); ("label", "Threshold (C)");
       ("format", "%1f"); ("min", "0.10000000000000000555"); ("max", "2");
       ("step", "0.10000000000000000555")],
      [Xml.PCData "0.2000000000000000111    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_TEMP_RAMP");
    ("label", "Temp Ramp"); ("group", "Main Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RAMP_SLOPE"); ("label", "Max dT (C/min)"); ("format", "%f");
       ("min", "0"); ("max", "30"); ("step", "1")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "RAMP_THRESHOLD"); ("label", "Threshold (C)");
       ("format", "%1f"); ("min", "0.10000000000000000555"); ("max", "2");
       ("step", "0.10000000000000000555")],
      [Xml.PCData "0.2000000000000000111    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_CAPTURE_FORMAT");
    ("label", "Format"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_MONO"); ("label", "Mono")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_CAPTURE_FORMAT");
    ("label", "Format"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_MONO"); ("label", "Mono")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("label", "Info");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "290    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%3.0f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("label", "Info");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "290    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%3.0f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAM_DELAY");
    ("label", "Video Stream Delay"); ("group", "Streaming");
    ("state", "Idle"); ("perm", "ro"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAM_DELAY_TIME"); ("label", "Delay (s)");
       ("format", "%3f"); ("min", "0"); ("max", "60");
       ("step", "0.0010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAM_DELAY");
    ("label", "Video Stream Delay"); ("group", "Streaming");
    ("state", "Idle"); ("perm", "ro"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAM_DELAY_TIME"); ("label", "Delay (s)");
       ("format", "%3f"); ("min", "0"); ("max", "60");
       ("step", "0.0010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COOLER"); ("label", "Cooler");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "wo");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "COOLER_ON"); ("label", "ON")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "COOLER_OFF"); ("label", "OFF")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COOLER"); ("label", "Cooler");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "wo");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "COOLER_ON"); ("label", "ON")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "COOLER_OFF"); ("label", "OFF")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_GAIN"); ("label", "Gain");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GAIN"); ("label", "value"); ("format", "%f"); ("min", "0");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "90    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_GAIN"); ("label", "Gain");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GAIN"); ("label", "value"); ("format", "%f"); ("min", "0");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "90    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FILTER_SLOT");
    ("label", "Filter Slot"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FILTER_SLOT_VALUE"); ("label", "Filter");
       ("format", "%3.0f"); ("min", "1"); ("max", "8"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FILTER_SLOT");
    ("label", "Filter Slot"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FILTER_SLOT_VALUE"); ("label", "Filter");
       ("format", "%3.0f"); ("min", "1"); ("max", "8"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FILTER_NAME");
    ("label", "Filter"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_1"); ("label", "Red")],
      [Xml.PCData "Red    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_2"); ("label", "Green")],
      [Xml.PCData "Green    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_3"); ("label", "Blue")],
      [Xml.PCData "Blue    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_4"); ("label", "H_Alpha")],
      [Xml.PCData "H_Alpha    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_5"); ("label", "SII")],
      [Xml.PCData "SII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_6"); ("label", "OIII")],
      [Xml.PCData "OIII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_7"); ("label", "LPR")],
      [Xml.PCData "LPR    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_8"); ("label", "Luminance")],
      [Xml.PCData "Luminance    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FILTER_NAME");
    ("label", "Filter"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_1"); ("label", "Red")],
      [Xml.PCData "Red    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_2"); ("label", "Green")],
      [Xml.PCData "Green    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_3"); ("label", "Blue")],
      [Xml.PCData "Blue    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_4"); ("label", "H_Alpha")],
      [Xml.PCData "H_Alpha    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_5"); ("label", "SII")],
      [Xml.PCData "SII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_6"); ("label", "OIII")],
      [Xml.PCData "OIII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_7"); ("label", "LPR")],
      [Xml.PCData "LPR    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_8"); ("label", "Luminance")],
      [Xml.PCData "Luminance    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("setTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneText", [("name", "ACTIVE_TELESCOPE")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("oneText", [("name", "ACTIVE_ROTATOR")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("oneText", [("name", "ACTIVE_FOCUSER")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element ("oneText", [("name", "ACTIVE_FILTER")], []);
    Xml.Element
     ("oneText", [("name", "ACTIVE_SKYQUALITY")], [Xml.PCData "SQM    "])]);
 Xml.Element
  ("message",
   [("device", "CCD Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setTextVec active")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Telescope Simulator");
    ("name", "EQUATORIAL_EOD_COORD")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Telescope Simulator has no property EQUATORIAL_EOD_COORD")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Telescope Simulator");
    ("name", "EQUATORIAL_COORD")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Telescope Simulator has no property EQUATORIAL_COORD")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Telescope Simulator");
    ("name", "TELESCOPE_INFO")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Telescope Simulator has no property TELESCOPE_INFO")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Telescope Simulator");
    ("name", "GEOGRAPHIC_COORD")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Telescope Simulator has no property GEOGRAPHIC_COORD")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Rotator Simulator");
    ("name", "ABS_ROTATOR_ANGLE")],
   []);
 Xml.Element
  ("message",
   [("device", "Rotator Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Rotator Simulator has no property ABS_ROTATOR_ANGLE")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Focuser Simulator");
    ("name", "ABS_FOCUS_POSITION")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Focuser Simulator has no property ABS_FOCUS_POSITION")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Focuser Simulator");
    ("name", "FOCUS_TEMPERATURE")],
   []);
 Xml.Element
  ("message",
   [("device", "Focuser Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Focuser Simulator has no property FOCUS_TEMPERATURE")],
   []);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COOLER"); ("label", "Cooler");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "wo");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "COOLER_ON"); ("label", "ON")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "COOLER_OFF"); ("label", "OFF")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COOLER"); ("label", "Cooler");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "wo");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "COOLER_ON"); ("label", "ON")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "COOLER_OFF"); ("label", "OFF")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_GAIN"); ("label", "Gain");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GAIN"); ("label", "value"); ("format", "%f"); ("min", "0");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "90    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_GAIN"); ("label", "Gain");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "GAIN"); ("label", "value"); ("format", "%f"); ("min", "0");
       ("max", "100"); ("step", "10")],
      [Xml.PCData "90    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_OFFSET"); ("label", "Offset");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "OFFSET"); ("label", "value"); ("format", "%f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_OFFSET"); ("label", "Offset");
    ("group", "Main Control"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "OFFSET"); ("label", "value"); ("format", "%f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "CCD_DIRECTORY_LOCATION");
    ("label", "Directory"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "LOCATION"); ("label", "Location")],
      [Xml.PCData "/Users/jonathan    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "CCD_DIRECTORY_LOCATION");
    ("label", "Directory"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "LOCATION"); ("label", "Location")],
      [Xml.PCData "/Users/jonathan    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_DIRECTORY_TOGGLE");
    ("label", "Use Dir"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_DIRECTORY_TOGGLE");
    ("label", "Use Dir"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FILTER_SLOT");
    ("label", "Filter Slot"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FILTER_SLOT_VALUE"); ("label", "Filter");
       ("format", "%3.0f"); ("min", "1"); ("max", "8"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FILTER_SLOT");
    ("label", "Filter Slot"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FILTER_SLOT_VALUE"); ("label", "Filter");
       ("format", "%3.0f"); ("min", "1"); ("max", "8"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FILTER_NAME");
    ("label", "Filter"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_1"); ("label", "Red")],
      [Xml.PCData "Red    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_2"); ("label", "Green")],
      [Xml.PCData "Green    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_3"); ("label", "Blue")],
      [Xml.PCData "Blue    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_4"); ("label", "H_Alpha")],
      [Xml.PCData "H_Alpha    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_5"); ("label", "SII")],
      [Xml.PCData "SII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_6"); ("label", "OIII")],
      [Xml.PCData "OIII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_7"); ("label", "LPR")],
      [Xml.PCData "LPR    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_8"); ("label", "Luminance")],
      [Xml.PCData "Luminance    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "FILTER_NAME");
    ("label", "Filter"); ("group", "Filter Wheel"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_1"); ("label", "Red")],
      [Xml.PCData "Red    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_2"); ("label", "Green")],
      [Xml.PCData "Green    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_3"); ("label", "Blue")],
      [Xml.PCData "Blue    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_4"); ("label", "H_Alpha")],
      [Xml.PCData "H_Alpha    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_5"); ("label", "SII")],
      [Xml.PCData "SII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_6"); ("label", "OIII")],
      [Xml.PCData "OIII    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_7"); ("label", "LPR")],
      [Xml.PCData "LPR    "]);
    Xml.Element
     ("defText", [("name", "FILTER_SLOT_NAME_8"); ("label", "Luminance")],
      [Xml.PCData "Luminance    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "SQM"); ("name", "SKY_QUALITY")], 
   []);
 Xml.Element
  ("message",
   [("device", "SQM"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "[INFO] device SQM has no property SKY_QUALITY")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Telescope Simulator");
    ("name", "EQUATORIAL_EOD_COORD")],
   []);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message",
     "[INFO] device Telescope Simulator has no property EQUATORIAL_EOD_COORD")],
   []);
 Xml.Element
  ("getProperties",
   [("version", "1.7"); ("device", "Focuser Simulator"); ("name", "FWHM")],
   []);
 Xml.Element
  ("defSwitchVector",
   [("device", "Focuser Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off"]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "On"])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_SPECTRUM");
    ("label", "Spectrum"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_HISTOGRAM");
    ("label", "Histogram"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_WAVELETS");
    ("label", "Wavelets"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONNECTION");
    ("label", "Connection"); ("group", "Main Control"); ("state", "Ok");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONNECT"); ("label", "Connect")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISCONNECT"); ("label", "Disconnect")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "General Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "CCD Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_ccd    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "22    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "DRIVER_INFO");
    ("label", "Driver Info"); ("group", "General Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "DRIVER_NAME"); ("label", "Name")],
      [Xml.PCData "CCD Simulator    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_EXEC"); ("label", "Exec")],
      [Xml.PCData "indi_simulator_ccd    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_VERSION"); ("label", "Version")],
      [Xml.PCData "1.0    "]);
    Xml.Element
     ("defText", [("name", "DRIVER_INTERFACE"); ("label", "Interface")],
      [Xml.PCData "22    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "POLLING_PERIOD");
    ("label", "Polling"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "PERIOD_MS"); ("label", "Period (ms)"); ("format", "%f");
       ("min", "10"); ("max", "600000"); ("step", "1000")],
      [Xml.PCData "1000    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DEBUG"); ("label", "Debug");
    ("group", "Options"); ("state", "Ok"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "ENABLE"); ("label", "Enable")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "DISABLE"); ("label", "Disable")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CONFIG_PROCESS");
    ("label", "Configuration"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "AtMostOne"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "CONFIG_LOAD"); ("label", "Load")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_SAVE"); ("label", "Save")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_DEFAULT"); ("label", "Default")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "CONFIG_PURGE"); ("label", "Purge")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "ACTIVE_DEVICES");
    ("label", "Snoop devices"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "ACTIVE_TELESCOPE"); ("label", "Telescope")],
      [Xml.PCData "Telescope Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_ROTATOR"); ("label", "Rotator")],
      [Xml.PCData "Rotator Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FOCUSER"); ("label", "Focuser")],
      [Xml.PCData "Focuser Simulator    "]);
    Xml.Element
     ("defText", [("name", "ACTIVE_FILTER"); ("label", "Filter")], []);
    Xml.Element
     ("defText", [("name", "ACTIVE_SKYQUALITY"); ("label", "Sky Quality")],
      [Xml.PCData "SQM    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "SIMULATOR_SETTINGS");
    ("label", "Settings"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "SIM_XRES"); ("label", "CCD X resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YRES"); ("label", "CCD Y resolution");
       ("format", "%4.0f"); ("min", "512"); ("max", "8192"); ("step", "512")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_XSIZE"); ("label", "CCD X Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_YSIZE"); ("label", "CCD Y Pixel Size");
       ("format", "%4.2f"); ("min", "1"); ("max", "30"); ("step", "5")],
      [Xml.PCData "5.2000000000000001776    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_MAXVAL"); ("label", "CCD Maximum ADU");
       ("format", "%4.0f"); ("min", "255"); ("max", "65000");
       ("step", "1000")],
      [Xml.PCData "65000    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SATURATION"); ("label", "Saturation Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_LIMITINGMAG"); ("label", "Limiting Mag");
       ("format", "%4.1f"); ("min", "0"); ("max", "20"); ("step", "1")],
      [Xml.PCData "17    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_NOISE"); ("label", "CCD Noise"); ("format", "%4.0f");
       ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "10    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_SKYGLOW"); ("label", "Sky Glow (magnitudes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "19.5    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_OAGOFFSET"); ("label", "Oag Offset (arcminutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLAR"); ("label", "PAE (arcminutes)");
       ("format", "%4.1f"); ("min", "-600"); ("max", "600"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_POLARDRIFT"); ("label", "PAE Drift (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEPERIOD"); ("label", "PE Period (minutes)");
       ("format", "%4.1f"); ("min", "0"); ("max", "60"); ("step", "5")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_PEMAX"); ("label", "PE Max (arcsec)");
       ("format", "%4.1f"); ("min", "0"); ("max", "6000"); ("step", "500")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_TIME_FACTOR"); ("label", "Time Factor (x)");
       ("format", "%2f"); ("min", "0.010000000000000000208"); ("max", "100");
       ("step", "10")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "SIM_ROTATION"); ("label", "CCD Rotation");
       ("format", "%2f"); ("min", "0"); ("max", "360"); ("step", "10")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "EQUATORIAL_PE");
    ("label", "EQ PE"); ("group", "Simulator Config"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA_PE"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC_PE"); ("label", "DEC (dd:mm:ss)");
       ("format", "%010.6m"); ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_TRANSFER_FORMAT");
    ("label", "Encode"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FORMAT_FITS"); ("label", "FITS")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FORMAT_NATIVE"); ("label", "Native")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_INFO");
    ("label", "CCD Information"); ("group", "Image Info"); ("state", "Idle");
    ("perm", "ro"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "1024    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "5.1999998092651367188    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("label", "Info");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "290    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%3.0f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_INFO"); ("label", "Info");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_X"); ("label", "Max Width"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "500    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_MAX_Y"); ("label", "Max Height"); ("format", "%4.0f");
       ("min", "1"); ("max", "16000"); ("step", "0")],
      [Xml.PCData "290    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE"); ("label", "Pixel size (um)");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_X"); ("label", "Pixel size X");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "9.8000001907348632812    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_PIXEL_SIZE_Y"); ("label", "Pixel size Y");
       ("format", "%5.2f"); ("min", "1"); ("max", "40"); ("step", "0")],
      [Xml.PCData "12.600000381469726562    "]);
    Xml.Element
     ("defNumber",
      [("name", "CCD_BITSPERPIXEL"); ("label", "Bits per pixel");
       ("format", "%3.0f"); ("min", "8"); ("max", "64"); ("step", "0")],
      [Xml.PCData "16    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_BINNING");
    ("label", "Binning"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "HOR_BIN"); ("label", "X"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "VER_BIN"); ("label", "Y"); ("format", "%2.0f");
       ("min", "1"); ("max", "4"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_COMPRESSION");
    ("label", "Compression"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD1"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("defBLOB", [("name", "CCD1"); ("label", "Image")], [])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_COMPRESSION");
    ("label", "Compression"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defBLOBVector",
   [("device", "CCD Simulator"); ("name", "CCD2"); ("label", "Image Data");
    ("group", "Image Info"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defBLOB", [("name", "CCD2"); ("label", "Guider Image")], [])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_NS");
    ("label", "Guide N/S"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_N"); ("label", "North (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_S"); ("label", "South (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TIMED_GUIDE_WE");
    ("label", "Guide E/W"); ("group", "Guider Control"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_W"); ("label", "West (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "TIMED_GUIDE_E"); ("label", "East (ms)"); ("format", "%f");
       ("min", "0"); ("max", "60000"); ("step", "100")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FRAME_TYPE");
    ("label", "Type"); ("group", "Image Settings"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "GUIDER_FRAME_TYPE");
    ("label", "Type"); ("group", "Guider Head"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "FRAME_LIGHT"); ("label", "Light")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_BIAS"); ("label", "Bias")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_DARK"); ("label", "Dark")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "FRAME_FLAT"); ("label", "Flat")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "TELESCOPE_TYPE");
    ("label", "Telescope"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "TELESCOPE_PRIMARY"); ("label", "Primary")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "TELESCOPE_GUIDE"); ("label", "Guide")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "WCS_CONTROL"); ("label", "WCS");
    ("group", "WCS"); ("state", "Idle"); ("perm", "rw");
    ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "WCS_ENABLE"); ("label", "Enable")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "WCS_DISABLE"); ("label", "Disable")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_MODE");
    ("label", "Upload"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "UPLOAD_CLIENT"); ("label", "Client")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_LOCAL"); ("label", "Local")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "UPLOAD_BOTH"); ("label", "Both")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "UPLOAD_SETTINGS");
    ("label", "Upload Settings"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "UPLOAD_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan    "]);
    Xml.Element
     ("defText", [("name", "UPLOAD_PREFIX"); ("label", "Prefix")],
      [Xml.PCData "IMAGE_XXX    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_TOGGLE");
    ("label", "Fast Exposure"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "INDI_ENABLED"); ("label", "Enabled")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "INDI_DISABLED"); ("label", "Disabled")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_FAST_COUNT");
    ("label", "Fast Count"); ("group", "Options"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "FRAMES"); ("label", "Frames"); ("format", "%f");
       ("min", "0"); ("max", "100000"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAM_DELAY");
    ("label", "Video Stream Delay"); ("group", "Streaming");
    ("state", "Idle"); ("perm", "ro"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAM_DELAY_TIME"); ("label", "Delay (s)");
       ("format", "%3f"); ("min", "0"); ("max", "60");
       ("step", "0.0010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAM_DELAY");
    ("label", "Video Stream Delay"); ("group", "Streaming");
    ("state", "Idle"); ("perm", "ro"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAM_DELAY_TIME"); ("label", "Delay (s)");
       ("format", "%3f"); ("min", "0"); ("max", "60");
       ("step", "0.0010000000000000000208")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_CONVOLUTION");
    ("label", "Convolution"); ("group", "Signal Processing");
    ("state", "Idle"); ("perm", "rw"); ("rule", "OneOfMany");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_DFT");
    ("label", "DFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "DSP_ACTIVATE_IDFT");
    ("label", "IDFT"); ("group", "Signal Processing"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_ON"); ("label", "On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "DSP_ACTIVATE_OFF"); ("label", "Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_VIDEO_STREAM");
    ("label", "Video Stream"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "STREAM_ON"); ("label", "Stream On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "STREAM_OFF"); ("label", "Stream Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "STREAMING_EXPOSURE");
    ("label", "Expose"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "STREAMING_EXPOSURE_VALUE"); ("label", "Duration (s)");
       ("format", "%6f"); ("min", "9.9999999999999995475e-07");
       ("max", "60"); ("step", "0.10000000000000000555")],
      [Xml.PCData "0.10000000000000000555    "]);
    Xml.Element
     ("defNumber",
      [("name", "STREAMING_DIVISOR_VALUE"); ("label", "Divisor");
       ("format", "%f"); ("min", "1"); ("max", "15"); ("step", "1")],
      [Xml.PCData "1    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "FPS"); ("label", "FPS");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "ro");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "EST_FPS"); ("label", "Instant"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "]);
    Xml.Element
     ("defNumber",
      [("name", "AVG_FPS"); ("label", "Average (1 sec)"); ("format", "%2f");
       ("min", "0"); ("max", "999"); ("step", "0")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "RECORD_STREAM");
    ("label", "Video Record"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RECORD_ON"); ("label", "Record On")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_DURATION_ON"); ("label", "Record (Duration)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch",
      [("name", "RECORD_FRAME_ON"); ("label", "Record (Frames)")],
      [Xml.PCData "Off    "]);
    Xml.Element
     ("defSwitch", [("name", "RECORD_OFF"); ("label", "Record Off")],
      [Xml.PCData "On    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defTextVector",
   [("device", "CCD Simulator"); ("name", "RECORD_FILE");
    ("label", "Record File"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defText", [("name", "RECORD_FILE_DIR"); ("label", "Dir")],
      [Xml.PCData "/Users/jonathan/indi__D_    "]);
    Xml.Element
     ("defText", [("name", "RECORD_FILE_NAME"); ("label", "Name")],
      [Xml.PCData "indi_record__T_    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "RECORD_OPTIONS");
    ("label", "Record Options"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RECORD_DURATION"); ("label", "Duration (sec)");
       ("format", "%3f"); ("min", "0.0010000000000000000208");
       ("max", "999999"); ("step", "0")],
      [Xml.PCData "1    "]);
    Xml.Element
     ("defNumber",
      [("name", "RECORD_FRAME_TOTAL"); ("label", "Frames"); ("format", "%f");
       ("min", "1"); ("max", "999999999"); ("step", "1")],
      [Xml.PCData "30    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_FRAME");
    ("label", "Frame"); ("group", "Streaming"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "X"); ("label", "Left"); ("format", "%f"); ("min", "0");
       ("max", "1279"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "Y"); ("label", "Top"); ("format", "%f"); ("min", "0");
       ("max", "1023"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "WIDTH"); ("label", "Width"); ("format", "%f");
       ("min", "10"); ("max", "1280"); ("step", "0")],
      [Xml.PCData "1280    "]);
    Xml.Element
     ("defNumber",
      [("name", "HEIGHT"); ("label", "Height"); ("format", "%f");
       ("min", "10"); ("max", "1024"); ("step", "0")],
      [Xml.PCData "1024    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_ENCODER");
    ("label", "Encoder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "RAW"); ("label", "RAW")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "MJPEG"); ("label", "MJPEG")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defSwitchVector",
   [("device", "CCD Simulator"); ("name", "CCD_STREAM_RECORDER");
    ("label", "Recorder"); ("group", "Streaming"); ("state", "Idle");
    ("perm", "rw"); ("rule", "OneOfMany"); ("timeout", "0");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defSwitch", [("name", "SER"); ("label", "SER")],
      [Xml.PCData "On    "]);
    Xml.Element
     ("defSwitch", [("name", "OGV"); ("label", "OGV")],
      [Xml.PCData "Off    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "CCD Simulator"); ("name", "LIMITS"); ("label", "Limits");
    ("group", "Streaming"); ("state", "Idle"); ("perm", "rw");
    ("timeout", "0"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LIMITS_BUFFER_MAX"); ("label", "Maximum Buffer Size (MB)");
       ("format", "%0f"); ("min", "1"); ("max", "65536"); ("step", "1")],
      [Xml.PCData "512    "]);
    Xml.Element
     ("defNumber",
      [("name", "LIMITS_PREVIEW_FPS"); ("label", "Maximum Preview FPS");
       ("format", "%0f"); ("min", "1"); ("max", "120"); ("step", "1")],
      [Xml.PCData "10    "])]);
 Xml.Element
  ("setSwitchVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_PARK");
    ("state", "Ok"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneSwitch", [("name", "PARK")], [Xml.PCData "Off    "]);
    Xml.Element ("oneSwitch", [("name", "UNPARK")], [Xml.PCData "On    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setSwitchVec _")],
   []);
 Xml.Element
  ("setNumberVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_PARK_POSITION");
    ("state", "Idle"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element ("oneNumber", [("name", "PARK_HA")], [Xml.PCData "-6    "]);
    Xml.Element ("oneNumber", [("name", "PARK_DEC")], [Xml.PCData "0    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setNumberVec _")],
   []);
 Xml.Element
  ("setTextVector",
   [("device", "Telescope Simulator"); ("name", "TIME_UTC"); ("state", "Ok");
    ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("oneText", [("name", "UTC")], [Xml.PCData "2022-06-15T18:47:04    "]);
    Xml.Element ("oneText", [("name", "OFFSET")], [Xml.PCData "1.00    "])]);
 Xml.Element
  ("message",
   [("device", "Telescope Simulator"); ("timestamp", "2022-01-01T00:00:00");
    ("message", "setTextVec info")],
   []);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "EQUATORIAL_EOD_COORD");
    ("label", "Eq Coordinates"); ("group", "Main Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "EQUATORIAL_EOD_COORD");
    ("label", "Eq Coordinates"); ("group", "Main Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_INFO");
    ("label", "Scope Properties"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_APERTURE"); ("label", "Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_FOCAL_LENGTH"); ("label", "Focal Length (mm)");
       ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_APERTURE"); ("label", "Guider Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_FOCAL_LENGTH");
       ("label", "Guider Focal Length (mm)"); ("format", "%g");
       ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_INFO");
    ("label", "Scope Properties"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_APERTURE"); ("label", "Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_FOCAL_LENGTH"); ("label", "Focal Length (mm)");
       ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_APERTURE"); ("label", "Guider Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_FOCAL_LENGTH");
       ("label", "Guider Focal Length (mm)"); ("format", "%g");
       ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "GEOGRAPHIC_COORD");
    ("label", "Scope Location"); ("group", "Site Management");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LAT"); ("label", "Lat (dd:mm:sss)"); ("format", "%012.8m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "52.189722222222215464    "]);
    Xml.Element
     ("defNumber",
      [("name", "LONG"); ("label", "Lon (dd:mm:sss)"); ("format", "%012.8m");
       ("min", "0"); ("max", "360"); ("step", "0")],
      [Xml.PCData "0.16999999999999998446    "]);
    Xml.Element
     ("defNumber",
      [("name", "ELEV"); ("label", "Elevation (m)"); ("format", "%g");
       ("min", "-200"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "13.75    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "GEOGRAPHIC_COORD");
    ("label", "Scope Location"); ("group", "Site Management");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "LAT"); ("label", "Lat (dd:mm:sss)"); ("format", "%012.8m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "52.189722222222215464    "]);
    Xml.Element
     ("defNumber",
      [("name", "LONG"); ("label", "Lon (dd:mm:sss)"); ("format", "%012.8m");
       ("min", "0"); ("max", "360"); ("step", "0")],
      [Xml.PCData "0.16999999999999998446    "]);
    Xml.Element
     ("defNumber",
      [("name", "ELEV"); ("label", "Elevation (m)"); ("format", "%g");
       ("min", "-200"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "13.75    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "EQUATORIAL_EOD_COORD");
    ("label", "Eq Coordinates"); ("group", "Main Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "EQUATORIAL_EOD_COORD");
    ("label", "Eq Coordinates"); ("group", "Main Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "EQUATORIAL_EOD_COORD");
    ("label", "Eq Coordinates"); ("group", "Main Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "EQUATORIAL_EOD_COORD");
    ("label", "Eq Coordinates"); ("group", "Main Control");
    ("state", "Idle"); ("perm", "rw"); ("timeout", "60");
    ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "RA"); ("label", "RA (hh:mm:ss)"); ("format", "%010.6m");
       ("min", "0"); ("max", "24"); ("step", "0")],
      [Xml.PCData "0    "]);
    Xml.Element
     ("defNumber",
      [("name", "DEC"); ("label", "DEC (dd:mm:ss)"); ("format", "%010.6m");
       ("min", "-90"); ("max", "90"); ("step", "0")],
      [Xml.PCData "0    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_INFO");
    ("label", "Scope Properties"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_APERTURE"); ("label", "Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_FOCAL_LENGTH"); ("label", "Focal Length (mm)");
       ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_APERTURE"); ("label", "Guider Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_FOCAL_LENGTH");
       ("label", "Guider Focal Length (mm)"); ("format", "%g");
       ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "])]);
 Xml.Element
  ("defNumberVector",
   [("device", "Telescope Simulator"); ("name", "TELESCOPE_INFO");
    ("label", "Scope Properties"); ("group", "Options"); ("state", "Ok");
    ("perm", "rw"); ("timeout", "60"); ("timestamp", "2022-01-01T00:00:00")],
   [Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_APERTURE"); ("label", "Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "TELESCOPE_FOCAL_LENGTH"); ("label", "Focal Length (mm)");
       ("format", "%g"); ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_APERTURE"); ("label", "Guider Aperture (mm)");
       ("format", "%g"); ("min", "10"); ("max", "5000"); ("step", "0")],
      [Xml.PCData "120    "]);
    Xml.Element
     ("defNumber",
      [("name", "GUIDER_FOCAL_LENGTH");
       ("label", "Guider Focal Length (mm)"); ("format", "%g");
       ("min", "10"); ("max", "10000"); ("step", "0")],
      [Xml.PCData "900    "])])]
