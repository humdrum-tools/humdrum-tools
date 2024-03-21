## Master humdrum-tools GNU/BSD makefile.
##
## Programmer:    Craig Stuart Sapp <craig@ccrma.stanford.edu>
## Creation Date: Mon May 26 15:55:09 PDT 2014
## Last Modified: Wed Apr 15 12:15:19 PDT 2015
## Filename:      ...humdrum-tools/Makefile
##
## Description:
##
## This Makefile will compile programs in the humdrum and humextra
## subdirectories.  You must first have gcc installed on your computer.
## Type "which gcc" to verify that gcc is installed.  On OS X computers
## you can typically install gcc with the command:
##      xcode-select --install
## which will install compiles tools in /Library/Developer/CommandLineTools
## including git, gcc, and make.  Most linux computers come with gcc
## already installed; otherwise, one of the two commands may install it:
##    apt-get install gcc
##    yum install gcc
## and maybe also:
##    apt-get install make
##    yum install make
##
## Several of the make targets require the git program to be installed
## (updating, and downloading of data and documentation repositories).
## Type "which git" to verify that git is installed.  Installing command-line
## tools in OS X with xcode-select will also install git.  If git is not
## available in linux, then either of these commands may install it:
##    apt-get install git
##    yum install git
## Windows users should install in the cygwin unix terminal (available from
## http://www.cygwin.com).  Install gcc and git packages when installing.
##
##
## To run this makefile, type:
##      make
## This will compile the Humdrum Toolkit C programs as well as the Humdrum
## Extras programs.  After successful compiling, you must add the bin
## directories to your command search path to use in other directories.
## This can be done automatically with the command:
##       make install
## if you are installing humdrum-tools in a single user account. Or type:
##       make install-hints
## To list the commands necessary to install humdrum-tools manually.
##
## Super-users installing humdrum-tools for all users should add these
## lines to /etc/profile, or a create shell script with these lines
## in the startup script for your shell, assuming that
## /usr/local/humdrum-tools is the installation location of humdrum-tools.
##
## For bash, sh, ksh, and zsh add these lines to /etc/profile:
##    export PATH=/usr/local/humdrum-tools/humdrum/bin:$PATH
##    export PATH=/usr/local/humdrum-tools/humextra/bin:$PATH
## For tcsh and csh, add these lines to /etc/csh.cshrc:
##    set PATH=/usr/local/humdrum-tools/humdrum/bin:$PATH
##    set PATH=/usr/local/humdrum-tools/humextra/bin:$PATH
##

# Targets which don't actually refer to files:
.PHONY : humextra humdrum help improv

# Variables used to give hints about setup for $PATH environmental variable:
HUMEXTRA_PATH   := $(shell echo $$PATH |tr : '\n'|grep 'humextra/bin'|head -n 1)
HUMEXTRA_TARGET := $(shell echo `pwd`/humextra/bin)
HUMDRUM_PATH    := $(shell echo $$PATH |tr : '\n'|grep 'humdrum/bin'|head -n 1)
HUMDRUM_TARGET  := $(shell echo `pwd`/humdrum/bin)

# Variables needed for install and install-hints targets:
USERSHELL = $(shell echo $$SHELL | sed 's/.*\///')
SHELLSCRIPT =
ifeq ($(USERSHELL),bash)
   ifneq ($(wildcard ~/.bash_profile),)
      SHELLSCRIPT = ~/.bash_profile
   else
      ifneq ($(wildcard ~/.bash_login),)
         SHELLSCRIPT = ~/.bash_login
      else
         SHELLSCRIPT = ~/.profile
      endif
   endif
endif
ifeq ($(USERSHELL),sh)
   SHELLSCRIPT = ~/.profile
endif
ifeq ($(USERSHELL),ksh)
   SHELLSCRIPT = ~/.kshrc
endif
ifeq ($(USERSHELL),zsh)
   SHELLSCRIPT = ~/.zshenv
endif
ifeq ($(USERSHELL),tcsh)
   SHELLSCRIPT = ~/.tcshrc
endif
ifeq ($(USERSHELL),csh)
   SHELLSCRIPT = ~/.cshrc
endif

HUMDRUMINSTALL  = "export PATH=\"`pwd`/humdrum/bin:\$$PATH\""
HUMEXTRAINSTALL = "export PATH=\"`pwd`/humextra/bin:\$$PATH\""
ifeq ($(USERSHELL),$(filter $(USERSHELL),csh tcsh))
   HUMDRUMINSTALL  = "set PATH=\"`pwd`/humdrum/bin:\$$PATH\""
   HUMEXTRAINSTALL = "set PATH=\"`pwd`/humextra/bin:\$$PATH\""
endif


###########################################################################
##
## Default target will compile humdrum and humextra packages.  Type
##   "make install" to add the command directories for each to the
##   PATH environmental variable within ~/.profile (for single-user
##   installs only).
##

all: check-recursive humdrum-compile humextra-compile checkpath



###########################################################################
##
## Target to list main targets that the makefile can run
##

info: help
help:
	@echo
	@echo "Available make targets:"
	@echo "[0;32mmake[0m               -- Compile programs in humdrum and humextra directories."
	@echo "  [0;32mmake humdrum[0m     -- Only compile Humdrum Toolkit."
	@echo "  [0;32mmake humextra[0m    -- Only compile Humdrum Extras."
	@echo "[0;32mmake install[0m       -- Include bin directories in \$$PATH variable."
	@echo "                      (single-user install only)."
	@echo "[0;32mmake install-hints[0m -- Print commands for manual \$$PATH setup."
	@echo "[0;32mmake regression[0m    -- Run regression tests on software."
	@echo "[0;32mmake update[0m        -- Download most recent versions of software"
	@echo "                      (then run '[0;32mmake[0m' to compile updates)."
	@echo "[0;32mmake data[0m          -- Download humdrum-data repository (into 'data' subdirectory)."
	@echo "[0;32mmake doc[0m           -- Download Humdrum documentation website repository "
	@echo "                      (into 'doc' subdirectory)."
	@echo "[0m"



###########################################################################
##
## Targets for adding/removing data repository
##

data: checkgit
ifeq ($(wildcard data),)
	git clone https://github.com/humdrum-tools/humdrum-data data
	(cd data && git submodule update --init --recursive)
endif


# Use "rm -rf data" to delete the data directory.  Be careful that
# you do not have any of your own files in the data directory before deleting.
removedata: remove-data
remove-data:
	-rm -ri data



###########################################################################
##
## Targets for adding/removing Humdrum website documentation
##

webdoc: doc
doc: checkgit
	git clone https://github.com/humdrum-tools/humdrum-tools.github.io doc


removedoc:     remove-doc
remove-webdoc: remove-doc
removewebdoc:  remove-doc
remove-doc:    checkgit
	-rm -rf doc


###########################################################################
##
## Update all submodules to their respective main branch versions
##

pull: update
update: checkgit
	(cd humextra/external/pcre-8.35; git checkout .)
	git pull
ifneq ($(wildcard .gitmodules),)
	git submodule sync
	git submodule update --init --recursive
	git submodule foreach "(git checkout main; git pull origin main)"
endif
ifneq ($(wildcard data),)
	(cd data && git pull)
	(cd data && git submodule update --init --recursive)
	(cd data && git submodule foreach "(git checkout main; git pull origin main)")
endif
ifneq ($(wildcard humextra/external/improv),)
	(cd humextra/external/improv && git pull)
endif
	@echo "[0;32mNow type \"make\" to compile the update[0m"



###########################################################################
##
## Make sure that the submodules are present for humdrum and humextra
##    If not, then download them.
##

check-recursive: check-recursive-humdrum check-recursive-humextra


check-recursive-humdrum: check-recursive-humdrum-pre
ifeq ($(wildcard humdrum/Makefile),)
	$(error install Humdrum Tookit before proceeeding)
endif


check-recursive-humdrum-pre:
ifeq ($(wildcard humdrum/Makefile),)
	@echo "[0;31m"
	@echo "*** Missing Makefile for Humdrum Toolkit.  You must run the command"
	@echo "***    [0;32mmake update[0;31m"
	@echo "*** before continuing."
	@echo "[0m"
	exit 1
endif


check-recursive-humextra: check-recursive-humextra-pre
ifeq ($(wildcard humextra/Makefile),)
	$(error install Humdrum Extras before proceeeding)
endif


check-recursive-humextra-pre:
ifeq ($(wildcard humextra/Makefile),)
	@echo "[0;31m"
	@echo "*** Missing Makefile for Humdrum Extras.  You must run the command"
	@echo "***    [0;32mgit update --init --recursive[0;31m"
	@echo "*** before continuing."
	@echo "[0m"
	exit 1
endif



###########################################################################
##
## Submodule compiling targets.
##

humdrum: humdrum-compile checkpath-humdrum

humdrum-compile:
ifeq (($shell which gcc),)
	@echo "[0;31m"
	@echo "*** Error: you must first install gcc.  If you are using OS X Mavericks"
	@echo "*** or later, then install with the command:"
	@echo "***    [0;32mxcode-select --install[0;31m"
	@echo "*** If you are using a flavor of linux, then try either of these commands:"
	@echo "***    [0;32myum install gcc[0;31m"
	@echo "***    [0;32mapt-get install gcc[0;31m"
	@echo "[0m"
	exit 1
endif
	(cd humdrum; $(ENV) $(MAKE) bin)


humextra: humextra-compile checkpath-humextra


humextra-compile:
ifeq (($shell which gcc),)
	@echo "[0;31m"
	@echo "*** Error: you must first install gcc.  If you are using OS X Mavericks"
	@echo "*** or later, then install with the command:"
	@echo "***    [0;32mxcode-select --install[0;31m"
	@echo "*** If you are using a flavor of linux, then try either of these commands:"
	@echo "***    [0;32myum install gcc[0;31m"
	@echo "***    [0;32mapt-get install gcc[0;31m"
	@echo "[0m"
	exit 1
endif
	(cd humextra; $(ENV) $(MAKE))


man:
	(cd humdrum; sudo $(ENV) $(MAKE) man);


###########################################################################
##
## Cleaning targets
##

clean: humdrum-clean humextra-clean improv-clean

# Improv library moved to humextra/external/improv
improv-clean:
ifneq ($(wildcard improv),)
	rm -rf improv
endif


super-clean: superclean
superclean: humdrum-clean humextra-clean remove-other

remove-other: remove-data remove-doc

humdrum-clean:
	(cd humdrum; $(ENV) $(MAKE) clean)

humextra-clean:
	(cd humextra; $(ENV) $(MAKE) clean)


###########################################################################
##
## Installing targets for setting up $PATH environmental variable.
##

install: humdrum-install humextra-install


install-humdrum: humdrum-install
humdrum-install:
ifneq ($(SHELLSCRIPT),)
   ifeq ($(HUMDRUM_PATH),)
	echo $(HUMDRUMINSTALL) >> $(SHELLSCRIPT)
	@echo "[0;32m"
	@echo "*** `pwd`/humdrum/bin added to command search path"
	@echo "*** in $(SHELLSCRIPT).  Now either close this shell and restart"
	@echo "*** another, or type the command:"
	@echo "***     [0;31msource $(SHELLSCRIPT)[0;32m"
	@echo "*** to update the \$$PATH environmental variable in the current"
	@echo "*** session.  Then type:"
	@echo "***     [0;31mwhich census[0;32m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;31m`pwd`/humdrum/bin/census[0;32m"
	@echo "[0m"
   else
      ifneq ($(HUMDRUM_PATH),$(HUMDRUM_TARGET))
	echo $(HUMDRUMINSTALL) >> $(SHELLSCRIPT)
	@echo "[0;31m"
	@echo "*** `pwd`/humdrum/bin added to command search path"
	@echo "*** in $(SHELLSCRIPT).  A different humdrum/bin directory already"
	@echo "*** exists in the command search path.  This installation will"
	@echo "*** shadow the one in:"
	@echo "***   [0;32m$(HUMDRUM_PATH)[0;31m"
	@echo "*** Now either close this shell and restart another, or type the command:"
	@echo "***     [0;32msource $(SHELLSCRIPT)[0;31m"
	@echo "*** to update the \$$PATH environmental variable in the current shell."
	@echo "*** Then type:"
	@echo "***     [0;32mwhich census[0;31m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;32m`pwd`/humdrum/bin/census[0;31m"
	@echo "[0m"
      else
	@echo ""
	@echo "[0;32mThe Humdrum Toolkit is already installed and should be ready to use.[0m"
	@echo ""
      endif
   endif
endif


install-humextra: humextra-install
humextra-install:
ifneq ($(SHELLSCRIPT),)
   ifeq ($(HUMEXTRA_PATH),)
	echo $(HUMEXTRAINSTALL) >> $(SHELLSCRIPT)
	@echo "[0;32m"
	@echo "*** `pwd`/humextra/bin added to command search path"
	@echo "*** in $(SHELLSCRIPT).  Now either close this shell and restart"
	@echo "*** another, or type the command:"
	@echo "***     [0;31msource $(SHELLSCRIPT)[0;32m"
	@echo "*** to update the \$$PATH environmental variable in the current"
	@echo "*** shell.  Then type:"
	@echo "***     [0;31mwhich keycor[0;32m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;31m`pwd`/humextra/bin/keycor[0;32m"
	@echo "[0m"
   else
      ifneq ($(HUMEXTRA_PATH),$(HUMEXTRA_TARGET))
	echo $(HUMEXTRAINSTALL) >> $(SHELLSCRIPT)
	@echo "[0;31m"
	@echo "*** `pwd`/humextra/bin added to command search path"
	@echo "*** in $(SHELLSCRIPT).  A different humextra/bin directory already"
	@echo "*** exists in the command search path.  This installation will"
	@echo "*** shadow the one in:"
	@echo "***   [0;32m$(HUMEXTRA_PATH)[0;31m"
	@echo "*** Now either close this shell and restart another, or type the command:"
	@echo "***     [0;32msource $(SHELLSCRIPT)[0;31m"
	@echo "*** to update the \$$PATH environmental variable in the current shell."
	@echo "*** Then type:"
	@echo "***     [0;32mwhich keycor[0;31m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;32m`pwd`/humextra/bin/keycor[0;31m"
	@echo "[0m"
      else
	@echo
	@echo "[0;32mHumdrum Toolkit is already installed.[0m"
	@echo
      endif
   endif
endif



###########################################################################
##
## See of the command path is found in $PATH.
##

install-hints: checkpath
installhints:  checkpath
installhint:   checkpath
install-hint:  checkpath
check-path:    checkpath
checkpath: checkpath-humdrum checkpath-humextra


checkpath-humdrum:
ifneq ($(SHELLSCRIPT),)
   ifeq ($(HUMDRUM_PATH),)
	@echo "[0;31m"
	@echo "*** For a single-user installation of the Humdrum Toolkit, type this command:"
	@echo "***    [0;32mecho \"PATH=`pwd`/humdrum/bin:\$$PATH\" >> $(SHELLSCRIPT)[0;31m"
	@echo "*** or type '[0;32mmake install[0;31m' to have this Makefile do this for you."
	@echo "*** Then type \"[0;32msource $(SHELLSCRIPT)[0;31m\" or relogin."
	@echo "[0m"
   else
      ifneq ($(HUMDRUM_PATH),$(HUMDRUM_TARGET))
	@echo "[0;31m"
	@echo "*** For a single-user installation of the Humdrum Toolkit, type this command:"
	@echo "***    [0;32mecho \"PATH=`pwd`/humdrum/bin:\$$PATH\" >> $(SHELLSCRIPT)[0;31m"
	@echo "*** Then type \"[0;32msource $(SHELLSCRIPT)[0;31m\" or relogin."
	@echo "***"
	@echo "*** However, a different humdrum/bin directory already exists in the command";
	@echo "*** search path.  This installation will be shadowed by the one in:";
	@echo "***   [0;32m$(HUMDRUM_PATH)[0;31m"
	@echo "*** Either move this installation to that location or remove the other"
	@echo "*** installation from the command search path (typically by editing the"
	@echo "*** PATH variable in $(SHELLSCRIPT) or the shell script in /etc)."
	@echo "***"
	@echo "*** Typing 'make install' for a single-user installation will hide the"
	@echo "*** other installation in $(HUMDRUM_PATH) and use this one instead."
	@echo "[0m"
      else
	@echo "[0;32m"
	@echo "*** The humdrum command path is configured properly in the PATH environment"
	@echo "*** variable.  Type '[0;31mwhich key[0;32m' to verify that you can see a"
	@echo "*** program in the humdrum/bin directory.  If the terminal replies with:"
	@echo "***    [0;31m$(HUMDRUM_PATH)/key[0;32m"
	@echo "*** then the Humdrum Toolkit is set up properly and ready for use."
	@echo "[0m"
      endif
   endif
endif



checkpath-humextra:
ifneq ($(SHELLSCRIPT),)
   ifeq ($(HUMEXTRA_PATH),)
	@echo "[0;31m"
	@echo "*** For a single-user installation of Humdrum Extras, type this command:"
	@echo "***    [0;32mecho \"PATH=`pwd`/humextra/bin:\$$PATH\" >> $(SHELLSCRIPT)[0;31m"
	@echo "*** or type '[0;32mmake install[0;31m' to have this Makefile do this for you."
	@echo "[0m"
   else
      ifneq ($(HUMEXTRA_PATH),$(HUMEXTRA_TARGET))
	@echo "[0;31m"
	@echo "*** For a single-user installation of Humdrum Extras, type this command:"
	@echo "***    [0;32mecho \"PATH=`pwd`/humextra/bin:\$$PATH\" >> $(SHELLSCRIPT)[0;31m"
	@echo "*** However, a different humextra/bin directory already exists in the command";
	@echo "*** search path.  This installation will be shadowed by the one in:";
	@echo "***   [0;32m$(HUMEXTRA_PATH)[0;31m"
	@echo "*** Either move this installation to that location or remove the other"
	@echo "*** installation from the command search path (typically by editing the"
	@echo "*** PATH variable in $(SHELLSCRIPT) or the shell script in /etc)."
	@echo "***"
	@echo "*** Typing 'make install' for a single-user installation will hide the"
	@echo "*** other installation in $(HUMEXTRA_PATH) and use this one instead."
	@echo "[0m"
      else
	@echo "[0;32m"
	@echo "*** The humextra command path is configured properly in the PATH environment"
	@echo "*** variable.  Type '[0;31mwhich keycor[0;32m' to verify that you can see a program in the"
	@echo "*** humextra/bin directory.  If the terminal replies with:"
	@echo "***    [0;31m$(HUMEXTRA_PATH)/keycor[0;32m"
	@echo "*** then Humdrum Extras is set up properly and ready for use."
	@echo "[0m"
      endif
   endif
endif



###########################################################################
##
## Run regression tests
##

regression: humdrum-regression humextra-regression


humextra-regression:
	(cd humextra; $(MAKE) regression)


humdrum-regression:
	(cd humdrum; $(MAKE) regression)



###########################################################################
##
## When doing certain targets, git is presumed to be installed, and
##   is presumed to be the method of downloading the repository.
##

checkgit:
ifeq ($(shell which git),)
	@echo "[0;31m"
	@echo "*** Error: to use the update target, you must have git command installed"
	@echo "[0m"
	exit 1
endif
ifeq ($(wildcard .git),)
	@echo "[0;31m"
	@echo "*** Error: to use the update target, you must have installed"
	@echo "*** the humdrum-tools repository with git:"
	@echo "***    [0;32mgit clone https://github.com/humdrum-tools/humdrum[0;31m"
	@echo "[0m"
	exit 1
endif


