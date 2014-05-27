humdrum-tools
=============

This repository contains a collection of software for computational
music analysis using data files in the Humdrum file format.  The
```humdrum``` subdirectory contains the [Humdrum
Toolkit](https://github.com/humdrum-tools/humdrum), and the
```humextra``` subdirectory contains the [Humdrum
Extras](https://github.com/craigsapp/humextra) package.  Documentation
for using Humdrum tools is found at http://www.humdrum.org.


# Downloading #

For system-wide installation, the recommended location of the
humdrum-tools repository is in ```/usr/local```.  For individual
users, the humdrum-tools repository can reside anywhere within their
file structure.  

There are two versions of the Humdrum tools: one with and one without
an included set of data files.  To download this GitHub repository
without the included data, use
[git](http://en.wikipedia.org/wiki/Git_%29software%29) in a terminal
by typing:

```bash
   cd /usr/local  # suggested location for system-wide installation
   git clone --recursive https://github.com/humdrum-tools/humdrum-tools
```

For the version which includes data files:

```bash
   cd /usr/local  # suggested location for system-wide installation
   git clone --recursive https://github.com/humdrum-tools/humdrum-tools-with-data humdrum-tools
```

Data can be added later to the to dataless version of humdrum-tools
by typing these commands:

```bash
   cd /usr/local/humdrum-tools  # or wherever humdrum-tools is installed
   mkdir data
   git submodule add -f git://github.com/humdrum-tools/humdrum-data data
```


The ```--recursive``` option is needed to download each of the
individual repositories inside of this meta-repository.

In a unix terminal, those of you unfamiliar with git can check to
see if git is installed by typing ```which git```.  If the terminal
replies with a path to git, then you can proceed with the above
cloning to download the repository.  If not, then typically you can
use a package manager to install git, such as ```apt-get install
git``` or ```yum install git``` in linux.  On Apple OS X computers,
git can be installed directly from [here](http://git-scm.com/download/mac)
or by more experienced users from a mac package manager such as
[Homebrew](http://brew.sh).  You can download GUI interfaces for
git [here](http://git-scm.com/downloads/guis).  A [Github/git
plugin](http://eclipse.github.com) is also available for the Eclipse
IDE ([watch video](http://www.youtube.com/watch?v=ptK9-CNms98)).

This repository cannot be downloaded in a very useful format from
the ZIP link on the Github website, since the included repositories
for each composer will not be included in that ZIP file.  You must
either use [git](http://en.wikipedia.org/wiki/Git_%29software%29)
software or separately download each of the individual composer's
ZIP files linked from the table above.  Follow [this bash
script](https://gist.github.com/josquin-research-project/8177804)
to download manually using wget (usually for linux &
[cygwin](http://www.cygwin.com)), or [this bash
script](https://gist.github.com/josquin-research-project/8177884)
for OS X.

# Compiling and Installing #

## Preliminaries ##

First you should verify that you have the GCC compiler installed on your system.  This typically comes preinstalled in linux, but will need to be installed on Apple OS X computers.  The following command will report the location of the gcc compiler if it is installed:

```bash
   which gcc
```

If there is no reply from the above command, you must install gcc first.  A few
of the Humdrum Toolkit commands require compiling from C, and all of the 
Humdrum Extras commands require compiling from C++.

## Compiling ##

Once you have downloaded the humdrum-tools repository, move
into the humdrum-tools directory and then type

```bash
   cd humdrum-tools
   make
```

## Installing ##

Super-users installing in ```/usr/local/humdrum-tools``` should
then update ```/etc/profile``` to add the search paths for humdrum/bin
and humextra/bin to the ```$PATH``` environmental variable.  If you are
doing a single user installation, you can automatically install the
```$PATH``` variables in ```~/.profile``` with the command:

```bash
   make install
```

# Updating #

Software (and data) can be periodically updated to the most recent version
by typing this command:

```bash
   cd /usr/local/humdrum-tools    # or wherever you placed the repository
   git pull --recursive
```



