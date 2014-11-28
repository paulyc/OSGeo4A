#!/bin/bash

# version of your package
VERSION_expat=2.0.1

# dependencies of this recipe
DEPS_expat=()

# url of the package
URL_expat=http://freefr.dl.sourceforge.net/project/expat/expat/$VERSION_expat/expat-${VERSION_expat}.tar.gz

# md5 of the package
MD5_expat=ee8b492592568805593f81f8cdf2a04c

# default build path
BUILD_expat=$BUILD_PATH/expat/$(get_directory $URL_expat)

# default recipe path
RECIPE_expat=$RECIPES_PATH/expat

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_expat() {
  cd $BUILD_expat

  # check marker
  if [ -f .patched ]; then
    return
  fi

  try cp $BUILD_PATH/tmp/config.sub $BUILD_expat/conftools
  try cp $BUILD_PATH/tmp/config.guess $BUILD_expat/conftools
  try patch -p1 < $RECIPE_expat/patches/expat.patch

  touch .patched
}

# function called to build the source code
function build_expat() {
  try mkdir -p $BUILD_PATH/expat/build
  try cd $BUILD_PATH/expat/build
	push_arm
  printenv
  try $BUILD_expat/configure --prefix=$DIST_PATH --host=arm-linux-androideabi
  try make install -j$CORES
	pop_arm
}

# function called after all the compile have been done
function postbuild_expat() {
	true
}