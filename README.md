# MIDIOverlord 

Project Site - [http://www.midioverlord.com ] (http://www.midioverlord.com)

![alt text](https://raw.githubusercontent.com/prevuelta/MIDIOverlord/dev/MIDIOverlord/resources/default.png "MIDIOverlord")

This is a MIDI mapping & sequencing tool currently in development for OS X.

It is my first Obj C project so the code is not the greatest - but will hopefully be improved over time.

It uses (and is grateful for) the [MIKMIDI](https://github.com/mixedinkey-opensource/MIKMIDI) framework for alot of midi command processing & device detection / connection.

Also thanks to [Brad Frost](http://bradfrost.com/) for the inspiration to start an open design process.

## The System

### Rack types

#### Control Rack

Contains midi control modules - note, control change etc.

#### SysEx Rack TBC

Racks for controling specific instruments - these will hopefully come in the form of free downloadable patches

#### Sequencer Rack

TBC

#### Transport Rack

TBC


### Modules

#### Pad Control

For a standard midi note on / note off command - a receive note can be mapped to multiple send notes eg. D1 to a chord (C, E, G) 

#### Slider Control

For controlling a Midi control change - includes a velocity lock switch to ignore trigger's velocity.

#### Mapper Control

TBC - For mapping segments of your controller eg. Splitting keys, breath controllers, mod wheel etc.

#### X/Y Controller and / or 4 corner control

TBC

#### High-resolution Slider Control

TBC
