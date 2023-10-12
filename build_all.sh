#!/bin/sh

if [ x"${buildtypes}" = "x" ];
then
  buildtypes="debug release profile final";
fi;

# darwin is the default
if [ x"${platforms}" = "x" ];
then
  platforms="darwin";
fi;

for platform in $platforms;
do
  architectures="";

  eval platforms_architectures=\$${platform}_architectures;
  
  if [ x"${platforms_architectures}" != "x" ];
  then
    architectures=$platforms_architectures;
  fi;
  
  if [ x"${architectures}" = "x" ];
  then
    if [ x"${platform}" = "xdarwin" ];
    then
      architectures="i386 x86_64 ppc ppc64";
    fi;

    if [ x"${platform}" = "xios" ];
    then
      architectures="armv6 armv7 i386";
    fi;

    if [ x"${platform}" = "xlinux" ];
    then
      architectures="i386 x86_64";
    fi;

    if [ x"${platform}" = "xcygwin" ];
    then
      #architectures="i386 x86_64";
      architectures="i386";
    fi;

    if [ x"${platform}" = "xmingw" ];
    then
      architectures="i386 x86_64";
    fi;

    if [ x"${platform}" = "xvc" ];
    then
      architectures="i386 x86_64";
    fi;
  fi;

  if [ x"${architectures}" = "x" ];
  then
    echo unsupported platform \"$platform\"
    exit 1
  fi;

  # build everything
  for j in $architectures;
  do
    for i in $buildtypes;
    do
      # set platform, architecture, buildtype
      platform=${platform} architecture=$j buildtype=$i make $* || exit 1;
    done;
  done;
done;
