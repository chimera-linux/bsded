CC      ?= cc
CFLAGS  ?= -O2
PREFIX  ?= /usr/local
BINDIR  ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share
MANDIR  ?= $(DATADIR)/man/man1
EXTRA_CFLAGS = -Wall -Wextra -I. -Dlint

OBJS = buf.o glbl.o io.o main.o re.o sub.o undo.o

PROGRAM = ed

.PHONY: clean

all: $(PROGRAM)

.c.o:
	$(CC) -c -o $@ $< $(EXTRA_CFLAGS) $(CFLAGS)

$(PROGRAM): $(OBJS)
	$(CC) $(EXTRA_CFLAGS) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(PROGRAM)

clean:
	rm -f $(OBJS) $(PROGRAM) test/*.ed test/*.red test/*.z

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(PROGRAM) $(DESTDIR)$(BINDIR)/$(PROGRAM)
	install -d $(DESTDIR)$(MANDIR)
	install -m 644 $(PROGRAM).1 $(DESTDIR)$(MANDIR)/$(PROGRAM).1
	ln -sf $(PROGRAM) $(DESTDIR)$(BINDIR)/r$(PROGRAM)
	ln -sf $(PROGRAM).1 $(DESTDIR)$(MANDIR)/r$(PROGRAM).1

check: $(PROGRAM)
	./test.sh $(PROGRAM) || exit 1
