#!/bin/sh

DIR="toolchain-3.4.x"
DL_NAME="mipsel-linux-uclibc.tar.xz"
DL_URL="https://github.com/ElemenTP/padavan-toolchain/releases/download/v1.3/$DL_NAME"

if [ -d $DIR ]; then
	echo "$DIR exists!"
	exit
fi

if [ ! -e $DL_NAME ]; then
	curl -O -L $DL_URL
fi

tar -xf $DL_NAME $DIR
