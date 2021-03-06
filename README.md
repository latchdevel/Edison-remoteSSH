# Edison-remoteSSH
Tool to upload Arduino sketches to a Intel Edison over WiFi network by SSH.

**Requirements:**
* Arduino IDE 1.6.4+
* SSH client tool set (ssh and scp)
* Network connection to Intel Edison Board
* Public Key Authenticacion User
* GNU Binutils (readelf)

**Use**

**Install**

https://raw.githubusercontent.com/latchdevel/Edison-remoteSSH/master/IDE_Board_Manager/package_remotessh_index.json

**Work**

The "remoteSSH" upload tool need extract from elf compiled file some connection parameters.
Minimum parameter is destination "host"; "user" parameter is optional, if omitted it is set as "root" user.
There are several ways to do, one is by **readelf** command from GNU Binutils.

This information is in the **'.comment'** section of the binary object. It can be read using this command:
```bash
  $ greadelf -p .comment /path/to/sketch.elf
  
  String dump of section '.comment':
  [     0]  GCC: (GNU) 4.8.2
  [    11]  HOST: my.edison.addr
  [    26]  USER: jrivera
```
