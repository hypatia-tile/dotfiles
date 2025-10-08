#!/usr/bin/env zsh

# Environment variables (excluding PATH)

# Java configuration
if [[ "$(uname)" == "Darwin" ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
else
  export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 | grep 'java.home =' | awk '{print $3}')
fi

# Android SDK configuration
export ANDROID_HOME=$HOME/Library/Android/sdk

# Pager configuration
export PAGER=less