SUBDIRS = 

include Common.mk

PYTHON := $(shell which python2 || which python)
BASH := $(shell which bash || which bash)

.PHONY: all
.PHONY: clean
.PHONY: install
.PHONY: config
.PHONY: depend
.PHONY: doc
.PHONY: httpdoc
.PHONY: force

all: wbsl.txt

#
# Build list of sources and objects to build
SRCS := $(wildcard *.c)
OBJS := $(patsubst %.c,%.o,$(SRCS))

#
# Dependencies rules

#
# Append specific CFLAGS/LDFLAGS
#DEBUG := $(shell grep "^\#define CONFIG_DEBUG" project_defs.h)
#DEBUG := y
ifeq ($(DEBUG),)
TARGET	:= RELEASE
CFLAGS	+= $(CFLAGS_REL)
LDFLAGS	+= $(LDFLAGS_REL)
else
TARGET	:= DEBUG
CFLAGS	+= $(CFLAGS_DBG)
LDFLAGS	+= $(LDFLAGS_DBG)
endif

# rebuild if CFLAGS changed, as suggested in:
# http://stackoverflow.com/questions/3236145/force-gnu-make-to-rebuild-objects-affected-by-compiler-definition/3237349#3237349
wbsl.cflags: force
	@echo "$(CFLAGS)" | cmp -s - $@ || echo "$(CFLAGS)" > $@

$(OBJS): wbsl.cflags
#
# Top rules

wbsl.elf: $(OBJS)
	@echo "\n>> Building $@ as target $(TARGET)"
	$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDES) -o $@ $+
	$(OBJDUMP) -w wbsl.elf  -S -t -D -x> wbsl.disassembly

wbsl.txt: wbsl.elf
	$(PYTHON) tools/memory.py -i $< -o $@

%.o: %.c
	@echo "CC $<"
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

install: wbsl.txt
	contrib/ChronosTool.py rfbsl $<

usb-install: wbsl.elf
	mspdebug rf2500 "prog wbsl.elf"

clean: $(SUBDIRS)
	@for subdir in $(SUBDIRS); do \
		echo "Cleaning $$subdir .."; rm -f $$subdir/*.o; \
	done
	@rm -f *.o wbsl.elf wbsl.txt wbsl.cflags wbsl.dep output.map
	@rm -f wbsl.dep.bak

