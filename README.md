humdrum-tools
=============

The *humdrum-tools* repository is a collection of command-line
programs for computational music analysis that process files in the
Humdrum file format.  The ```humdrum``` subdirectory contains the
[Humdrum Toolkit](https://github.com/humdrum-tools/humdrum), and
the ```humextra``` subdirectory contains the [Humdrum
Extras](https://github.com/craigsapp/humextra) package.  Documentation
for using Humdrum tools can be found at http://www.humdrum.org.

The [*Humdrum Toolkit*](https://github.com/humdrum-tools/humdrum) is
a set of [unix command-line](https://www.youtube.com/watch?v=bE9DyH43C2I)
programs which process data files, including musical scores, in the
Humdrum file format.  Most programs are written in [AWK](https://developer.apple.com/library/mac/documentation/opensource/conceptual/shellscripting/Howawk-ward/Howawk-ward.html#//apple_ref/doc/uid/TP40004268-TP40003518-SW10) and called
from shell scripts which handle command-line options, although there
are also a few C-language programs in the Toolkit.  The Humdrum
Toolkit can be used on unix-based computer systems such as linux
and Apple OS X.  To use in MS Windows, install a unix terminal
emulator.  A comprehensive package for linux tools in Windows can
be downloaded from http://www.cygwin.com.  The simplest method is
to download all cygwin packages when installing so that components
do not have to be added later when you notice that they are missing.

[*Humdrum Extras*](https://github.com/craigsapp/humextra) contains additional
tools for processing Humdrum files, as well as a C++ library for
parsing [Humdrum data
files](https://github.com/humdrum-tools/humdrum-data).  A web-based
interface for Humdrum Extras programs is available
[here](http://extras.humdrum.org/online?command=mkeyscape%20-ln%20h://beethoven/sonatas/sonata01-1.krn&run=true),
utilizing [emscripten](https://github.com/kripken/emscripten)
to compile the C++ code into JavaScript for running directly in a
web browser.  You can use this interface to try out Humdrum Extra
programs without having to install any software.

If you are lucky or a unix expert (and have *git* and *gcc* installed),
then you can run the following commands to download
humdrum-tools and set them up as a single-user installation:

```bash
   cd               # Go to installation directory (home directory in this example).
   git clone https://github.com/humdrum-tools/humdrum-tools
   cd humdrum-tools # Go into repository to run make commands.
   make update      # Make sure you have the most recent humdrum/humextra code.
   make             # Compile C/C++ programs and create bin directories.
   make install     # Add bin directories to $PATH environment variable.
```

Otherwise, follow the more detailed instructions below.  Super-users
can instead configure humdrum-tools for all users on a computer by
typically installing in `/usr/local/humdrum-tools` and adding
the `humdrum/bin` and `humextra/bin` directories to the
PATH environment variable in the login script for all users (which
depends on the [shell](http://en.wikipedia.org/wiki/Unix_shell):
`/etc/profile` for most shells, `/etc/zshenv` for zsh and
`/etc/csh.cshrc` for csh/tcsh).

Further documentation about the Humdrum Toolkit and Humdrum Extras 
as well as installing and using them can be found at http://www.humdrum.org,
and there is also a 
[Humdrum Users Group](https://groups.google.com/d/forum/starstarhug) 
(**HUG) for announcements and questions.

Topics discussed below:
* [Downloading](#downloading) &mdash; How to download humdrum-tools.
* [Compiling](#compiling) &mdash; How to compile humdrum-tools.
* [Installing](#installing) &mdash; How to install humdrum-tools.
* [Testing](#testing) &mdash; Check that the programs are behaving.
* [Updating](#updating) &mdash; How to update humdrum-tools.

Installing git
==============

To download this repository, first make sure that
[git](http://git-scm.com/book/en/Getting-Started-Git-Basics) is
installed on your computer.  Git is a version control program which
is the main interface to online repositories on GitHub.  To check
if the `git` program is available on your computer, type the
following in a terminal:

```bash
   which git
```

If the terminal replies with a line such as `/usr/local/bin/git`,
then git is present and you can run the installation commands given
further above.  If the `which` command replies with an error
that git cannot be found, you need to install git.  How to do this
will depend on your operating system.  Here are installation hints
for various computer systems:

In linux, the installation command for git is usually one of these two 
possibilities:

```bash
   sudo yum install git
   sudo apt-get install git
```

For [cygwin](http://www.cygwin.com) on MS Windows computers, you
should have included `git` when installing packages when you
first installed cygwin.  Re-run the installation program and include
git in the package installation list if the `which` command does
not find it.

For Apple OS X, the easiest method is to download git from [this
link](http://git-scm.com/download/mac).  More advanced Mac users
can use [Homebrew](http://brew.sh) to install git with this command:

```bash
   brew install git
```

You could also download GUI interfaces for git
[here](http://git-scm.com/downloads/guis).  A [Github/git
plugin](http://eclipse.github.com) is also available for the Eclipse
IDE ([watch video](http://www.youtube.com/watch?v=ptK9-CNms98)).


Downloading
===========

For individual user installations, the humdrum-tools repository can
reside anywhere within a user's home directory.  For system-wide
installation, the recommended location is `/usr/local/humdrum-tools`.
The following instructions are for individual account installations,
but system-wide installation will be similar.  The main difference will
be the location of the shell startup script where the PATH needs to be
set (see the Installing section below for setting up the PATH shell variable).

To download humdrum-tools, type these commands:

```bash
   cd           # Go to home directory or wherever you want to install,
                # such as "cd /usr/local" for system-wide installations.
   git clone --recursive https://github.com/humdrum-tools/humdrum-tools
```

The `--recursive` option is needed to download each of the
individual repositories inside of this meta-repository.

Sample Humdrum file data can also be downloaded by typing the following
command within the humdrum-tools directory:

```bash
   cd ~/humdrum-tools     # or wherever humdrum-tools was downloaded.
   make data
```

If you want to download the data files outside of the humdrum-tools 
directory (for example into a user directory when the installation
is in `/usr/local/humdrum-tools`) then download with this command
instead:

```bash
   cd
   git clone --recursive https://github.com/humdrum-tools/humdrum-data
```

A local copy of the http://www.humdrum.org website can also be downloaded
for off-line use with these commands:

```bash
   cd ~/humdrum-tools     # or wherever humdrum-tools was downloaded.
   make doc
# or to install outside of the humdrum-tools directory:
   git clone https://github.com/humdrum-tools/humdrum-tools.github.io humdrum-documentation
```

Note that the humdrum-tools and humdrum-data repositories cannot
be downloaded in a very convenient format from the ZIP link on the
Github website since repository submodules will not be included in
the ZIP file.  GitHub may allow submodule inclusion in their ZIP
downloads in the future.


Compiling
=========

To compile programs in the two humdrum-tools submodules,
type `make` inside of the humdrum directory:

```bash
    cd ~/humdrum-tools  # or wherever humdrum-tools was downloaded.
    make
```

Note that to use the ```make``` command or ```gcc``` for compiling
the C/C++ programs, these must already be installed.  Check to see if
gcc is installed by typing these commands:

```bash
   which gcc
   which make
```

The terminal should reply with something like `/usr/bin/gcc`
and `/usr/bin/make`.  

If gcc is not installed, then you will have to figure out how to
install it on your computer first.  Linux/Unix computers usually
have it pre-installed along with the operating system; if not, then
typing `sudo yum install gcc` or `sudo apt-get install gcc`
will typically install it.  Apple OS X does not include it by
default, so you will have to install it.  If you are using OS X
Mavericks or later, then type `xcode-select --install` to install
the Xcode command line tools, which includes *gcc* (or actually a
similar compiler).  The `make` command will be installed at the
same time that `gcc` is installed.  Cygwin users would have to
re-run the installation program and include the compile tools if
gcc was not initially installed with cygwin (a minimal installation
will not include gcc).


Installing
==========

To use humdrum-tools commands within any directory, you must add the
humdrum/bin and humextra/bin directories to the PATH environmental 
variable.  First, determine the shell (unix command-line interpreter) 
which you are using in the terminal by running this command:

```echo $SHELL```

For bash shells (most common shell), the above command should reply
with the text `/bin/bash`.  If you are using another shell,
"*bash*" will be replaced with the name of the shell you are using.

To temporarily adjust the PATH variable so that you can immediately 
start using the tools in the current terminal session, here are the two
main methods of setting the PATH variable in the various shells from
the command line:

In bash, sh, ksh, zsh, type these commands:

```bash
    cd ~/humdrum-tools    # or wherever humdrum-tools was downloaded.
    PATH=`pwd`/humdrum/bin:$PATH
    PATH=`pwd`/humextra/bin:$PATH
```

Or in csh or tcsh, do these commands:

```bash
    cd ~/humdrum-tools    # or wherever humdrum-tools was downloaded.
    set PATH=`pwd`/humdrum/bin:$PATH
    set PATH=`pwd`/humextra/bin:$PATH
```

For a persistent installation of humdrum tools whenever you open a
new terminal, the PATH environment variable needs to be amended
during login with the paths of the humdrum-tools executables.  The 
above `PATH=` lines must be added to the shell login script.  The
name of this shell login file is different for different shells.  If 
you type:

```bash
   cd ~/humdrum-tools
   make install
```

then the humdrum-tools makefile will attempt to place those lines in the
correct file based on your login shell; otherwise, you can add the lines
manually to the shell startup scripts as outlined below.  The command
`make install-hint` will suggest the commands needed to add the 
humdrum-tools bin directories permanently to the PATH environment 
variable if you want to manually configure it.  Don't run the temporary
installation given further above before running `make install`, since
this make target looks at the PATH environment variable to decide if the
PATH needs to be updated.  Login again if you already ran the temporary
PATH update.

The initialization files for various shells are given in the following
table.  Choose the shell and installation type to select the correct
setup file to edit.

<table cellpadding="0" cellspacing="0">
<tr> <td> <b>shell</b></td><td> <b>local user setup file</b> </td><td> <b>system-wide setup file</a> </td> </tr>
<tr> <td> bash </td><td> ~/.bash_profile, else ~/.bash_login, else ~/.profile </td><td> /etc/profile </td> </tr>
<tr> <td> zsh  </td><td> ~/.zshenv    </td><td> /etc/zshenv, /etc/profile </td> </tr>
<tr> <td> tcsh </td><td> ~/.tcshrc    </td><td> /etc/csh.cshrc </td> </tr>
<tr> <td> csh  </td><td> ~/.cshrc     </td><td> /etc/csh.cshrc </td> </tr>
<tr> <td> ksh  </td><td> $ENV         </td><td> /etc/profile </td> </tr>
<tr> <td> sh   </td><td> ~/.profile   </td><td> /etc/profile </td> </tr>
</table>

Bash is the most common shell.  For single-user installations, the
choice of setup file is complicated: If the file ~/.bash_profile
exists ("~" is unix shorthand for your home directory), then the
bash shell will read that file.  If ~/.bash_profile does not exist,
then bash will instead try to read ~/.bash_login.  If ~/.bash_login
does not exist, then bash will try to read ~/.profile.  Only one
of those files will be read, and ~/.bash_profile is the first one
bash that will try to read.  Note that if there is currently a ~/.profile
file but no ~/.bash_profile, the settings in ~/.profile will be
ignored if you create the ~/.bash_profile file.

For system-wide installations, super-users will have to add the
`PATH=` lines to the correct file within the ```/etc/```
directory.  Super-users can usually install for all users 
on a computer system in any common shell by running these commands:

```bash
   cd /usr/local/humdrum-tools    # or wherever humdrum-tools was downloaded.
# bash, sh, ksh, and zsh
   sudo echo "export PATH=`pwd`/humdrum/bin:$PATH" >> /etc/profile
   sudo echo "export PATH=`pwd`/humextra/bin:$PATH" >> /etc/profile
# csh and tcsh:
   sudo echo "set PATH=`pwd`/humdrum/bin:$PATH" >> /etc/csh.cshrc
   sudo echo "set PATH=`pwd`/humextra/bin:$PATH" >> /etc/csh.cshrc
```

Many linux systems have a directory called ``/etc/profile.d` into which
package-specific shell settings are placed rather than altering `/etc/profile`.  If so, 
then for bash-like shells, create a file in that directory with the PATH 
variable updates rather than editing the /etc/profile file:

```bash
   if [ -e /etc/profile.d ]
   then 
      cd /usr/local/humdrum-tools   # or wherever humdrum-tools is installed.
      echo "export PATH=`pwd`/humdrum/bin:$PATH" >> /etc/profile.d/humdrum.sh
      echo "export PATH=`pwd`/humextra/bin:$PATH" >> /etc/profile.d/humdrum.sh
   else
      echo "/etc/profile.d directory does not exist."
   fi
```


To verify that the PATH lines were added to the correct file, try
opening a new terminal window and type:

```bash
   echo $PATH | tr : '\n' | grep humdrum
```

The computer should reply with the full path names of the *bin* directories for 
the Humdrum Toolkit and Humdrum Extras.  With a system-wide installation,
the above command should display something like this:

```
/usr/local/humdrum-tools/humdrum/bin
/usr/local/humdrum-tools/humextra/bin
```

You can also use the *which* command to see where a command is located.  
If the humdrum-tools command paths are set up correctly, then the following
commands:

```bash
   which key
   which keycor
```

should reply something like this:

```
/usr/local/humdrum-tools/humdrum/bin/key
/usr/local/humdrum-tools/humextra/bin/keycor
```

This implies that the PATH variable contains the correct two *bin* directories
for using humdrum-tools.


Testing
=======

The command `make regression` will run regression tests for the Humdrum Toolkit
and Humdrum Extras.  The make target will run the commands on files and compare the
results to the expected output from the programs for the given options.  Here is
a sample of the regression test display:

```
(cd humdrum; make regression)
TEST 01 for accent: OK
TEST 01 for assemble: OK
TEST 01 for barks: OK
TEST 01 for cbr: OK
...
(cd humextra; make regression)
bin/run-command-tests 
autostem	test 001 OK	Add stems to notes in the treble clef
autostem	test 005 OK	Add stems to notes, overwriting any which already exist.
barnum		test 007 OK	Numbering measures with repeat bars in the middle of the measure.
harm2kern	test 006 OK	Seventh chords and their inversions in C Major.
harm2kern	test 007 OK	Chord qualities with a root on C.
myank		test 009 OK	Extract a measure, not including ending barline.
prange		test 003 OK	Count pitches with duration weighting
rscale		test 010 OK	Recover original rhythms from exotic rhythmic values.
sample		test 001 OK	Sample the music every quarter-note.
```

If you only want to see failed tests, run this command:

```bash
   make regression | grep -v OK
```

Failed regression tests (along with information about your computer
setup) should be reported
[here](https://github.com/humdrum-tools/humdrum/issues) for the
Humdrum Toolkit, and [here](https://github.com/craigsapp/humextra/issues)
for Humdrum Extras.


Updating
========

Software (and data if installed with ```make data```) periodically 
can be updated to the most recent versions by typing these commands:

```bash
   cd `which mint | sed 's/humdrum\/bin\/mint$//'`
   make update     # Download any updates from GitHub.
   make            # Re-compile the programs.
```

If you make changes to the files in the humdrum-tools directory,
the above commands may complain if the same file has been updated
in the repository.  Type ```git status``` to see what files have
been locally modified or added since you did the last update or
download.

If you want to keep local changes but still update, try these commands:

```bash
   cd `which mint | sed 's/humdrum\/bin\/mint$//'`
   git stash
   make update
   make
   git stash apply
```

If you want to undo any local changes before updating, you can run
this command:

```bash
   cd `which mint | sed 's/humdrum\/bin\/mint$//'`
   git reset --hard HEAD^
   make update
   make
```
