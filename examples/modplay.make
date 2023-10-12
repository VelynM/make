APPS += modplay

modplay_TARGET  = modplay
modplay_SOURCES = modplay.c ustplay.c stivplay.c mstplay.c st20play.c \
                  st24play.c nt11play.c nt20play.c hmnplay.c pt11play.c \
                  ptdetect.c paula.c s3mplay.c xmplay.c itplay.c mixbase.c \
                  mixer.c utils.c md5.c crc32.c request.c \
                  database.c playlist.c stdout.c

modplay_UNIX_SOURCES = unix/output.c unix/tty.c
modplay_WIN_SOURCES  = win/output.c win/tty.c

ifeq ($(PLATFORM),darwin)
 modplay_SOURCES        += $(modplay_UNIX_SOURCES) coreaudio.c audioqueue.c
 modplay_base_CFLAGS     = -I.
 modplay_base_LDLIBS     = -lpthread -lz -lbz2 -lm -lsqlite3
 modplay_base_LDLIBS    += -framework AudioUnit -framework CoreAudio \
                           -framework AudioToolbox -framework CoreServices
endif

ifeq ($(PLATFORM),ios)
 modplay_SOURCES        += $(modplay_UNIX_SOURCES) coreaudio.c audioqueue.c
 modplay_base_CFLAGS     = -I.
 modplay_base_LDLIBS     = -lpthread -lz -lbz2 -lm -lsqlite3
 modplay_base_LDLIBS    += -framework CoreAudio -framework AudioToolbox \
                           -framework CoreFoundation
endif

ifeq ($(PLATFORM),linux)
 modplay_SOURCES        += $(modplay_UNIX_SOURCES)
 modplay_base_CFLAGS     = -I. -D_POSIX_SOURCE -D_POSIX_C_SOURCE=200112L
 modplay_base_LDLIBS     = -lpthread -lz -lbz2 -lm -lsqlite3
endif

ifeq ($(PLATFORM),cygwin)
 modplay_SOURCES        += $(modplay_UNIX_SOURCES) waveout.c
 modplay_base_CFLAGS     = -I.
 modplay_base_LDLIBS     = -lpthread -lz -lbz2 -lm -lsqlite3 -lwinmm
endif

ifeq ($(PLATFORM),mingw)
 modplay_SOURCES        += $(modplay_WIN_SOURCES) waveout.c sqlite3.c
 modplay_base_CFLAGS     = -I.
 modplay_base_LDLIBS     = -lpthread -lz -lbz2 -lm -lwinmm

endif

ifeq ($(PLATFORM),vc)
endif

