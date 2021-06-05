TARGET = Sloppy Bork

# Define to build this as a prx (instead of a static elf)
BUILD_PRX=1

CC     = psp-gcc
CXX    = psp-g++

PROG   = $(TARGET).elf
PSPDEV = $(shell psp-config -P)
PSPSDK = $(shell psp-config -p)

INCDIR  = $(PSPDEV)/include $(PSPDEV)/include/SDL $(PSPSDK)/include 
INCDIR += libgambatte/src libgambatte/include

INCLUDES = -Ilibgambatte/src -Ilibgambatte/include -Icommon -I/usr/local/pspdev/psp/sdk/include -I/usr/local/pspdev/psp/include/SDL

CFLAGS = -DVERSION_GCW0 -Wall -Wextra -O2 -fomit-frame-pointer -ffunction-sections -ffast-math -fsingle-precision-constant -g0 $(INCLUDES)
CXXFLAGS = $(CFLAGS) -fno-exceptions -fno-rtti

CPPPATH = libgambatte/src libgambatte/include

CC = psp-gcc
CXX = psp-g++

SDL_CFLAGS  := -I$(PSPDEV)/psp/include/SDL

OUTPUTNAME = EBOOT.PBP
EXTRA_TARGETS = EBOOT.PBP

DEFINES = -DHAVE_STDINT_H
INCLUDES = -Isrc/gambatte_sdl -Ilibgambatte -Icommon -Iinclude -Ilibgambatte/include -Ilibgambatte/src $(SDL_CFLAGS)
OPT_FLAGS  = -Ofast -fdata-sections -fdata-sections -fno-common -fno-PIC -flto
EXTRA_LDFLAGS = -lSDL -lpspaudio -lvorbis -lmikmod -Wl,--as-needed -Wl,--gc-sections -flto -s

include common.mk
include $(PSPSDK)/lib/build.mak

clean:
	$(RM) EBOOT.PBP PARAM.sfo $(PROG) $(OBJS) $(OBJS_CPU) $(DRIVERS)
