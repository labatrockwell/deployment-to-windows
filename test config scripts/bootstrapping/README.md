#Bootstrapping

We are assuming the user account is "lab" and the password is consistent across all units. If you are setting up a computer straight out of the box, 
it will be easier to simply set the account name as appropriate during the Windows guided setup. 
If you already have a configured computer, this process will create a new "lab" account and set it as 
the default log-on account.

`_A/01_0_userExists.ps1` and `_B/07_0_sshd_setup.sh` reference the `USER` and `PASSWORD` for the account on the computers. These values should be changed to match the values used for the installation. **Actual passwords should never be checked-in to a repo**.

##Create and configure user account
1. copy _A to the computer and eject the thumbdrive
2. run _A.bat (right-click -> run as Admin)
    1. _A.bat does the following:
    2. set powershell permission level
    3. create lab account if it does not exist
    4. set lab password
    5. set auto-boot to lab account
        * set to skip intro video (doesn't work)
    6. set auto-boot to desktop (SkipMetroSuite)
    7. REBOOT computer
3. while _A.bat is running, it will pop up a [SkipMetroSuite](http://winaero.com/comment.php?comment.news.103) tool
    1. first check the "Enable Skip Metro Suite" checkbox at the top of the window
    2. check all other check boxes to turn off 'hot corners' and skip the metro screen
    3. click "save settings" which should close the SkipMetroSuite screen
4. wait for the command prompt to print out a warning about removing the USB drive
5. hit any key to restart the computer

###auto-login
from now on, the computer should auto-login to the lab account every time it boots up. Sometimes this does not happen the first time after _A.bat is run, but will work for all subsequent times

if auto-login continues to not work after _B.bat is run, feel free to re-run _A.bat to re-set the auto-login. I have found this will fix the problem.

##Install necessary programs and scriptable configurations
1. Copy _B to the computer and eject the thumbdrive
* run _B.bat (right-click -> run as Admin)
    1. _B.bat will do the following:
    * set powershell permission level
    * run decrapifier
    * install python
    * install cygwin
        * if cygwin install fails, Quit script and follow the instructions in [manual cygwin install.md]()
    * setup sshd
        1. prepare for running setup script
        * run 'expect' script
    * replace sshd_config with custom version
    * configure sshd to start on boot
* PC Decrapifier should open soon after you start _B.bat, follow the prompts and then select any unnecessary software to be uninstalled such as:
    * security software
        * McAfee
        * Kapersky
        * Norton
    * auto-update programs
        * Adobe
        * Apple
        * OEM-specific
        * Intel
* After PC Decrapifier closes, you will need to input some key into the original command prompt to continue _B.bat
* During the cygwin installation, a window should show progress, if a error screen appears instead, close both the error and the command prompt window
    * Follow instructions in [manual cygwin install.md]()
* After cygwin installation, a second command prompt window should appear with a cygwin prompt, after about ten seconds the cygwin prompt will exit and return to the default Windows prompt, you can then close this second command prompt window, but leave the first command prompt window open (the one that opened when you started _B.bat)
* Once the entire process is done, the first command prompt window will warn you about removing your USB drive, then you can press any key to exit and restart the computer

##Manual steps
At a certain point it was more prudent to just write down all the settings to change manually rather than research how to change them via Bash/Powershell/VB script. We do these manual steps to set up a "master image" once, and then clone it out to other computers of the same model.

* make sure laptop is plugged into AC power and ethernet
* disable windows firewall
    - "control panel" -> "windows firewall" -> "turn windows firewall on or off" -> set both private and public settings to 'off'
* set screen to full brightness
    - "control panel" -> "power options" -> select or create a "high performance" mode
        * for "high performance" mode, click "change plan settings" and set brightness to full and all drop-downs to "never"
        * still in the "change plan settings" screen click "change advanced power settings" and set "display" -> "enable adaptive brightness" -> "off"
        * save changes
* disable password on wakeup
    - still in "power options" on the left, click "require a password on wakeup"
    - click "change settings that are currently unavailable" near the top of the window
    - select "don't require a password" in the second section of that window
* disable any vendor-specific eco utility
    - for toshiba: "control panel" -> "power options" -> "toshiba eco utility" -> "eco mode" -> set eco mode toggle at top to "off"
* turn on Airplane mode
* disable mouse charms bar swipe
    - if you can make the "charms bar" (the windows 8 column that appears when you type [Windows key]+[c]) appear by swiping in from the edge of the mouse touchpad, you will need to disable this setting
    - "control panel" -> "mouse" -> you will need to investigate to find the "gestures" or similar setting that needs to be disabled
* disable windows update
    - "control panel" -> "windows update" -> "change settings" -> set drop-down to Never check
* disable desktop icons
    - right click on desktop -> "view" -> uncheck "show desktop icons"
* remove applications from the taskbar
    - right click on each icon in the taskbar (the apps that stack toward the left side)
    - select "unpin this program from taskbar"
* remove all notifacions from the taskbar
    - "control panel" -> "taskbar"
        * under the 'taskbar' tab click "customize"
            - set all drop-downs to "hide icon and notifications"
            - click 'turn system icons on or off'
            - change all drop-downs on the new screen to "off"
            - click 'ok'
            - click 'ok'
        * under the 'toolbars' tab
            - make sure everything is unselected
        * click 'ok'
* disable notifications
    - "control panel" -> "action center"
        * If there are any security "recent messages", click a link to dismiss them
        * click "change action center settings" on the left
            - at the bottom of that window, click each link and disable settings
            - uncheck all available options
            - click 'ok'
        * click "change user account control settings" on the left
            - slide bar to "never notify"
            - click 'ok'
        * click "change windows smartscreen settings"
            - check "don't do anything"
            - click 'ok'
    
