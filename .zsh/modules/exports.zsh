#!/usr/bin/env zsh

# Environment variables (excluding PATH)

# Java configuration
if [[ "$(uname)" == "Darwin" ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
else
  export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 | grep 'java.home =' | awk '{print $3}')
fi

# Android SDK configuration
if [[ "$(uname)" == "Darwin" ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
elif [[ "$(uname)" == "Linux" ]]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
elif [[ "$(uname -o 2>/dev/null)" == "Msys" || "$(uname -o 2>/dev/null)" == "Cygwin" ]]; then
  export ANDROID_HOME="$LOCALAPPDATA/Android/Sdk"
else
  # Fallback: assumes Linux-like layout for unknown systems. Update as needed for your OS.
  export ANDROID_HOME="$HOME/Android/Sdk"
fi

# Pager configuration
export PAGER=less