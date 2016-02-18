# Android Nexus Sideload Image Update Procedure
# Sideloading is used to retain user data on updates using OTA images.
# The bootloader does not require to be unlocked in order to apply OTA updates.
# When sideloading newer versions of Android (e.g. 5.1 and later), ADB version 1.0.32+ is required.

# Step one - find the URL to the OTA update for phone.  Verify the version matches current Android version and phone vendor/carrier, etc.

# Check adb version
adb version

# If adb is version 1.0.31 or older, follow the update process below:
wget -O - https://skia.googlesource.com/skia/+archive/cd048d18e0b81338c1a04b9749a00444597df394/platform_tools/android/bin/linux.tar.gz | tar -zxvf - adb

# Backup current adb version
sudo mv /usr/bin/adb /usr/bin/adb.old
sudo mv adb /usr/bin/adb
sudo chmod +x /usr/bin/adb

# Get 32bit compatibility libraries if using a 64bit Linux environment and the adb executable is not recognized.
sudo apt-get install libc6:i386 libstdc++6:i386

# Verify new adb can be executed and check version
adb version
adb devices

# Boot phone into recovery
adb reboot recovery

# Alternatively the phone specific bootloader button combination can be used
# Nexus 5 - Volume Up + Volume Down + Power
# Nexus 6/7/9 - Volume Down for a few seconds, then press and hold Power at the same time

# At the "Broken Android" with exclamation point for Nexus 5 hold power + tap Volume Up
# Highlight "Apply update from ADB" with vol keys and press power to select
adb sideload <OTA file name>

# Be patient, the sideload update process takes 40+ minutes to complete.
# An additional 20+ minutes needed for app cache updates; dependent on number of apps installed.