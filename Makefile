CC=g++
CFLAGS=-Wall -pthread -g
SDIR=src
ODIR=build
SRC_FILE_TYPE=.cpp

TARGET=a.out

SRCDIRS=$(shell find $(SDIR) -type d)

$(shell mkdir -p $$(echo $(SRCDIRS) | sed 's/'$(SDIR)'/'$(ODIR)'/g'))
TMP=$(subst $(SDIR),$(ODIR),$(shell find $(SDIR) -type f -name *$(SRC_FILE_TYPE)))
OFILES=$(TMP:.cpp=.o)

all: $(TARGET)

$(TARGET) : $(OFILES)
	$(CC) $(CFLAGS) -o $(TARGET) $(OFILES)

$(ODIR)/%.o : $(SDIR)/%$(SRC_FILE_TYPE)
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -rf $(ODIR) $(TARGET)
