URWEB ?= urweb
INCL = $(shell $(URWEB) -print-cinclude)
CC =  $(shell $(URWEB) -print-ccompiler)
all: Script.o

Script.o : Script.c
	$(CC) -c -I $(INCL) -o $@ $^
