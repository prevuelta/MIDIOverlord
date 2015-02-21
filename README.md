# MIDIOverlord 

[Project Site - http://www.midioverlord.com ] (http://www.midioverlord.com)

This is a MIDI mapping & sequencing tool currently in development for OS X.

It is my first Obj C project so the code is not the greatest - but will hopefully be improved over time.

It uses (and is grateful for) the [MIKMIDI](https://github.com/mixedinkey-opensource/MIKMIDI) framework for alot of midi command processing & device detection / connection.

Also thanks to [Brad Frost](http://bradfrost.com/) for the inspiration to start an open design process.

## The System

### Racks

These contain different modules

### Modules

These are different midi controllers

#### Pad
For a standard midi note on / note off command - a receive note can be mapped to multiple send notes eg. D1 to a chord (C, E, G) 

#### Slider
For controlling a Midi control change - includes a velocity lock switch to ignore trigger's velocity.

#### Mapper
TBC - For mapping segments of your controller eg. Splitting keys, breath controllers, mod wheel etc.

#### X/Y Controller and / or 4 corner controller
TBC

#### High-resolution Slider
TBC