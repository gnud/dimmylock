.PHONY: prepare build clean

# Define paths
SRC_DIR=./src
BUILD_DIR=./build
RELEASE_DIR=./release
DEBIAN_DIR=./debian
SCRIPT_NAME=dimmylock

CONTROL_FILE=${DEBIAN_DIR}/control


PACKAGE_NAME=$(shell grep '^Package:' $(CONTROL_FILE) | cut -d ' ' -f 2)
PACKAGE_VERSION=$(shell grep '^Version:' $(CONTROL_FILE) | cut -d ' ' -f 2)
DIST_PACKAGE_NAME=${PACKAGE_NAME}_${PACKAGE_VERSION}.deb

prepare:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(RELEASE_DIR)
	mkdir -p $(BUILD_DIR)/DEBIAN
	cp -r $(DEBIAN_DIR)/* $(BUILD_DIR)/DEBIAN

build: prepare
	cp -r $(SRC_DIR)/* $(BUILD_DIR)

# Build the Debian package
package: build
	dpkg-deb --build $(BUILD_DIR) $(RELEASE_DIR)/${DIST_PACKAGE_NAME}

install:
	dpkg -i $(RELEASE_DIR)/${DIST_PACKAGE_NAME}
# Clean up the build directory
clean:
	rm -rf $(BUILD_DIR)
	rm -f ${RELEASE_DIR}/*.deb
