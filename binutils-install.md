The "remoteSSH" upload tool need extract from elf compiled file some connection parameters.
Minimum parameter is destination "host"; "user" parameter is optional, if omitted "root" will be used.
There are several ways to do, one is by **readelf** command from GNU Binutils.

This information is in the **'.comment'** section of the binary object. It can be readed using this command:
```bash
  $ greadelf -p .comment /path/to/sketch.elf
  
  String dump of section '.comment':
  [     0]  GCC: (GNU) 4.8.2
  [    11]  HOST: my.edison.addr
  [    26]  USER: jrivera
```

## GNU Binutils
GNU Binary Utilities or binutils, are a set of programming tools for creating and managing binary programs, object files, libraries, profile data, and assembly source code originally written by programmers at Cygnus Solutions.
The GNU binutils are typically used in conjunction with compilers such as the GNU Compiler Collection (gcc), build tools like make, and the GNU Debugger (gdb).
The main of binary tools are:

* ld - the GNU linker.
* as - the GNU assembler.
* addr2line - Converts addresses into filenames and line numbers.
* ar - A utility for creating, modifying and extracting from archives.
* c++filt - Filter to demangle encoded C++ symbols.
* dlltool - Creates files for building and using DLLs.
* gold - A new, faster, ELF only linker, still in beta test.
* gprof - Displays profiling information.
* nlmconv - Converts object code into an NLM.
* nm - Lists symbols from object files.
* objcopy - Copies and translates object files.
* objdump - Displays information from object files.
* ranlib - Generates an index to the contents of an archive.
* readelf - Displays information from any ELF format object file.
* size - Lists the section sizes of an object or archive file.
* strings - Lists printable strings from files.
* strip - Discards symbols.
* windmc - A Windows compatible message compiler.
* windres - A compiler for Windows resource files.

### Obtaining binutils
See the software page for information on obtaining releases of GNU binutils and other GNU software. The current release can be downloaded from http://ftp.gnu.org/gnu/binutils
If you plan to do active work on GNU binutils, you can access the development source tree by anonymous git:

```bash
  git clone git://sourceware.org/git/binutils-gdb.git
```

### Mac OS X
You will need a package managers on OS X like Homebrew, Macports or Fink to install GNU Binutils. If you need aditional info you can to continue reading. 
The most commonly used is Macports, but lately people are preferring Brew.

[**Fink:**](http://www.finkproject.org/)
* Apt-based - feel right at home if you come from a Debian-based environment
* Binary packages - packages are available as binaries so no long compile times. Practically though I've found that the pre-compiled binaries were always outdated and I had to compile stuff for my system anyways
* Decent selection of packages
```bash
  $ fink install binutils
```

[**MacPorts:**](https://www.macports.org/)
* Biggest selection of packages/ports
* Generally very up to date
* Nice variants system that lets you customise the build
* Easy and intuitive port files
```bash
  $ sudo port install binutils
```

[**Homebrew:**](http://brew.sh/)
* Very up to date
* Maximum leveraging of what comes with OS X. Unlike Fink or MacPorts, it does not require you to build/install ruby and libraries from scratch just to install some small Ruby-based tool.
* Installs into /usr/local so does not need you to modify PATH anywhere
* Everything owned by user, so no packages ever need potentially risky root access to install
* Every installed package is cleanly sandboxed into its own cellar so you don't have stray files all over your system, just symlinks from bin, man, etc.
* Ridiculously easy to create your own formula files (ie. package descriptors)
* Since you're from a ruby background, another plus is everything is written in ruby and all forumlas are simple ruby scripts
```bash
  $ brew install binutils
```

### Linux
Probably the "GNU Binutils" are already installed. If you are not, you can install depending on your distribution.
  * **Debian based like Ubuntu and several others:**
  ```
    $ apt-get install binutils
  ```
  * **Fedora:** 
  ```
    $ yum install binutils
  ```
  * **Gentoo:** 
  ```
    $ emerge binutils
  ```
  * **Suse:** 
  ```
    $ zypper in binutils
  ```  
  * **Arch:** 
  ```
    $ pacman -S binutils
  ```
  
### Windows
To do.
