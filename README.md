# Project RSTS

A project to track my experiments with a PDP-11 emulator running RSTS/E.

This is a beta release with [known issues](docs/known_issues.md).

The \*.do files are simh Simulator Control Protocol (SCP) scripts. They are
*not*, as Git Hub claims, stata source files. The scripts should be host OS
independent, but I've only tested on Windows.

The sysgen scripts, SysgenV8.do and SysgenV9.do, are used to build to
corresponding RSTS/E versions from a tape distribution kit. (I use the ones from
rsts.org). The target system is configured using the following scripts in the
common/ folder:

- MicroControllers.do
- SerialCards.do
- SlowMedia.do
- TerminalOptions.do

This makes it easy to build multiple RSTS systems, with differing hardware
support, relatively quickly. The main build files call out to other scripts to
do the bulk of their work. This allows you to comment out parts, to create a
custom build. e.g. you could build up to the point where the sysgen SIL is
installed then make several copies of the system disk image. Then run just the
remaining steps on each copy, with different target configuration files.

The V8 and V9 script create 80 MB RM03 disk images for the system disk. The V8
script also creates a 28 MB RK07 disk image, that's used as a scratch disk. The
scratch disk is not required once the system is fully built, and can be safely
deleted.

## RSTS/E V8.0

The *SysgenV8.do* script will build a system from scratch, using a tape image of
the V8 distribution kit. It works around the flaws in the only V8 tape I've
found, the one from rsts.org. This tape has the files in the wrong order. Why
does this matter? because the build control files on the tape use /mode:2 to
prevent the tape from being rewound. I work around this by copying the files to
a scratch disk, a 28 MB RK07, and building from disk.

This script takes about 13 minutes to run, on a 10 year old 32-bit Windows 7
laptop. It creates two log files, one of the simulator's debug output and a
second using [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) to log
all interaction with RSTS.

At script completion you have a working system with a minimal set of system
programs. You'll be logged into [1,2], the system library account. If that's
good enough then run init, to make the standard commands available, and you'll
be good to go. I'll be adding the remaining steps, to build all available system
programs, in the near future.

### Prerequisites

- PDP11.exe from the simh distribution. I'm using V4.0-0.

- [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) is assumed to be
 on the path, and used for logging only. You can comment out the
 [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) setup to disable
 this, but that would make problem diagnoses a lot harder.

## RSTS/E V9.5

The SysgenV9.do script will build a RSTS V9.5 system from scratch. Why V9.5 and
not V9.7? because the V9.7 tape, on rsts.org, has known errors in two files.

**NOTE:** Since creating this script I've made changes to modules that it
depends on, in order to get the V8 build working. I haven't, yet, re-tested the
V9.5 build.

### Prerequisites

- PDP11.exe from the simh distribution. I'm using V4.0-0.
- V95BOOT.TAP - The V9.5 boot tape image
- V95ANSI.TAP - The V9.5 ANSI tape image
- V9LIB.TAP - The V9 library tape image

All the above tapes are available in the [distros/RSTS_tapes/] folder at
rsts.org.
[distros/RSTS_tapes/]: http://rsts.org/autoindex.php?dir=distros/RSTS_tapes

### Optional extras

This build does not require
[PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/), but you'll
probably want to install it anyway.
