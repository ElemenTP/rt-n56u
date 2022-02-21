SRC_NAME=json-c-json-c-0.15-20200726
SRC_URL=https://github.com/json-c/json-c/archive/json-c-0.15-20200726.tar.gz
ARCHIVE_NAME=json-c-0.15-20200726

all: download_test extract_test config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

download_test:
	( if [ ! -f $(ARCHIVE_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar zxf $(ARCHIVE_NAME).tar.gz; \
	fi )

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( mkdir -p $(SRC_NAME)/build && cd $(SRC_NAME)/build ; \
	cmake \
	-DCMAKE_INSTALL_PREFIX=$(STAGEDIR) \
	-DCMAKE_TOOLCHAIN_FILE=../../cross-mipsel-linux.cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_STATIC_LIBS=ON \
	.. \
	)

clean:
	rm -rf $(SRC_NAME)/build
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=""

romfs:
	cp -fP $(DESTDIR)/lib/libjson-c.so* $(ROMFSDIR)/lib
