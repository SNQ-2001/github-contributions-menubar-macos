#!/bin/sh
export PATH=/opt/homebrew/bin:$PATH

if which mint >/dev/null; then
    # SwiftGen
    xcrun --sdk macosx mint run swiftgen
    # SwiftLint
    xcrun --sdk macosx mint run swiftlint
    # LicensePlist
    xcrun --sdk macosx mint run mono0926/LicensePlist --output-path $PROJECT_NAME/Resource/Settings.bundle
else 
    echo 'warning: mint not installed.'
fi

