# Edison-remoteSSH
Tool to upload Arduino's Sketchs in a Intel Edison over WiFi network by SSH.

**Requirements:**
* Arduino IDE 1.5.3+
* SSH client tool set (ssh and scp)
* Network connection to your Intel Edison Board
* Public Key Authenticacion
* GNU Binutils (readelf)


The "remoteSSH" upload tool need extract from elf compiled file some connection parameters.
Minimum parameter is "host" of destination, "user" param is optional, if omitted will be "root".
There are several ways to do, one is by **readelf** command from GNU Binutils.

This information is in the **'.comment'** section of the binary object. It can be read using this command:
```bash
  $ greadelf -p .comment /path/to/sketch.elf
  
  String dump of section '.comment':
  [     0]  GCC: (GNU) 4.8.2
  [    11]  HOST: my.edison.addr
  [    26]  USER: jrivera
```
