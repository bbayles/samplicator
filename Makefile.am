## Process this file with automake to produce Makefile.in

PACKAGE = samplicator
AUTOMAKE_OPTIONS = foreign

bin_PROGRAMS = samplicate
samplicate_SOURCES = samplicate.c samplicator.h rawsend.c rawsend.h read_config.c read_config.h inet.c inet.h
samplicate_LDADD = @LIBOBJS@

EXTRA_PROGRAMS = rawtest parsetest
rawtest_SOURCES = rawtest.c rawsend.c rawsend.h
parsetest_SOURCES = parsetest.c read_config.c rawsend.c read_config.h rawsend.h samplicator.h inet.c inet.h

ARCH := amd64
MAINTAINER = Bo Bayles <bo@bbayles.com>
DESCRIPTION = Samplicator UDP Relay
LICENSE = GNU General Public License v2.0
TARGET_ROOT = $(shell pwd)/packaging/root

build:
	./autogen.sh
	./configure
	make
	touch build

clean:
	git clean -dxf

copy:
	mkdir -p "${TARGET_ROOT}/usr/local/etc/"
	cp "samplicator.conf" "${TARGET_ROOT}/usr/local/etc/"
	mkdir -p "${TARGET_ROOT}/etc/systemd/system"
	cp "samplicator.service" "${TARGET_ROOT}/etc/systemd/system"
	mkdir -p "${TARGET_ROOT}/usr/local/bin"
	cp "samplicate" "${TARGET_ROOT}/usr/local/bin"
	touch copy

deb: copy
	fpm \
		-s dir \
		-t deb \
		-n "${PACKAGE_NAME}" \
		-v "${PACKAGE_VERSION}" \
		-p "packaging/output/${PACKAGE_NAME}-pkg.deb" \
		-a "${ARCH}" \
		--maintainer "${MAINTAINER}" \
		--category admin \
		--force \
		--description "${DESCRIPTION}" \
		--license "${LICENSE}" \
		--after-install packaging/scripts/postinst.sh \
		--after-remove packaging/scripts/postrm.sh \
		--deb-no-default-config-files \
		packaging/root/=/

rpm: copy
	fpm \
		-s dir \
		-t rpm \
		-n "${PACKAGE_NAME}" \
		-v "${PACKAGE_VERSION}" \
		-p "packaging/output/${PACKAGE_NAME}-pkg.rpm" \
		-a "${ARCH}" \
		--maintainer "${MAINTAINER}" \
		--category admin \
		--force \
		--description "${DESCRIPTION}" \
		--license "${LICENSE}" \
		--after-install packaging/scripts/postinst.sh \
		--after-remove packaging/scripts/postrm.sh \
		packaging/root/=/
