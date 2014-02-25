Management Scripts
================

This is a set of scripts etc used for deploying apps, running scripts and general machine management of all the laptops

##Overview
Standard tools such as ssh, scp, and rsync are mainly used for managing the laptops for the event. I suggest using VirtualEnv for sandboxing some of the python tools we will be using (setup instructions at the bottom).

##Setup
1. Install, activate, and configure VirtualEnv as directed below
2. copy your ssh key to all client computers
	1. set up ip_address_list.txt with one client computer defined per line. 
		* A client computer is defined as follows: `[username]@[ip_address|hostname]`
		* An example file is `ip_address_example.txt`
	2. if you don't have a public key, generate one using `ssh-keygen -t rsa`
		* if you don't have the file `~/.ssh/id_rsa.pub`, you need to do this step
		* accept the defaults (just hit enter a couple of times)
	2. run `./copy_ssh_key.sh` to copy your public key to each computer
		* The script will ask for a password, this is the password used to log into the clients.
		* The script assumes all clients are configured with the same password
	3. for deploying **server** apps, I set up ssh keys as follows (since I don't know the password to the PC towers):
		1. follow step 2 immediately above to check/generate your ssh key
		2. run `python -m SimpleHTTPServer` from the ~/.ssh/ directory on your computer
		3. on the server, visit the webpage hosted by Python (10.250.165.252:8000 for me)
		4. download id_rsa.pub
		5. on the server open the cygwin terminal (shortcut on desktop)
		6. run `mkdir -p ~/.ssh/` to create the .ssh directory
		6. run `cat /cygdrive/[USERNAME]/Downloads/id_rsa.pub >> ~/.ssh/authorized_keys` to add your key to the authorized list
			* [USERNAME] is the name of the user on the computer, for us it is usually `lab`, on the servers it is some alpha-numerical identifier
3. Once you have put your ssh key on the computers, migrate their entries to the appropriate `clients_[APP].txt` file and remove them from `ip_address_list.txt`
4. Build your Unity project into a directory named CES2014_Builds which is at the same level as the root of this repository.
	* My repository is at `~/Documents/labRepos/IntelCES_2014` so the deployment directory is at `~/Documents/labRepos/CES2014_Builds`
	* The script is designed to deploy subdirectories inside that `CES2014_Builds`
		- Our AR tablet app gets built so the .exe ends up at: `~/Documents/labRepos/CES2014_Builds/TabletClient/TabletClient.exe`
		- The script deploys just the TabletClient subdirectory, so the client machines end up with the .exe at: `C:\Users\lab\Downloads\build\TabletClient\TabletClient.exe`
	* A picture may help: [Directory Structure](directory structure.png)

##Usage
* If you want to deploy an individual app, you can run `./deploy.sh [APP_NAME]`
	- run `./deploy.sh` to get a list of expected app names.
* launch them with `./launch.sh [APP_NAME]`
* kill clients with `./kill.sh [APP_NAME]`
	- this will only work if you launch the app via cygwin (ie. using the launch script), if you launch them by hand (double-clicking the .exe) you need to stop them by hand
* shutdown computers with `./runpssh.sh < shutdown.txt`


##VirtualEnv
###Installing VirtualEnv
1. make sure you have pip installed, if not, follow the instructions [here](http://www.pip-installer.org/en/latest/installing.html)
	* with easy_install you can `sudo easy_install pip`
2. navigate to the project's root directory (`~/Documents/labRepos/IntelCES_2014` on my computer)
2. `sudo pip install virtualenv`
2. `virtualenv venv`
3. `source venv/bin/activate`
4. `pip install -r requirements.txt`

if you install anything new into the virtualenv, then you should:

1. `pip freeze > requirements.txt`
2. push the new `requirements.txt` to GitHub

###VirtualEnv Usage

1. `source venv/bin/activate`
2. ...Do whatever it is you want in the project using the VirtualEnv sandbox...
3. `deactivate` when you are done using the sandbox

[reference](http://docs.python-guide.org/en/latest/dev/virtualenvs/)

##rsync
1. Edit the first line in [activateAdminAcct.sh](activateAdminAcct.sh#L1) to change `PASSWORD` to your chosen admin password.
* Run `./activateAdminAcct.sh`
    * This *may* pop up a UAC dialog on all client computers which will require you to click 'yes'
    * This *will* ask you to enter the admin password which needs to match what you enter in [activateAdminAcct.sh](activateAdminAcct.sh#L1)
        * replace `PASSWORD` with your chosen password for the admin account.
    * From now on we will be able to elevate to admin privileges without requiring user interaction.
* Run `./setup_rsync/setup_rsync.sh`

##SSH config
* run `ssh_config/setup.sh`
    - If you are familiar with ssh config setup, you can edit your config by hand to incorporate the settings from `ssh_config/setup.md`
