#!/usr/bin/env zsh

# Environment variables (excluding PATH)

# Java configuration
export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 | grep 'java.home =' | awk '{print $3}')

# Android SDK configuration
export ANDROID_HOME=$HOME/Library/Android/sdk

# Pager configuration
export PAGER=less