SRC_NAME = coremark-1.01
SRC_URL=https://github.com/eembc/coremark/archive/refs/tags/v1.01.zip
THISDIR = $(shell pwd)

all: download_test extract_test
	$(MAKE) -C $(SRC_NAME) XCFLAGS="-DMULTITHREAD=8 -DUSE_PTHREAD" PORT_DIR=linux LFLAGS_END="-lpthread -lrt" compile

download_test:
	( if [ ! -f $(SRC_NAME).zip ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).zip $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		unzip -qq $(SRC_NAME).zip ; \
		sed -i 's#CC = gcc##' $(SRC_NAME)/linux/core_portme.mak ; \
	fi )

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) PORT_DIR=linux clean ; \
	fi ; 

romfs:
	$(ROMFSINST) -p +x $(THISDIR)/$(SRC_NAME)/coremark.exe /usr/bin/coremark
