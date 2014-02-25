If it is necessary to manually install Cygwin, you should follow these steps:

1. delete the cygwin64 directory from the C: drive
2. run the cygwin installer `06_0_cygwin-setup-x86_64`
	* make sure the associated directory `06_0_cygwin_files` is located in the same directory as the installer
3. on the second screen of the cygwin installer, select 'Install from Local Directory'
4. leave the default install directory as-is and install for all users (default)
5. for the Local Package Directory, select the `06_0_cygwin_files` directory, so in my case this shows `E:\_B\06_0_cygwin_files`
6. when selected packages it helps to click the 'view' button (upper right) so it is in "Full" view (as opposed to "Category" view)
7. select the following packages:
	* curl
	* expect
	* less
	* nano
	* openssh
	* openssl
	* shutdown
	* unzip
	* vim
	* wget
	* zip
8. the next screen will list all the additional dependencies that will also be installed, click next
9. Cygwin should go through the actual install process
10. once Cygwin finishes, you should be able to re-run _B.bat to finish the other aspects of that configuration script.