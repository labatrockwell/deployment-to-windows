this constantly checks the contents of the ~/Desktop/drawings/ directory, and triggers the lighting scene when a new item is added.

launch (double-click) the .bat file in this directory (this directory's default location is ~/Downloads/scripts/trigger_lighting/)
open the Lighting Control software, and navigate to the "Live" tab. Keep this program in focus and in front for the duration of the event

** details
- the lighting is trigged by simulating pressing the 'z' key in the lighting control software
- the 'z' key is pressed whenever there is a change to the number of items in the observed directory
- after being triggered, the script pauses for a number of seconds to allow the lighting animation to fully complete before attempting to trigger again.
-- a trigger during an animation sequence will stop the current sequence, not trigger a new one
- the observed directory is checked every 100ms

references:
- so amazing: http://stackoverflow.com/questions/2556872/how-to-set-foreground-window-from-powershell-event-subscriber-action