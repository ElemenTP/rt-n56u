SRC_NAME=libpcap-1.10.2
SRC_URL=http://www.tcpdump.org/release/$(SRC_NAME).tar.gz

all: download_test extract_test config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

download_test:
	( if [ ! -f $(SRC_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.gz $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar zxf $(SRC_NAME).tar.gz; \
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
	-DBDEBUG=Off \
	-DBUILD_SHARED_LIBS=On \
	-DBUILD_WITH_LIBNL=Off \
	-DDISABLE_BLUETOOTH=On \
	-DDISABLE_DAG=On \
	-DDISABLE_DBUS=On \
	-DDISABLE_DPDK=On \
	-DDISABLE_RDMA=On \
	-DDISABLE_SEPTEL=On \
	-DDISABLE_TC=On \
	-DENABLE_REMOTE=Off \
	-DINET6=$(if $(CONFIG_IPV6),On,Off) \
	-DNO_PROTOCHAIN=On \
	-DYYDEBUG=Off \
	.. \
	)

clean:
	rm -rf $(SRC_NAME)/build
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=""

romfs:
	cp -fP $(DESTDIR)/lib/libpcap.so* $(ROMFSDIR)/lib
