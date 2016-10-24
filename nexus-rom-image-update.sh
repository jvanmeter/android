# Android Nexus Device Image Update Procedure
# Resources used to generate this procedure
# Procedure         - http://www.androidbeat.com/2015/03/flash-android5-1-factory-image-nexus5-nexus7-nexus10/
# Factory Images    - https://developers.google.com/android/nexus/images
# General adb notes - http://lifehacker.com/the-most-useful-things-you-can-do-with-adb-and-fastboot-1590337225

# Verify phone/device is detected by system
sudo adb devices

# If adb does not show any devices restart the adb service
sudo adb kill-server;sudo adb start-server

adb devices
read -p "Press [Enter] to proceed with upgrading the listed Android device"
adb reboot bootloader
sleep 15
fastboot devices
read -p "Press [Enter] to proceed with the fastboot oem unlock for the listed Android device"
fastboot oem unlock

# Display device details and save details to a file
fastboot getvar all 2>&1 | tee fastboot_device_details.txt

# Flash the required image files or re-install existing versions
# All in one update (./flash-all.sh) can be performed, individual updates preferred
# Bootloader, recovery, and radio versions can be checked on the phone display or executing
fastboot flash bootloader <bootloader image>
fastboot reboot-bootloader
fastboot flash radio <radio image>
fastboot reboot-bootloader
fastboot flash recovery recovery.img
fastboot flash boot boot.img
fastboot flash cache cache.img
fastboot flash system system.img

# WARNING - Use this command if you are certain that user data can be deleted!
fastboot flash userdata userdata.img

# Wait for system update process to complete.  This process typically takes 15-20 minutes to complete.
# When the update completes log in, enable developer mode, and enable USB Debugging.
adb reboot bootloader
fastboot devices

# WARNING - Locking the boot loader erases user data on some devices - e.g. Nexus 6 w/ Android 6 (Marshmallow)
fastboot oem lock
fastboot reboot
