# dfuipswbuilder-64bit
This tool can build a DFU IPSW for 64-bit Apple Devices. I have only tested it on A10 as of right now. It should work for A7 and newer, but I am not entirely sure. If you restore your device with a DFU IPSW, your device will be stuck in DFU mode afterwards.

To install this builder, clone it from this REPO, and then run chmod +x DFUipsw.sh, then type ./DFUipsw.sh (Enter sudo password when prompted to)
When it asks for an IPSW file, select the one for your device. It must be an IPSW for the latest iOS version at the moment.

This is mainly a proof of concept that you should be able to make a DFU IPSW and restore it without needing pwndfu mode on 64-bit iDevices.
If you have any questions, please let me know.

After the DFU IPSW is built, you can restore it via idevicerestore. You will lose your data when you do this.
IPSW name for the DFU ipsw will be: DFU_Custom.ipsw
I only recommend using this if the buttons that are required to go into DFU mode normally are broken on your device.

This project is licensed under the GNU General Public License v3.0.
