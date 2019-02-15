# ToggleIPSettings
------
### Introduction
------
A Windows batch script that will read static IP settings from an .ini file and change your adapter's IP address to either a static IP or configure it to use DHCP.

This is useful for troubleshooting networking problems or when you need to connect to external hardware via a static IP frequently but only have one NIC on your computer.  

This batch script utilizes the netsh command in the Windows Command Line interface which requires administrator privileges. You **must** run this batch script **as administrator** in order for it to actually change your network adapter settings.

### Functionality
------
On launch, this batch script prompts the user for an input, either A or B to select which operation to perform on the network adapter (the name of the network adapter to be changed is stored within the StaticIPSettings.ini file). **Option A** will set a static IP address for the named adapter. **Option B** will configure the adapter to automatically obtain an IP Address via DHCP.

ToggleIP.bat uses a static method inside of the script to parse the .ini file for the relevant information to change the network settings. This function was taken from an answer on stackoverflow which can be found [here](https://stackoverflow.com/questions/2866117/windows-batch-script-to-read-an-ini-file "stackoverflow: Windows Batch Script to Read an .ini File")

### Limitations
------
As discussed on stackoverflow, the .ini parsing function does not work if spaces are included in the tokens or keys in the .ini file.

Also discussed above, this batch script requires admin privileges to run on your computer.

This batch script is directory-agnostic, meaning that it can be stored in any folder on your computer and still work correctly, however the ToggleIP.bat and StaticIPSettings.ini files **must** be located in the same directory.

### Future Improvements
------
This batch script would be more useful if it could detect what your adapter was currently set to (Static IP or DHCP) and then make the change automatically without requiring input from the user.
