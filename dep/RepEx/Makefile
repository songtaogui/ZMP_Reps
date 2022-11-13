#-------------------------------------------------------------------------------
#  Top level makefile for RepEx
#
#  Dependencies: '/bin/sh', 'g++', 'gcc', 'csh', 'perl', 'sed'
#
#  'make all' builds RepEX
#
#  'make check' checks for the existance of the RepEx dependencies
#
#  'make clean' removes *.o *~ core* and executable files
#
#  'make uninstall' alias for 'make clean' (for compatibility)
#
#-------------------------------------------------------------------------------
SHELL = /bin/sh
VERSION := 3.23


TOP_DIR     := $(CURDIR)
BIN_DIR     := $(TOP_DIR)/src/bin

IDENTICAL_DIR  := $(TOP_DIR)/src/identical
SIMILAR_DIR := $(TOP_DIR)/src/similar


CC   := $(filter /%,$(shell /bin/sh -c 'type gcc'))
CXX  := $(filter /%,$(shell /bin/sh -c 'type g++'))
SED  := $(filter /%,$(shell /bin/sh -c 'type sed'))
CSH  := $(filter /%,$(shell /bin/sh -c 'type csh'))
PERL := $(filter /%,$(shell /bin/sh -c 'type perl'))
AR   := $(filter /%,$(shell /bin/sh -c 'type ar'))

CXXFLAGS = -O3
CFLAGS = -O3
LDFLAGS  =

FLATS = ACKNOWLEDGEMENTS README Makefile 



#-- EXPORT THESE VARIABLES TO OTHER MAKEFILES

export BIN_DIR CXX CC CFLAGS CXXFLAGS LDFLAGS
export PATH:=$(BIN_DIR):$(PATH)

#-- PHONY rules --#
.PHONY: all check clean test uninstall


all: 	identical similar

	@chmod 755 $(BIN_DIR)/*
	@perl -e 'print "\n\n\n","#" x 5,"\t\tRepEx is ready to rock n roll !!!\t\t","#" x 5,"\n","#" x 5,"\t\t"," "x6,"Thank you for installing\t\t"," " x 8,"#" x 5,"\n\n"'

check:
ifndef TOP_DIR
	@echo "ERROR: could not find working directory"
endif
ifndef CC
	@echo "ERROR: 'gcc' GNU C compiler not found \nPlease install gcc !!"
endif
ifndef CXX
	@echo "ERROR: 'g++' GNU C++ compiler not found \nPlease install g++ !!"
endif
ifndef SED
	@echo "ERROR: 'sed' StreamEDitor not found \nPlease install sed !!"
endif
ifndef CSH
	@echo "ERROR: 'csh' C-shell not found  \nPlease install csh !!"
endif
ifndef PERL
	@echo "ERROR: 'perl' PERL not found  \nPlease install perl !!"
endif
ifndef AR
	@echo "ERROR: 'ar' GNU archiver not found  \nPlease install ar !!"
endif
	@echo "check complete"


clean:
	rm -f *~ core*
	cd $(IDENTICAL_DIR); $(MAKE) clean
	cd $(SIMILAR_DIR); $(MAKE) clean


install: all


identical:
	cd $(IDENTICAL_DIR); $(MAKE) identical


similar:
	cd $(SIMILAR_DIR); $(MAKE) all


test:
    	
	@perl -e 'print "\n\n\n","#"x5,"\n","# Testing RepEx\n","#"x5,"\n.\n.\n.\n.\n.\n"';
	@cd $(TOP_DIR)/src/bin ; \
	perl repex -f $(TOP_DIR)/test/test.seq ; 
	@perl -e 'print "\n\n","#"x5,"\t\t\tRepEx is running fine\t\t\t","#"x5,"\n","Use your favourite text editor to view the result $(CURDIR)/test/test.seq.identical","\n\n"';


uninstall: clean


#-- END OF MAKEFILE --#
