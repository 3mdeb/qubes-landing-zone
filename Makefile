NAME := landing-zone
SPECFILE := landing-zone.spec

WORKDIR := $(shell pwd)

ifndef NAME
$(error "You can not run this Makefile without having NAME defined")
endif
ifndef VERSION
VERSION := $(shell cat version)
endif

ifneq ($(VERSION),$(subst -rc,,$(VERSION)))
VERIFICATION := hash
else
VERIFICATION := signature
endif

all: help

SRC_BASEURL := https://boot.3mdeb.com/

ifeq ($(VERIFICATION),signature)
SRC_FILE := landing-zone-${VERSION}.tar.gz
SIGN_FILE := landing-zone-${VERSION}.tar.gz.sign
else
SRC_FILE := landing-zone-${VERSION}.tar.gz
HASH_FILE := $(SRC_FILE).sha512
endif

URL := $(SRC_BASEURL)/$(SRC_FILE)
URL_SIGN := $(SRC_BASEURL)/$(SIGN_FILE)

get-sources: $(SRC_FILE) $(SIGN_FILE)

verrel:
	@echo $(NAME)-$(VERSION)

$(SRC_FILE):
	@wget -q -N $(URL)

$(SIGN_FILE):
	@wget -q -N $(URL_SIGN)

import-keys:
	@if [ -n "$$GNUPGHOME" ]; then rm -f "$$GNUPGHOME/landing-zone-trustedkeys.gpg"; fi
	@gpg --no-auto-check-trustdb --no-default-keyring --keyring landing-zone-trustedkeys.gpg -q --import landing-zone-*-key.asc
verify-sources: import-keys
ifeq ($(VERIFICATION),signature)
	@gpgv --keyring landing-zone-trustedkeys.gpg $(SIGN_FILE) $(SRC_FILE) 2>/dev/null
else
	sha512sum --quiet -c $(HASH_FILE)
endif

.PHONY: clean-sources
clean-sources:
ifneq ($(SRC_FILE), None)
	-rm $(SRC_FILE) $(SIGN_FILE)
endif

help:
	@echo "Usage: make <target>"
	@echo
	@echo "get-sources      Download landing-zone sources from boot.3mdeb.com"
	@echo "verify-sources"
	@echo
	@echo "verrel"          Echo version release"
