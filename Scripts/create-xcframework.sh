#!/bin/bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
PROJ_DIR="$SCRIPTS_DIR/.."

XCBUILD="xcrun xcodebuild"
#
$XCBUILD build -project "$PROJ_DIR/FormatterKit.xcodeproj" -scheme 'FormatterKit' -configuration Release -destination 'generic/platform=iOS' SYMROOT='build'
$XCBUILD build -project "$PROJ_DIR/FormatterKit.xcodeproj" -scheme 'FormatterKit' -configuration Release -destination 'generic/platform=iOS Simulator' SYMROOT='build'
$XCBUILD build -project "$PROJ_DIR/FormatterKit.xcodeproj" -scheme 'FormatterKit' -configuration Release -destination 'generic/platform=macOS' SYMROOT='build'

pushd build
find . -type d -name Frameworks -exec rm -rf {} \;
popd

$XCBUILD -create-xcframework \
	-framework "$PROJ_DIR/build/Release/FormatterKit.framework"\
	-debug-symbols "$PROJ_DIR/build/Release/FormatterKit.framework.dSYM"\
	-framework "$PROJ_DIR/build/Release-iphoneos/FormatterKit.framework"\
	-debug-symbols "$PROJ_DIR/build/Release-iphoneos/FormatterKit.framework.dSYM"\
	-framework "$PROJ_DIR/build/Release-iphonesimulator/FormatterKit.framework"\
	-debug-symbols "$PROJ_DIR/build/Release-iphonesimulator/FormatterKit.framework.dSYM" \
	-output "$PROJ_DIR/build/FormatterKit.xcframework"
