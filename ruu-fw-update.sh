# Procedure to perform Android device RUU firmware updates.  The new phone firmware
# and unlocked bootloader are required.  Please note that on some HTC devices
# S-OFF is also required.
# Please note that root/sudo is required for fastboot commands.  Errors encountered
# when running these commands without elevated credentials include: no 
# priviledge, fastboot hanging, and fastboot returning to the prompt without
# action or feedback.
adb reboot bootloader
sudo fastboot oem rebootRUU
sudo fastboot flash zip <RUU firmware package.zip>

# On HTC if this fails with "90 hboot re-update! please flush image again
# immediately" do not panic.  Wait for phone to reboot to HTC logo and
# reconnect to system.  Then reissue the same command again.
sudo fastboot flash zip <RUU firmware package.zip>

# Wait for command prompt to indicate the process is complete.  The phone may 
# show a progress bar that is ~95% complete.  This is normal and the 
# firmware update process is done.  Now the send the reboot command.
sudo fastboot reboot

# Optionally the phone can be rebooted to the bootloader to check the 
# firmware versions after RUU updates are applied
sudo fastboot reboot bootloader
sudo fastboot getvar all
