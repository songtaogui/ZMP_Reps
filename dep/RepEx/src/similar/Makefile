#-- Imported variables from top level makefile
# BIN_DIR CXX CC CFLAGS CXXFLAGS LDFLAGS

ifndef BIN_DIR
BIN_DIR := $(CURDIR)
endif


OBJ_RULE = $(CXX) $(CXXFLAGS) $< -c -o $@
BIN_RULE = $(CXX) $(CXXFLAGS) $^ -o $(BIN_DIR)/$@; \
           chmod 755 $(BIN_DIR)/$@

ALL := similar gaps \
     direct \
     
     
#-- PHONY rules --#
.PHONY: all clean


all: $(ALL)


clean:
	rm -f *.o *~
	cd $(BIN_DIR); rm -f $(ALL)




#-- not so PHONY rules --#

similar: similar.cc tigrinc.o
	$(BIN_RULE)


gaps: gaps.cc tigrinc.o
	$(BIN_RULE)


direct: direct.cc tigrinc.o
	$(BIN_RULE)

