#!/bin/bash

echo "DFU IPSW Builder for 64-bit devices (A7 and newer)"
echo "Script by pwnerblu"
echo "NOTE: I am not liable for any damages you cause to your device! Proceed at YOUR OWN RISK"
echo "If the IPSW building doesn't work for your specific device, please let me know."

echo "Please enter your password"
sudo -v
if [[ $? -ne 0 ]]; then
    echo "Sudo access is required to continue. Exiting."
    exit 1
fi

# Prompt to start
zenity --question --title="DFU IPSW Builder" --text="Would you like to create a DFU IPSW?"

if [[ $? -ne 0 ]]; then
    echo "Aborted."
    exit 1
fi

# Prompt user to select IPSW
ipsw_path=$(zenity --file-selection --title="Select an unmodified and signed IPSW to use (e.g. iOS 12.5.7, 15.8.4, 16.7.11, 17.7.10, 18.6.2)")

if [[ ! -f "$ipsw_path" ]]; then
    zenity --error --text="No valid IPSW selected. Exiting."
    exit 1
fi

# Setup working directory
workdir="build"
rm -rf "$workdir"
mkdir "$workdir"

echo "Extracting IPSW..."
unzip -q "$ipsw_path" -d "$workdir"

# Delete LLB 
echo "Deleting LLB..."
find "$workdir/Firmware/all_flash" -name 'LLB*.im4p' -exec rm {} \;

# Find iBoot file
iboot_file=$(find "$workdir/Firmware/all_flash" -name 'iBoot*.im4p' | head -n 1)

if [[ -z "$iboot_file" ]]; then
    zenity --error --text="iBoot not found. Exiting."
    exit 1
fi

# Copy iBoot and rename as LLB
llb_path="${iboot_file/iBoot/LLB}"
cp "$iboot_file" "$llb_path"

# Repack IPSW
echo "Repacking IPSW..."
output_ipsw="DFU_Custom.ipsw"
cd "$workdir"
zip -0 -r "../$output_ipsw" *
cd ..
rm -rf "$workdir"

echo "IF YOU RESTORE WITH THIS IPSW, EXPECT YOUR DEVICE TO BE STUCK IN DFU MODE AFTERWARDS!"
zenity --info --text="DFU IPSW created as $output_ipsw\n\nWARNING: Restoring this IPSW will leave your device in DFU mode!"

exit 0
