### Machine flags
#
CC_CMACH    = -mmcu=cc430f6137
CC_DMACH    = -D__CC430F6137__
LINKER_FILE = "./wbsl_cc430f6137.ld"
### Build flags
#
# -fdata-sections, -ffunction-sections and -Wl,--gc-sections -Wl,-s
# are used for dead code elimination, see:
# http://gcc.gnu.org/ml/gcc-help/2003-08/msg00128.html
#
CFLAGS      += $(CC_CMACH) $(CC_DMACH) -Wall  
CFLAGS      += -fno-force-addr -finline-limit=1 -fno-schedule-insns -minrt

CFLAGS      += -mhwmult=none -fshort-enums -Wl,-Map=wbsl.map,-verbose -T$(LINKER_FILE)
LDFLAGS     = -L$(MSP430_TI)/include 

CFLAGS_REL  += -Os -fdata-sections -ffunction-sections -fomit-frame-pointer 
LDFLAGS_REL += -Wl,--gc-sections -Wl,-s

CFLAGS_DBG  += -O1 -g3 -gdwarf-2 -ggdb
LDFLAGS_DBG += -Wl,--gc-sections


CFLAGS_REL_NOSTRIP  += -Os -fdata-sections -ffunction-sections -fomit-frame-pointer -g3 -gdwarf-2 -ggdb
LDFLAGS_REL_NOSTRIP += -Wl,--gc-sections 

# linker flags and include directories
# Not really sure about this include. There must be a better way ?
INCLUDES    += -I./ -I$(MSP430_TI)/include -I$(MSP430_TI)/msp430-elf/include -I$(MSP430_TI)/lib/gcc/msp430-elf/4.9.1/include
### Build tools
# 
CC      = msp430-elf-gcc
LD      = msp430-elf-ld
AS      = msp430-elf-as
AR      = msp430-elf-ar
OBJDUMP = msp430-elf-objdump
