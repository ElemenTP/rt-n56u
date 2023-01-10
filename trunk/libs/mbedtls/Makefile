SRC_NAME=mbedtls-3.3.0
SRC_URL=https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/v3.3.0.tar.gz

all: download_test extract_test config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

download_test:
	( if [ ! -f $(SRC_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.gz $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar -xf $(SRC_NAME).tar.gz; \
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
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=$(STAGEDIR) \
	-DCMAKE_TOOLCHAIN_FILE=$(ROOTDIR)/cmake/cross-mipsel-linux.cmake \
	-DUSE_SHARED_MBEDTLS_LIBRARY=On \
	-DUSE_STATIC_MBEDTLS_LIBRARY=Off \
	-DENABLE_TESTING=Off \
	-DENABLE_PROGRAMS=Off \
	-DLINK_WITH_PTHREAD=On \
	-DGEN_FILES=Off \
	.. \
	)

clean:
	rm -rf $(SRC_NAME)/build
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=""

romfs:
	cp -fP $(DESTDIR)/library/libmbedcrypto.so* $(ROMFSDIR)/lib
	cp -fP $(DESTDIR)/library/libmbedtls.so* $(ROMFSDIR)/lib
	cp -fP $(DESTDIR)/library/libmbedx509.so* $(ROMFSDIR)/lib
