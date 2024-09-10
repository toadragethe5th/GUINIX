#!/usr/bin/bash

if [ ! -d "./build" ] ; then
	mkdir -f ./build
fi

export ARCH=$0
