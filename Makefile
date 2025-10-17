# mission_control Makefile
#
# This does Make stuff, like building the entire project into a nice package
# with minimal drama! This should work across all three major systems
# (MacOS, Linux, Windows)
#
# GCC is assumed since it's fairly universal but you're welcome to modify
# as needed!

CC := gcc
LD := $(CC)

# Sources and output dir/file
SRC := src
INC := include
OUT_D := bin
OUT_F := mission_control

# Lots and lots of flags
OSX_HOMEBREW_INCL := $(shell brew --prefix ncurses)/include
OSX_HOMEBREW_LIBS := $(shell brew --prefix ncurses)/lib
CFLAGS  := -Wall -Wextra -Wpedantic -Wshadow -Wconversion -O1 -std=c99 \
			-Wdouble-promotion -Wundef -Wnull-dereference -Wpointer-arith \
			-Wmissing-declarations -Wcast-align -Wformat-security \
			-fomit-frame-pointer -fstack-clash-protection -fPIE \
			-funroll-loops -fno-common -fstack-protector-strong

LDFLAGS := -lncurses -lform -lpanel -lmenu -lm -Wl,-z,now \
			-Wl,-O1 -Wl,--as-needed -s -Wl,-pie

$(OUT_D):
	@mkdir -p $(OUT_D)

## MacOS build rule (Assumes Apple Silicon)
macos: $(OUT_D)
	@echo "Building for MacOS..."
	$(CC) $(CFLAGS) $(LDFLAGS) -I$(OSX_HOMEBREW_INCL) \
	$(SRC)/*.c -L$(OSX_HOMEBREW_LIBS) \
	-o $(OUT_D)/$(OUT_F)

linux:
	@echo "Building for Linux..."
	$(CC) $(CFLAGS) $(SRC)/*.c -o $(OUT_D)/$(OUT_F) $(LDFLAGS)

win:
	@echo "Building for Windows..."
