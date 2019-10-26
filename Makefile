LIBS=-lpcre -lcrypto -lm -lpthread
CFLAGS=-ggdb -O3 -Wall
OBJS=hostagen.o oclhostagen.o oclhostaminer.o oclengine.o keyconv.o pattern.o util.o groestl.o
PROGS=hostagen keyconv oclhostagen oclhostaminer

PLATFORM=$(shell uname -s)
ifeq ($(PLATFORM),Darwin)
	OPENCL_LIBS=-framework OpenCL
	LIBS+=-L/usr/local/opt/openssl/lib
	CFLAGS+=-I/usr/local/opt/openssl/include
else ifeq ($(PLATFORM),NetBSD)
	LIBS+=`pcre-config --libs`
	CFLAGS+=`pcre-config --cflags`
else
	OPENCL_LIBS=-lOpenCL
endif


most: hostagen keyconv

all: $(PROGS)

hostagen: hostagen.o pattern.o util.o groestl.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

oclhostagen: oclhostagen.o oclengine.o pattern.o util.o groestl.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS)

oclhostaminer: oclhostaminer.o oclengine.o pattern.o util.o groestl.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS) -lcurl

keyconv: keyconv.o util.o groestl.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

clean:
	rm -f $(OBJS) $(PROGS) $(TESTS)
