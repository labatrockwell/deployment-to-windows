#Cloning Computers:

##Setting up the clonezilla USB drive
###format flash drive (not just a partition) to FAT/FAT32
http://clonezilla.org/clonezilla-live.php

* I used Method A, downloaded tuxboot and the Clonezilla Stable (not Altenate) ISO
    - The Alternate release is for hardware which requires non-free drivers, It is built on Ubuntu and requires a username/password combo that I could not find. The differences are outlined in Clonezilla's FAQ
* double-check MD5 of ISO
* put downloaded files on a Windows computer (won't work in OSX)
* plug in USB drive and run tuxboot, follow instructions

##Booting from USB
* insert USB
* boot into BIOS
    - for many computers, holding F2 (or [fn]+[F2]) while the computer boots up will drop you into BIOS
    - some ultrabook Models seem to have an "assist" button that you press _when the computer is off_ to go to BIOS
* under 'security' disable 'secure boot'
    - you still want to use UEFI boot mode, not Legacy
* set USB as first boot pref
* save & exit

##Creating image
1. Boot from USB (see **Booting from USB**)

**** BOOTS FROM USB ****

1. Boot to RAM (so you can use the USB drive to boot another computer into Clonezilla while the first clones)
2. Once a blue screen ([curses](http://en.wikipedia.org/wiki/Curses_%28programming_library%29) screen) appears, you can remove the USB drive
7. (default) english
8. (default) don't touch keymap
9. (default) start clonezilla
10. (default) device-image
11. (default) local_dev
12. plug in passport harddrive
13. wait 5 seconds (some stuff should get printed below "press enter to continue")
14. press enter
15. select passport (ssd1 @ bottom of list for me, "In_My_Passport", "_WD_My_Passport")
16. (default) "/" [top-level directory]
17. press enter after directory info prints out
19. (default) beginner
  - I don't seem to be comfortable enough to change any options anyway
18. (default) savedisk
  - I tried savepart, but the identical computer I was cloning to had it's main partition 0.4 GB smaller, so it failed to apply the image
19. prefix default image name with "[make]-[model_id]-"
20. choose interal hdd
21. (default) skip checking/repairing source file system
22. (default) yes, check the saved image
23. press enter
24. 'y'

**** IMAGING HAPPENS ****

25. press enter
26. select 'poweroff'


##Using image
1. Boot from USB (see **Booting from USB**)

**** BOOTS FROM USB ****

1. Boot to RAM (so you can use the USB drive to boot another computer into Clonezilla while the first clones)
2. Once a blue screen ([curses](http://en.wikipedia.org/wiki/Curses_%28programming_library%29) screen) appears, you can remove the USB drive
7. (default) select English (default)
8. (default) don't touch keymap
9. (default) start clonezilla
10. (default) device-image
11. (default) local_dev
12. plug in passport harddrive
13. wait 5 seconds (some stuff should get printed below "press enter to continue")
14. press enter
15. select passport (ssd1 @ bottom of list for me, "In_My_Passport", "_WD_My_Passport")
16. (default) "/" [top-level directory]
17. press enter after directory info prints out
18. (default) Beginner
19. restoredisk (3rd option from top)
20. choose image dependent on computer make/model
21. choose internal hdd
22. press enter
23. 'y'
24. 'y' (second confirmation)

**** CLONING HAPPENS ****

25. poweroff after clone
