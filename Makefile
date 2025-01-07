#LDFLAGS = -Wl,--start-group -Wl,--end-group -Wl,--as-needed -Wl,--gc-sections -flto 

# Redream (main engine)
OBJS =  \
	libgambatte/src/bitmap_font.o \
	libgambatte/src/bootloader.o \
	libgambatte/src/cpu.o \
	libgambatte/src/gambatte.o \
	libgambatte/src/initstate.o \
	libgambatte/src/interrupter.o \
	libgambatte/src/interruptrequester.o \
	libgambatte/src/loadres.o \
	libgambatte/src/memory.o \
	libgambatte/src/sound.o \
	libgambatte/src/state_osd_elements.o \
	libgambatte/src/statesaver.o \
	libgambatte/src/tima.o \
	libgambatte/src/video.o \
	libgambatte/src/mem/cartridge.o \
	libgambatte/src/mem/memptrs.o \
	libgambatte/src/mem/pakinfo.o \
	libgambatte/src/mem/rtc.o \
	libgambatte/src/sound/channel1.o \
	libgambatte/src/sound/channel2.o \
	libgambatte/src/sound/channel3.o \
	libgambatte/src/sound/channel4.o \
	libgambatte/src/sound/duty_unit.o \
	libgambatte/src/sound/envelope_unit.o \
	libgambatte/src/sound/length_counter.o \
	libgambatte/src/video/ly_counter.o \
	libgambatte/src/video/lyc_irq.o \
	libgambatte/src/video/next_m0_time.o \
	libgambatte/src/video/ppu.o \
	libgambatte/src/video/sprite_mapper.o
	
ifeq ($(NOZIP), YES)
OBJS += libgambatte/src/file/file.o
else
OBJS += libgambatte/src/file/file_zip.o libgambatte/src/file/unzip/ioapi.o libgambatte/src/file/unzip/unzip.o
endif
	
OBJS +=	gambatte_sdl/src/audiosink.o \
	gambatte_sdl/src/blitterwrapper.o \
	gambatte_sdl/src/parser.o \
	gambatte_sdl/src/sdlblitter.o \
	gambatte_sdl/src/str_to_sdlkey.o \
	gambatte_sdl/src/usec.o \
	gambatte_sdl/src/gambatte_sdl.o \
	gambatte_sdl/SFont.o \
	gambatte_sdl/menu.o \
	gambatte_sdl/libmenu.o \
	gambatte_sdl/scaler.o \
	common/adaptivesleep.o \
	common/resample/src/chainresampler.o \
	common/resample/src/i0.o \
	common/resample/src/kaiser50sinc.o \
	common/resample/src/kaiser70sinc.o \
	common/resample/src/makesinckernel.o \
	common/resample/src/resamplerinfo.o \
	common/resample/src/u48div.o \
	common/rateest.o \
	common/skipsched.o \
	common/videolink/rgb32conv.o \
	common/videolink/vfilterinfo.o
	

TARGET = Gambatte

# Define to build this as a prx (instead of a static elf)


PSPDEV=$(shell psp-config --pspdev-path)
PSPSDK=$(shell psp-config --pspsdk-path)

INCDIR  = $(PSPDEV)/psp/include/SDL libgambatte/src libgambatte/include common

CFLAGS = -Dmain=SDL_main -DVERSION_GCW0 -G0 -Wall -Wextra -O2 -fomit-frame-pointer -ffunction-sections -ffast-math -fsingle-precision-constant -fpermissive -Wno-maybe-uninitialized -DHAVE_STDINT_H
CXXFLAGS = -fno-exceptions -fno-rtti

EXTRA_TARGETS = EBOOT.PBP
PSP_EBOOT_TITLE = "Gambatte"
PSP_FW_VERSION = 500
BUILD_PRX=1

LIBS=-lSDLmain -lSDL_mixer -lSDL -lSDL_image -lpng -ljpeg -logg -lvorbisidec -logg -lmikmod -lstdc++ -lGL -lpspirkeyb -lpsprtc -lpsppower -lpspvfpu -lpng -ljpeg -lpspaudio -lpspgu -lpsphprm -lpspsdk -lz -lm 
OPT_FLAGS  = -Ofast -fdata-sections -fdata-sections -fno-common -fno-PIC -flto

include $(PSPSDK)/lib/build.mak
