VERSION = 0.0.1
NAME = registry.nocsi.org
DEVICE = odroidc2

CREATE_DATE := $(shell date +%FT%T%Z)
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(shell dirname $(MKFILE_PATH))
DOCKER_BIN := $(shell which docker)


LINUX_CURRENT_VERSION = 3.14.y-android
LINUX_IMAGES = 3.14.y-android

UBOOT_CURRENT_VERSION = 2015.01
UBOOT_IMAGES = 2015.01

all: build test

.PHONY: check.env
check.env:
ifndef DOCKER_BIN
   $(error The docker command is not found. Verify that Docker is installed and accessible)
endif


### Misc images

.PHONY: linux
linux: 
	@for tf_ver in $(LINUX_IMAGES); \
	do \
	echo " " ; \
	echo " " ; \
	echo " " ; \
	echo "Building '$$tf_ver $(DEVICE)-$@' image..." ; \
	echo " " ; \
	$(DOCKER_BIN) build --rm -t $(NAME)/$(DEVICE)-$@:$$tf_ver $(CURRENT_DIR)/$@/$$tf_ver ; \
	cp -pR $(CURRENT_DIR)/templates/$@/README.md $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i 's/###-->ZZZ_IMAGE<--###/$(NAME)\/$(DEVICE)-$@/g' $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i 's/###-->ZZZ_BASE_IMAGE<--###/$(NAME)\/archlinux-aur:latest/g' $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i 's/###-->ZZZ_DATE<--###/$(CREATE_DATE)/g' $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i "s/###-->ZZZ_CURRENT_VERSION<--###/$(LINUX_CURRENT_VERSION)/g" $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i "s/###-->ZZZ_VERSION<--###/$$tf_ver/g" $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i "s/###-->ZZZ_LINUX_VERSION<--###/$$tf_ver/g" $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	done

.PHONY: linux_test
linux_test:

.PHONY: linux_rm
linux_rm:
	@for tf_ver in $(LINUX_IMAGES); \
	do \
	echo "Removing '$$tf_ver linux' image..." ; \
	echo " " ; \
	if $(DOCKER_BIN) images $(NAME)/odroidc2-linux | awk '{ print $$2 }' | grep -q -F $$tf_ver; then $(DOCKER_BIN) rmi -f $(NAME)/odroidc2-linux:$$tf_ver; fi ; \
	done


.PHONY: uboot
uboot: 
	@for tf_ver in $(UBOOT_IMAGES); \
	do \
	echo " " ; \
	echo " " ; \
	echo " " ; \
	echo "Building '$$tf_ver $(DEVICE)-$@' image..." ; \
	echo " " ; \
	$(DOCKER_BIN) build --rm -t $(NAME)/$(DEVICE)-$@:$$tf_ver $(CURRENT_DIR)/$@/$$tf_ver ; \
	cp -pR $(CURRENT_DIR)/templates/$@/README.md $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i 's/###-->ZZZ_IMAGE<--###/$(NAME)\/$(DEVICE)-$@/g' $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i 's/###-->ZZZ_BASE_IMAGE<--###/$(NAME)\/archlinux-aur:latest/g' $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i 's/###-->ZZZ_DATE<--###/$(CREATE_DATE)/g' $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i "s/###-->ZZZ_CURRENT_VERSION<--###/$(UBOOT_CURRENT_VERSION)/g" $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i "s/###-->ZZZ_VERSION<--###/$$tf_ver/g" $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	sed -i "s/###-->ZZZ_UBOOT_VERSION<--###/$$tf_ver/g" $(CURRENT_DIR)/$@/$$tf_ver/README.md ; \
	done

.PHONY: uboot_test
uboot_test:

.PHONY: uboot_rm
uboot_rm:
	@for tf_ver in $(UBOOT_IMAGES); \
	do \
	echo "Removing '$$tf_ver uboot' image..." ; \
	echo " " ; \
	if $(DOCKER_BIN) images $(NAME)/odroidc2-uboot | awk '{ print $$2 }' | grep -q -F $$tf_ver; then $(DOCKER_BIN) rmi -f $(NAME)/odroidc2-uboot:$$tf_ver; fi ; \
	done

.PHONY: misc
misc: uboot linux
	@echo " "
	@echo " "
	@echo "Miscellaneous images have been built."
	@echo " "

.PHONY: misc_test
misc_test: uboot_test linux_test
	@echo " "
	@echo " "
	@echo "Miscellaneous tests have completed."
	@echo " "

.PHONY: misc_rm
misc_rm: uboot_rm linux_rm


.PHONY: build
build: misc
	@echo " "
	@echo " "
	@echo "All done with builds."
	@echo " "

.PHONY: test
test: misc_test
	@echo " "
	@echo " "
	@echo "All done with tests."
	@echo " "


.PHONY: tag_latest
tag_latest:
	$(DOCKER_BIN) tag $(NAME)/odroidc2-uboot:$(UBOOT_CURRENT_VERSION) $(NAME)/odroidc2-uboot:latest
	$(DOCKER_BIN) tag $(NAME)/odroidc2-linux:$(LINUX_CURRENT_VERSION) $(NAME)/odroidc2-linux:latest

.PHONY: release
release: tag_latest
	@if ! $(DOCKER_BIN) images $(NAME)/odroidc2-uboot | awk '{ print $$2 }' | grep -q -F $(UBOOT_CURRENT_VERSION); then echo "$(NAME)/odroidc2-uboot uboot version $(UBOOT_CURRENT_VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! $(DOCKER_BIN) images $(NAME)/odroidc2-linux | awk '{ print $$2 }' | grep -q -F $(LINUX_CURRENT_VERSION); then echo "$(NAME)/odroidc2-linux linux version $(LINUX_CURRENT_VERSION) is not yet built. Please run 'make build'"; false; fi
	$(DOCKER_BIN) push $(NAME)/odroidc2-uboot
	$(DOCKER_BIN) push $(NAME)/odroidc2-linux

# Tag current version as a release on GitHub
.PHONY: tag_gh
tag_gh:
	git tag -d rel-$(VERSION); git push origin :refs/tags/rel-$(VERSION); git tag rel-$(VERSION) && git push origin rel-$(VERSION)


# Clean-up the cruft
.PHONY: clean
clean: clean_untagged misc_rm clean_untagged

.PHONY: clean_untagged
clean_untagged: clean_stopped
	docker images --no-trunc | grep none | awk '{print $$3}' | xargs -r docker rmi

.PHONY: clean_stopped
clean_stopped:
	for i in `docker ps --no-trunc -a -q`;do docker rm $$i;done
