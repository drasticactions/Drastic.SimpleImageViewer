XBUILD=xcodebuild
ROOT=$(PWD)
PROJECT_ROOT=$(ROOT)/external/SimpleImageViewer
PROJECT=$(PROJECT_ROOT)/SimpleImageViewer.xcodeproj
BUILD_ROOT=$(ROOT)/build
TARGET_IOS="SimpleImageViewer"
TARGET_TVOS="SimpleImageViewer"
PROJECTNAME=SimpleImageViewer
OUTPUT=$(ROOT)/Build
FRAMEWORK_PATH=Products/Library/Frameworks/SimpleImageViewer.framework
FRAMEWORKS=$(ROOT)/Frameworks
IOS_SDK=iphoneos18.0

framework: iossimulator iosdevice maccatalyst xcframework

iossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_IOS) -destination "generic/platform=iOS Simulator" -archivePath $(BUILD_ROOT)/simulator.xcarchive -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

iosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_IOS) -destination "generic/platform=iOS" -archivePath $(BUILD_ROOT)/iOS.xcarchive -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

maccatalyst:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_IOS) -destination "generic/platform=macOS,variant=Mac Catalyst" -archivePath $(BUILD_ROOT)/catalyst.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcframework:
	rm -rf $(BUILD_ROOT)/$(PROJECTNAME).xcframework
	$(XBUILD) -create-xcframework -framework $(BUILD_ROOT)/simulator.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/iOS.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/catalyst.xcarchive/$(FRAMEWORK_PATH) -output $(BUILD_ROOT)/$(PROJECTNAME).xcframework
	rm -rf $(FRAMEWORKS)
	mkdir -p $(FRAMEWORKS)
	mv $(BUILD_ROOT)/$(PROJECTNAME).xcframework $(FRAMEWORKS)/$(PROJECTNAME).xcframework

dotnet:
	dotnet build $(ROOT)/Drastic.SimpleImageViewer

nuget:
	dotnet pack $(ROOT)/Drastic.SimpleImageViewer --configuration Release
