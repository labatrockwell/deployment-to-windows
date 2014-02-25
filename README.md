###Overview
the [LAB at Rockwell Group](https://github.com/labatrockwell) did a project for Intel's booth at CES in 2014. The main project was developed in Unity and deployed to five (5) different sets of Windows 8 computers. The largest set of computers contained 32 laptops.

###Post-mortem thoughts
This deployment strategy worked well. There was apprehension at the beginning as to whether using Cygwin would cause permissions or other problems later in the project. Fortunately Cygwin interfaces with Windows in a way that did not present those obstacles.

Although a solution such as Puppet, Salt Stack, or Chef would have provided us with a lot more pre-packaged settings management scripts, Bash, Batch, and Powershell scripting is prevelant enough that it was usually straight-forward to find the scripts necessary for configuring the computers appropriately.

###Computer Management
[pssh](http://code.google.com/p/parallel-ssh/) and [cygwin](http://www.cygwin.com/) are used for managing the computers.

please refer to the [config scripts](/test config scripts/) for instructions on how we set up the computers.

[management_scripts](/management_scripts/) contains a collection of scripts that are used for deploying apps and managing the computers.

###Other Scripts
Lighting was controlled from the same computer that is running the Frame Server. The programs we developed for lighting integration are a windows batch script used for triggering the lighting effects, and an OF app used for interfacing with MIDI. 

* The batch script is located under the [management scripts](/management_scripts/trigger_lighting/) directory.