#!/bin/sh

if test "$1" = "CANCEL"
then
  exit 1
fi

# STEP 0.5 Add plugincompile dir to path temporarily
PATH="$PATH:$(dirname $0)"

if test "$1" != "ver_none"
then

  # STEP 1 Increment BuildVersion Number
  oldnum=$(grep 'BuildVersion' info.lua | cut -d '"' -f2)
  newnum="$oldnum"

  majnum=${oldnum%%.*}
  minnum=${oldnum#*.}
  minnum=${minnum%%.*}
  fixnum=${oldnum%.*}
  fixnum=${fixnum##*.}
  devnum=${oldnum##*.}

  if test "$1" = "ver_maj"
  then
    echo "updating buildversion major num"
    majnum=$((majnum + 1))
    newnum="$majnum.0.0.0"

  elif test "$1" = "ver_min"
  then
    echo "updating buildversion minor num"
    minnum=$((minnum + 1))
    newnum="$majnum.$minnum.0.0"

  elif test "$1" = "ver_fix"
  then
    echo "updating buildversion fix num"
    fixnum=$((fixnum + 1))
    newnum="$majnum.$minnum.$fixnum.0"

  elif test "$1" = "ver_dev"
  then
    echo "updating buildversion dev num"
    devnum=$((devnum + 1))
    newnum="$majnum.$minnum.$fixnum.$devnum"

  else
    echo "updating buildversion dev num"
    devnum=$((devnum + 1))
    newnum="$majnum.$minnum.$fixnum.$devnum"

  fi

  sed -i -E "s/$oldnum/$newnum/" info.lua
else
  echo "not updating buildversion"
fi

# STEP 2 Create new GUID if the plugin doesn't already have one
oldid=$(grep 'Id' info.lua | cut -d '"' -f2)

if test "$oldid" = "<guid>"
then
  echo "generating guid for plugin"
  newid=$(uuidgen)
  sed -i -E "s/$oldid/$newid/" info.lua
fi

PLUGCC.exe WeatherForecastPlugin plugin.lua


if [ $? -eq 0 ]; then
  echo "Plugin compiled successfully to ./output_directory/plugin_name.qplug"
else
  echo "Plugin compilation failed"
  exit 1
fi
