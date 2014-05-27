## Master humdrum-tools GNU makefile.
##
## Programmer:    Craig Stuart Sapp <craig@ccrma.stanford.edu>
## Creation Date: Mon May 26 15:55:09 PDT 2014
## Last Modified: Mon May 26 18:38:47 PDT 2014
## Filename:      ...humdrum-tools/Makefile
##
## Description: This Makefile will compile programs in the humdrum and
##              humextra subdirectories.  You must first have gcc installed
##              on your computer.  Windows users should install in the
##              cygwin unix terminal (available from http://www.cygwin.com).
##
## To run this makefile, type (without quotes) "make".  After successful
## compiling, you must add the bin directories to your command search path.
## This can be done automatically with the command "make install".
##

# Targets which don't actually refer to files:
.PHONY : humextra humdrum

# Variables used to give hints about setup for $PATH environmental variable:
HUMEXTRA_PATH   := $(shell echo $$PATH |tr : '\n'|grep 'humextra/bin'|head -n 1)
HUMEXTRA_TARGET := $(shell echo `pwd`/humextra/bin)
HUMDRUM_PATH    := $(shell echo $$PATH |tr : '\n'|grep 'humdrum/bin'|head -n 1)
HUMDRUM_TARGET  := $(shell echo `pwd`/humdrum/bin)

###########################################################################
#                                                                         #
#                                                                         #

all: humdrum humextra checkpath

help: info
info:
	@echo
	@echo "make           -- Make both humdrum and humextra packages."
	@echo "make humdrum   -- Make Humdrum Toolkit package."
	@echo "make humextra  -- Make Humdrum Extras package."
	@echo "make install   -- Add package bin directories to \$$PATH in ~/.profile."
	@echo "make checkpath -- Check if \$$PATH points to package binaries."
	@echo

humdrum:
	(cd humdrum; $(ENV) $(MAKE))


humextra:
	(cd humextra; $(ENV) $(MAKE))


clean: humdrum-clean humextra-clean


humdrum-clean:
	(cd humdrum; $(ENV) $(MAKE) clean)


humextra-clean:
	(cd humextra; $(ENV) $(MAKE) clean)


install: humdrum-install humextra-install


install-humdrum: humdrum-install
humdrum-install:

ifeq (,$(HUMDRUM_PATH))
	echo "PATH=`pwd`/humdrum/bin:\$$PATH" >> ~/.profile
	@echo "[0;32m"
	@echo "*** `pwd`/humdrum/bin added to command search path"
	@echo "*** in ~/.profile.  Now either close this shell and restart"
	@echo "*** another, or type the command:"
	@echo "***     [0;31msource ~/.profile[0;32m"
	@echo "*** to update the \$$PATH environmental variable in the current"
	@echo "*** shell.  Then type:"
	@echo "***     [0;31mwhich census[0;32m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;31m`pwd`/humdrum/bin/census[0;32m"
	@echo "[0m"
else ifneq ($HUMDRUM_PATH,$HUMDRUM_TARGET)
	echo "PATH=`pwd`/humdrum/bin:\$$PATH" >> ~/.profile
	@echo "[0;31m"
	@echo "*** `pwd`/humdrum/bin added to command search path"
	@echo "*** in ~/.profile.  A different humdrum/bin directory already"
	@echo "*** exists in the command search path.  This installation will"
	@echo "*** shadow the one in:"
	@echo "***   [0;32m$(HUMDRUM_PATH)[0;31m"
	@echo "*** Now either close this shell and restart another, or type the command:"
	@echo "***     [0;32msource ~/.profile[0;31m"
	@echo "*** to update the \$$PATH environmental variable in the current shell."
	@echo "*** Then type:"
	@echo "***     [0;32mwhich census[0;31m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;32m`pwd`/humdrum/bin/census[0;31m"
	@echo "[0m"
else
	@echo ""
	@echo "[0;32mHumdrum Toolkit is already installed.[0m"
	@echo ""
endif


install-humextra: humextra-install
humextra-install:

ifeq (,$(HUMEXTRA_PATH))
	echo "PATH=`pwd`/humextra/bin:\$$PATH" >> ~/.profile
	@echo "[0;32m"
	@echo "*** `pwd`/humextra/bin added to command search path"
	@echo "*** in ~/.profile.  Now either close this shell and restart"
	@echo "*** another, or type the command:"
	@echo "***     [0;31msource ~/.profile[0;32m"
	@echo "*** to update the \$$PATH environmental variable in the current"
	@echo "*** shell.  Then type:"
	@echo "***     [0;31mwhich census[0;32m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;31m`pwd`/humextra/bin/census[0;32m"
	@echo "[0m"
else ifneq ($HUMEXTRA_PATH,$HUMEXTRA_TARGET)
	echo "PATH=`pwd`/humextra/bin:\$$PATH" >> ~/.profile
	@echo "[0;31m"
	@echo "*** `pwd`/humextra/bin added to command search path"
	@echo "*** in ~/.profile.  A different humextra/bin directory already"
	@echo "*** exists in the command search path.  This installation will"
	@echo "*** shadow the one in:"
	@echo "***   [0;32m$(HUMEXTRA_PATH)[0;31m"
	@echo "*** Now either close this shell and restart another, or type the command:"
	@echo "***     [0;32msource ~/.profile[0;31m"
	@echo "*** to update the \$$PATH environmental variable in the current shell."
	@echo "*** Then type:"
	@echo "***     [0;32mwhich census[0;31m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;32m`pwd`/humextra/bin/census[0;31m"
	@echo "[0m"
else
	@echo ""
	@echo "[0;32mHumdrum Toolkit is already installed.[0m"
	@echo ""
endif


checkpath: checkpath-humdrum checkpath-humextra


checkpath-humdrum:

ifeq (,$(HUMDRUM_PATH))
	@echo "[0;31m"
	@echo "*** To finish installation, add humdrum/bin to the command search path."
	@echo "*** Typically this is done with the command:"
	@echo "***    [0;32mecho \"PATH=\$$PATH:`pwd`/humdrum/bin\" >> ~/.profile"
	@echo "[0m"
else ifneq ($HUMDRUM_PATH,$HUMDRUM_TARGET)
	@echo "[0;31m"
	@echo "*** A different humdrum/bin directory already exists in the command search";
	@echo "*** path.  This installation will be shadowed by the one in:";
	@echo "***   [0;32m$(HUMDRUM_PATH)[0;31m"
	@echo "*** Either move this installation to that location or remove the other"
	@echo "*** installation from the command search path (typically by editing the"
	@echo "*** PATH variable in ~/.profile or in /etc/profile)."
	@echo "[0m"
else
	@echo ""
	@echo "[0;32mSuccessful humdrum make![0m"
	@echo ""
endif


checkpath-humextra:

ifeq (,$(HUMEXTRA_PATH))
	@echo "[0;31m"
	@echo "*** To finish installation, add humextra/bin to the command search path."
	@echo "*** Typically this is done with the command:"
	@echo "***    [0;32mecho \"PATH=\$$PATH:`pwd`/humextra/bin\" >> ~/.profile"
	@echo "[0m"
else ifneq ($HUMEXTRA_PATH,$HUMEXTRA_TARGET)
	@echo "[0;31m"
	@echo "*** A different humextra/bin directory already exists in the command search";
	@echo "*** path.  This installation will be shadowed by the one in:";
	@echo "***   [0;32m$(HUMEXTRA_PATH)[0;31m"
	@echo "*** Either move this installation to that location or remove the other"
	@echo "*** installation from the command search path (typically by editing the"
	@echo "*** PATH variable in ~/.profile or in /etc/profile)."
	@echo "[0m"
else
	@echo ""
	@echo "[0;32mSuccessful humextra make![0m"
	@echo ""
endif

#                                                                         #
#                                                                         #
###########################################################################



