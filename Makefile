CC=gcc
CFLAGS=-Wall -pthread -g
SDIR=src
ODIR=build
SRC_FILE_TYPE=.c

TARGET=a.out

SRCDIRS=$(shell find $(SDIR) -type d)

$(shell mkdir -p $$(echo $(SRCDIRS) | sed 's/'$(SDIR)'/'$(ODIR)'/g'))
TMP=$(subst $(SDIR),$(ODIR),$(shell find $(SDIR) -type f -name *$(SRC_FILE_TYPE)))
OFILES=$(TMP:$(SRC_FILE_TYPE)=.o)

all: $(TARGET) post_build

$(TARGET) : $(OFILES)
	$(CC) $(CFLAGS) -o $(TARGET) $(OFILES)

$(ODIR)/%.o : $(SDIR)/%$(SRC_FILE_TYPE)
	$(CC) -c -o $@ $< $(CFLAGS)

post_build:
	rm -rf $(ODIR)

clean:
	rm -rf $(ODIR) $(TARGET)
