SRC_NAME=libxml2-2.10.3
SRC_URL=https://download.gnome.org/sources/libxml2/2.10/libxml2-2.10.3.tar.xz

all: download_test extract_test config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

download_test:
	( if [ ! -f $(SRC_NAME).tar.xz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.xz $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar xf $(SRC_NAME).tar.xz ; \
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
	-DBUILD_SHARED_LIBS=Off \
	-DLIBXML2_WITH_C14N=On \
	-DLIBXML2_WITH_CATALOG=Off \
	-DLIBXML2_WITH_DEBUG=Off \
	-DLIBXML2_WITH_FTP=Off \
	-DLIBXML2_WITH_HTML=On \
	-DLIBXML2_WITH_HTTP=Off \
	-DLIBXML2_WITH_ICONV=Off \
	-DLIBXML2_WITH_ICU=Off \
	-DLIBXML2_WITH_ISO8859X=Off \
	-DLIBXML2_WITH_LEGACY=Off \
	-DLIBXML2_WITH_LZMA=Off \
	-DLIBXML2_WITH_MEM_DEBUG=Off \
	-DLIBXML2_WITH_MODULES=Off \
	-DLIBXML2_WITH_OUTPUT=On \
	-DLIBXML2_WITH_PATTERN=On \
	-DLIBXML2_WITH_PROGRAMS=Off \
	-DLIBXML2_WITH_PUSH=On \
	-DLIBXML2_WITH_PYTHON=Off \
	-DLIBXML2_WITH_READER=On \
	-DLIBXML2_WITH_REGEXPS=On \
	-DLIBXML2_WITH_RUN_DEBUG=Off \
	-DLIBXML2_WITH_SAX1=On \
	-DLIBXML2_WITH_SCHEMAS=On \
	-DLIBXML2_WITH_SCHEMATRON=On \
	-DLIBXML2_WITH_TESTS=Off \
	-DLIBXML2_WITH_THREADS=On \
	-DLIBXML2_WITH_THREAD_ALLOC=Off \
	-DLIBXML2_WITH_TREE=On \
	-DLIBXML2_WITH_VALID=On \
	-DLIBXML2_WITH_WRITER=On \
	-DLIBXML2_WITH_XINCLUDE=On \
	-DLIBXML2_WITH_XPATH=On \
	-DLIBXML2_WITH_XPTR=On \
	-DLIBXML2_WITH_ZLIB=On \
	.. \
	)

clean:
	rm -rf $(SRC_NAME)/build
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=""

romfs:

