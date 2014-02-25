#Overview
We used disk imaging to get all the various systems to be configured correctly. We used Clonezilla to do the cloning. Here are the rough steps we used:

1. Create the cygwin install cache as outlined [here](bootstrapping/setup cygwin install.md)
* Follow the steps under [Bootstrapping](bootstrapping/) on one unit of each Model to set up the initial image for that Model.
* Clone the initial image using Clonezilla 
    - following the basic usage here: http://clonezilla.org/clonezilla-live.php, we used 'Beginner' settings and cloned the entire drive (as opposed to partition-only)
    - steps outlined in [Cloning Computers.md](cloning/Cloning Computers.md)
* Apply the clone to the other devices that are the same Model as the cloned computer
* After the cloned-to device boots up, run through the _Post-cloning_ step under [Cloning](cloning/)
