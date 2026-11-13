#!/bin/bash
# Patches old plugins in the pub cache so they compile with current Xcode.
set -euo pipefail
PUB_CACHE="${PUB_CACHE:-$HOME/.pub-cache}"

# flutter_mute 0.0.4: Swift no longer sees the TARGET_OS_SIMULATOR macro
for f in $(find "$PUB_CACHE" -path '*flutter_mute-*/ios/Classes/SwiftFlutterMutePlugin.swift'); do
  perl -0pi -e 's/return TARGET_OS_SIMULATOR != 0/#if targetEnvironment(simulator)\n        return true\n        #else\n        return false\n        #endif/' "$f"
  echo "patched $f"
done
