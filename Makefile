
ARCHS = armv7 arm64

THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
THEOS_PACKAGE_DIR_NAME = debs
ADDITIONAL_OBJCFLAGS = -fobjc-arc


include theos/makefiles/common.mk

TWEAK_NAME = LockDial
LockDial_FILES = Tweak.xm REPhoneDialer.m
LockDial_FRAMEWORKS = UIKit
LockDial_PRIVATE_FRAMEWORKS = TelephonyUI CoreTelephony

include $(THEOS_MAKE_PATH)/tweak.mk
