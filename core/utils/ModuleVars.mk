# ModuleVars.mk for utils module
# Copyright (c) 2008 Rene Brun and Fons Rademakers
#
# Author: Axel Naumann, 2008-06-10

ifneq ($(HOST),)

UTILSDIRS       := $(BUILDTOOLSDIR)/core/utils/src

ROOTCLINGS      := $(UTILSDIRS)/rootcling.cxx \
                   $(filter-out %RStl.cxx,$(filter-out %root%.cxx,$(filter-out %_tmp.cxx,$(wildcard $(UTILSDIRS)/*.cxx))))
ROOTCLINGTMPS   := $(ROOTCLINGS:.cxx=_tmp.cxx)
ROOTCLINGTMPO   := $(ROOTCLINGS:.cxx=_tmp.o)
ROOTCLINGTMPEXE := $(UTILSDIRS)/rootcling_tmp$(EXEEXT)
ROOTCINTTMP     := $(ROOTCLINGTMPEXE)

##### Dependencies for all dictionaries
ROOTCINTTMPDEP   = $(ROOTCLINGTMPO) $(ROOTCLINGTMPEXE)

else # ifneq ($(HOST),)

MODNAME      := utils

MODDIR       := $(ROOT_SRCDIR)/core/$(MODNAME)
MODDIRS      := $(MODDIR)/src
MODDIRI      := $(MODDIR)/inc

UTILSDIR     := $(MODDIR)
UTILSDIRS    := $(UTILSDIR)/src
UTILSDIRI    := $(UTILSDIR)/inc

##### rootcling #####
ROOTCLINGUTILS  := $(filter-out %/rootcling.cxx %/RStl.cxx %_tmp.cxx,\
                   $(wildcard $(UTILSDIRS)/*.cxx))
ROOTCLINGUTILO  := $(call stripsrc,$(ROOTCLINGUTILS:.cxx=.o))
ROOTCLINGS      := $(wildcard $(UTILSDIRS)/rootcling.cxx)
ROOTCLINGO      := $(call stripsrc,$(ROOTCLINGS:.cxx=.o))
ROOTCLINGTMPS   := $(call stripsrc,$(ROOTCLINGS:.cxx=_tmp.cxx))
ROOTCLINGTMPO   := $(ROOTCLINGTMPS:.cxx=.o)
ROOTCLINGDEP    := $(ROOTCLINGO:.o=.d) $(ROOTCLINGTMPO:.o=.d) $(ROOTCLINGUTILO:.o=.d)

ROOTCLINGTMPEXE := $(call stripsrc,$(UTILSDIRS)/rootcling_tmp$(EXEEXT))
ROOTCLINGEXE    := bin/rootcling$(EXEEXT)
ROOTCINTEXE     := bin/rootcint$(EXEEXT)
GENREFLEXEXE    := bin/genreflex$(EXEEXT)
ROOTCINTTMP     := $(ROOTCLINGTMPEXE)

##### Dependencies for all dictionaries
ROOTCINTTMPDEP  = $(ROOTCLINGTMPO) $(ROOTCLINGTMPEXE)

# include all dependency files
INCLUDEFILES += $(ROOTCLINGDEP)

ROOTCLINGCXXFLAGS = $(filter-out -Wcast-qual,$(CLINGCXXFLAGS))
ifneq ($(CXX:g++=),$(CXX))
ROOTCLINGCXXFLAGS += -Wno-shadow -Wno-unused-parameter
endif

endif # ifneq ($(HOST),)
