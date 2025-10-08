#!/usr/bin/env zsh

# Environment variables (excluding PATH)

# Java configuration
if [[ "$(uname)" == "Darwin" ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
else
  if command -v java >/dev/null 2>&1; then
    JAVA_HOME_CANDIDATE=$(java -XshowSettings:properties -version 2>&1 | awk -F' = ' '/^\s*java\.home =/ {print $2; exit}')
    if [[ -n "$JAVA_HOME_CANDIDATE" ]]; then
      export JAVA_HOME="$JAVA_HOME_CANDIDATE"
    else
      echo "Warning: Could not determine JAVA_HOME from 'java -XshowSettings:properties -version'" >&2
    fi
  else
    echo "Warning: 'java' command not found; JAVA_HOME not set." >&2
  fi
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