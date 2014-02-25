#Cloning
put all files in this directory on a flash drive and on each computer do the following:

##Post-cloning
1. make sure Windows gets activated on this unit, you must be connected to the internet briefly for this to happen.
    * you can check if Windows is activated by going to "control panel" -> "System" and reviewing the activation status at the bottom of that window
* run `_00_0_set_name.bat` (right click -> run as Admin)
    * follow the instructions provided in the command prompt
    * This script will set the connected network device to use a static IP as designated by the entered name
    * The naming format is `[Make]-[Model_id]-[Laptop_number]` for Leviathan this is `Lenovo-15-[Laptop_number]`


##Other Scripts
The process outlined above was to set the name on each computer after the cloning process had been completed. Earlier we thought we had to store Windows Keys ourselves before cloning and re-apply them after cloning. It turned out the computers were storing the Windows Keys somewhere so they could re-activate automatically after cloning.

When we thought we had to store Windows Keys we wanted to link the key and host name with a "Hardware ID". Since many of these computers did not have built-in Ethernet ports, a MAC Address was not always available (I think sometimes the WiFi Adapter doesn't show up unless it in enabled/connected). The link_name script creates a hardware ID from the Hard Drive ID along with a few others. In the end we used a few different USB drives to gather the data, so my filter for [`"SanDisk Cruzer USB Device"`](_01_1_link_name.ps1#L36) was too specific so the USB IDs were gathered as well, which would make it difficult to match Hardware IDs later.