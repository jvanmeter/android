# Android Nexus Sideload Image Update Procedure
# Sideloading is used to retain user data on updates using OTA images.
# The bootloader does not require to be unlocked in order to apply OTA updates.
# When sideloading newer versions of Android (e.g. 5.1 and later), ADB version 1.0.32+ is required.

# Step one - find the URL to the OTA update for phone.  Verify the version matches current Android version and phone vendor/carrier, etc.
# Google publishes OTA images to the following webpage:  https://developers.google.com/android/nexus/ota

# Check adb version 
adb version

# If adb is not found or older than 1.0.31 install the latest packages
# Fedora 24:
# sudo dnf -y install android-tools 

# Verify new adb can be executed and check version
adb devices

# Boot phone into recovery
# Alternatively the phone specific bootloader button combination can be used
# Nexus 5 - Volume Up + Volume Down + Power
# Nexus 6/7/9 - Volume Down for a few seconds, then press and hold Power at the same time
adb reboot recovery

# At the "Broken Android" with exclamation point for Nexus 5 hold power + tap Volume Up
# Highlight "Apply update from ADB" with vol keys and press power to select

# It is common to receive the message "error: insufficent permissions for device"
# Restarting the adb service will clear this error
adb kill-server;adb start-server
adb sideload <OTA file name>

# Be patient, the sideload update process can take 40+ minutes to complete for Android 5.x & 6.x.
# An additional 20+ minutes needed for app cache updates; dependent on number of apps installed.
