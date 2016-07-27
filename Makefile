# Top-level VMGL makefile
# Copyright (c) H. Andres Lagar-Cavilla, University of Toronto, 2006-2007

MAKE = make
XMKMF = xmkmf
INSTALL = install
INSTALL_FLAGS := -m 0755
# INSTALL_FLAGS := -s -m 0755
CONFIGURE = ./configure
RM = rm

TOP = $(shell pwd)
SUBDIRS = tightvnc tightvnc/Xvnc

DOM0_BIN = vncviewer glstub stub-daemon
DOMU_BIN = Xvnc
DOM0_LIB = libcrutil.so libspuload.so liberrorspu.so librenderspu.so
DOMU_LIB = libcrutil.so libspuload.so liberrorspu.so libvmgl.so libarrayspu.so libfeedbackspu.so libpackspu.so libpassthroughspu.so

ifdef VMGLPATH
INSTALLPATH = $(VMGLPATH)
else
INSTALLPATH = /usr/local/
endif

all:
	$(INSTALL) -d $(TOP)/dist/lib/
	$(INSTALL) -d $(TOP)/dist/bin/
	(cd tightvnc ; \
	    $(XMKMF) -a ; \
	    $(MAKE) ; \
	    $(INSTALL) $(INSTALL_FLAGS) vncviewer/vncviewer ../dist/bin/vncviewer ; \
	    cd Xvnc ; \
		$(CONFIGURE) ; \
		$(MAKE) ; \
		$(INSTALL) $(INSTALL_FLAGS) programs/Xserver/Xvnc ../../dist/bin/Xvnc ; \
	) || exit 1

clean:
	@for dir in $(SUBDIRS) ; do \
		(cd $$dir ; $(MAKE) clean) ; \
	done

