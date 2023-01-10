SRC_NAME=flac-1.4.2
SRC_URL=https://ftp.osuosl.org/pub/xiph/releases/flac/$(SRC_NAME).tar.xz

all: download_test extract_test config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

download_test:
	( if [ ! -f $(SRC_NAME).tar.xz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.xz $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar xJf $(SRC_NAME).tar.xz ; \
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
	-DBUILD_CXXLIBS=Off \
	-DBUILD_DOCS=Off \
	-DBUILD_EXAMPLES=Off \
	-DBUILD_PROGRAMS=Off \
	-DBUILD_SHARED_LIBS=$(if $(LIBS_BUILD_SHARED),On,Off) \
	-DBUILD_TESTING=Off \
	-DBUILD_UTILS=Off \
	-DINSTALL_MANPAGES=Off \
	-DWITH_ASM=Off \
	-DWITH_FORTIFY_SOURCE=Off \
	-DWITH_OGG=Off \
	-DWITH_STACK_PROTECTOR=Off \
	.. \
	)

clean:
	rm -rf $(SRC_NAME)/build
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=""

romfs:
ifeq ($(LIBS_BUILD_SHARED),y)
	cp -fP $(DESTDIR)/lib/libFLAC.so* $(ROMFSDIR)/lib ;
endif
