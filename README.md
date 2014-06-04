humdrum-tools
=============

This repository contains a collection of command-line programs for
computational music analysis which process files in the Humdrum file
format.  The ```humdrum``` subdirectory contains the [Humdrum
Toolkit](https://github.com/humdrum-tools/humdrum), and the
```humextra``` subdirectory contains the [Humdrum
Extras](https://github.com/craigsapp/humextra) package.  Documentation
for using Humdrum tools is found at http://www.humdrum.org.

The Humdrum Toolkit is a set of [unix
command-line](https://www.youtube.com/watch?v=bE9DyH43C2I) programs
which process data files, including musical scores, in the Humdrum
file format.  The Humdrum Toolkit can be used on unix-based computer
systems such as linux and Apple OS X.  To use in MS Windows, install
a unix terminal emulator.  A comprehensive package for linux tools
in Windows can be downloaded from http://www.cygwin.com.  The
simplest method is to download all cygwin packages when installing,
but that will require a long installation duration (such as overnight
for some reason).

[Humdrum Extras](http://extras.humdrum.org) consists of additional
tools for processing Humdrum files, as well as a parsing library
for Humdrum files written in C++.  A web inteface to many Humdrum Extras
programs is available [here](http://extras.humdrum.org/online).

If you are lucky or a unix expert (and have git and gcc installed),
then you can run the following commands to download and install the
Humdrum Toolkit as a single-user installation as well as download
sample musical data and test all of the tools (some commands below 
may need to be prefixed with ```sudo```):
```bash
   cd /usr/local
   git clone --recursive https://github.com/humdrum-tools/humdrum-tools
   cd humdrum-tools
   make 
   make install
   make regression
   make data
```
Otherwise, follow the more detailed instructions below.

Further documentation about the Humdrum Toolkit and Humdrum Extras 
as well as installing and using them can be found at http://www.humdrum.org, 


Installing git
==============

To download this repository, you should have git installed on your
computer.  [Git](http://git-scm.com/book/en/Getting-Started-Git-Basics) 
is a version control program which is the main interface to online
repositories on GitHub.  To check if the ```git``` program is
installed on your computer, type in a terminal:
```bash
   which git
```
If the terminal replies with a line such as ```/usr/local/bin/git```,
then git is installed and you can run the above installation commands.
If the ```which``` command replies with an error that git cannot
be found, you need to install git.  How to do this will depend on
your operating system.  

In linux, the installation command for git is usually one of these two 
possibilities:
```bash
   sudo yum install git
   sudo apt-get install git
```

For [cygwin](http://www.cygwin.com) on MS Windows computers, you
should have included ```git``` when installing packages when you
first installed cygwin.  Re-run the installation program and include
git in the package installation list.

For Apple OS X, the easiest method is to download git from [this
link](http://git-scm.com/download/mac).  More advanced Mac users
can use [Homebrew](http://brew.sh) to install git:
```bash
   brew install git
```

You could also download GUI interfaces for git
[here](http://git-scm.com/downloads/guis).  A [Github/git
plugin](http://eclipse.github.com) is also available for the Eclipse
IDE ([watch video](http://www.youtube.com/watch?v=ptK9-CNms98)).


Downloading
===========

For system-wide installation, the recommended location of the
humdrum-tools repository is in ```/usr/local```.  For individual
user installations, the humdrum-tools repository can reside anywhere 
within their file structure.  

To download, type these commands:

```bash
   cd /usr/local  # suggested location for system-wide installation
   git clone --recursive https://github.com/humdrum-tools/humdrum-tools
   # or if there are file permission problems.
   sudo git clone --recursive https://github.com/humdrum-tools/humdrum-tools
```

The ```--recursive``` option is needed to download each of the
individual repositories inside of this meta-repository.

For single-user installations, you can install in your home directory or
elsewhere in your account:
```bash
   cd      # move to home directory
   git clone --recursive https://github.com/humdrum-tools/humdrum-tools
```

Sample Humdrum file data can be downloaded by typing the following
command within the humdrum-tools directory:
```bash
   cd /usr/local/humdrum-tools  # or wherever humdrum-tools is installed
   make data
```

A local copy of the http://www.humdrum.org website can be downloaded
with these commands:
```bash
   cd /usr/local/humdrum-tools  # or wherever humdrum-tools is installed
   make webdoc
```


Note that the repository cannot be downloaded in a very useful format
from the ZIP link on the Github website since the included repositories
for each composer will not be included in that ZIP file.  GitHub may
allow submodule inclusion in their ZIP downloads in the future.

Compiling 
=========

To compile programs in the two humdrum-tools submodules,
type ```make``` inside of the humdrum directory:
```bash
    cd humdrum-tools
    make
```

Note that to use the ```make``` command or ```gcc``` for compiling
the C/C++ programs, these must already be installed.  Check to see if
gcc is installed by typing this command (gcc installation includes
the <em>make</em> command as well):
````bash
   which gcc
   which make
```
The terminal should reply with something like ```/usr/bin/gcc```
and ```/usr/bin/make```.  If gcc is not installed, then you will
have to figure out how to install it on your computer first.
Linux/Unix computers usually have it pre-installed with the operating
system; if not, then typing ```sudo yum install gcc``` or ```sudo
apt-get install gcc``` will typically install it.  Apple OS X does
not include it by default, so you will have to install it.  If you
are using OS X Mavericks or later, then type ```xcode-select
--install``` to install the Xcode command line tools. The ```make```
command will be installed at the same time that ```gcc``` is
installed.  Cygwin users would have to re-run the installation
program and include the compile tools if gcc was not initially
installed with cygwin (a minimal installation will not include
gcc).


Installing
==========

To use humdrum-tools commands within any directory, you must add the
humdrum/bin and humextra/bin directories to the PATH environmental variable.  
This can be done temporarily for the current session by typing:
```bash
    cd humdrum-tools
    PATH=`pwd`/humdrum/bin:$PATH
    PATH=`pwd`/humextra/bin:$PATH
```

For a persistent installation of humdrum tools whenever you
open a new terminal, you can type the following command to include
the bin directories into the PATH command search path variable
within the ~/.profile file.
```bash
   cd humdrum-tools
   make install
```
This installation method is suitable for single-user installations.
Super-users can instead install for all users on a computer system by
running this command instead:
```bash
   cd humdrum-tools
   sudo echo "export PATH=`pwd`/humdrum/bin:$PATH" >> /etc/profile
   sudo echo "export PATH=`pwd`/humextra/bin:$PATH" >> /etc/profile
```


Updating
========

Software (and data if installed with ```make data```) periodically 
can be updated to the most recent versions by typing this command:

```bash
   cd `which mint | sed 's/humdrum\/bin\/mint$//'`
   make update
   make
```



