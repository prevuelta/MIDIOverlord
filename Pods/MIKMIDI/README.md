This README file is meant to give a broad overview of MIKMIDI. More complete documentation for MIKMIDI can be found [here](http://cocoadocs.org/docsets/MIKMIDI). Questions should be directed to [Andrew Madsen](mailto:andrew@mixedinkey.com).

MIKMIDI
-------

MIKMIDI is an easy-to-use Objective-C MIDI library created by Andrew Madsen and developed by the team at [Mixed In Key](http://www.mixedinkey.com/). It's a Cocoa-like set of Objective-C classes useful for programmers writing Objective-C or Swift OS X or iOS apps that use MIDI. It includes the ability to communicate with external MIDI devices, to read and write MIDI files, to record and play back MIDI, etc. MIKMIDI is used to provide MIDI functionality in the OS X version of our DJ app, [Flow](http://flowdjsoftware.com), as well as in our flagship app [Mixed In Key](http://www.mixedinkey.com/).

MIKMIDI can be used in projects targeting Mac OS X 10.7 and later, and iOS 6 and later.

MIKMIDI is released under an MIT license, meaning you're free to use it in both closed and open source projects. However, even in a closed source project, you must include a publicly-accessible copy of MIKMIDI's copyright notice, which you can find in the LICENSE file.

If you have any questions about, or suggestions for MIKMIDI, please [contact the maintainer](mailto:andrew@mixedinkey.com). Contributions are always welcome. Please see our [contribution guidelines](CONTRIBUTING.md) for more information. We'd also always love to hear about any cool projects you're using it in.

How To Use MIKMIDI
------------------

MIKMIDI is provided as a source library for both OS X and iOS. Additionally, for OS X, a project to build a Framework is included. To use MIKMIDI in your project, add its source to your project by dragging the contents of the 'Source' folder into your Xcode project.

MIKMIDI relies on CoreMIDI.framework, as well as on libxml2 (on iOS). Make sure Objective-C module support is turned on in your target/project's build settings (see [here](http://stackoverflow.com/a/18947634/344733)). 

On OS X, you can also use MIKMIDI.framework instead of including the MIKMIDI source in your project. To do so, open MIKMIDI.xcodeproj in the 'Framework' folder, build then copy the resultant MIKMIDI.framework into your project. In your project's settings, select your application's target, then click on the "Build Phases" tab. Expand the "Link Binary With Libraries" section, then click the "+" button in the lower left corner to add a new Framework. In the list that appears, find and select MIKMIDI.framework.

Important Note: MIKMIDI relies on Automatic Reference Counting (ARC). If you'd like to use its source in a non-ARC project, you'll need to open the "Compile Sources" build phase for the target(s) you're using it in, and add the -fobjc-arc flag to the "Compiler Flags" column for all MIKMIDI implementation (.m) files. MIKMIDI will generate a compiler error if ARC is not enabled.

### Install as Embedded Framework on iOS 8

- Add MIKMIDI as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the following command:

```bash
$ git submodule add https://github.com/mixedinkey-opensource/MIKMIDI.git
```

- Open the `MIKMIDI/Framework` folder, and drag `MIKMIDI.xcodeproj` into the file navigator of your app project.
- In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
- Ensure that the deployment target of MIKMIDI.framework matches that of the application target.
- In the tab bar at the top of that window, open the "Build Phases" panel.
- Expand the "Target Dependencies" group, and add `MIKMIDI.framework`.
- Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `MIKMIDI.framework`.

MIKMIDI Overview
----------------

MIKMIDI has an Objective-C interface -- as opposed to CoreMIDI's pure C API -- in order to make adding MIDI support to a Cocoa/Cocoa Touch app easier. At it’s core, MIKMIDI consists of relatively thin Objective-C wrappers around underlying CoreMIDI APIs. Much of MIKMIDI's design is informed and driven by CoreMIDI's design. For this reason, familiarity with the high level pieces of [CoreMIDI](https://developer.apple.com/library/iOS/documentation/CoreMidi/Reference/MIDIServices_Reference/Reference/reference.html) can be helpful in understanding and using MIKMIDI.

MIKMIDI is not limited to Objective-C interfaces for existing CoreMIDI functionality. MIKMIDI provides a number of higher level features. This includes an easy way to receive and route MIDI messages to appropriate parts of your application. Also included is functionality intended to facilitate implementing a MIDI learning UI so that users may create custom MIDI mapping files. These MIDI mapping files associate physical controls on a particular piece of MIDI hardware with corresponding receivers (e.g. on-screen buttons, knobs, musical instruments, etc.) in your application.

To understand MIKMIDI, it's helpful to break it down into its major subsystems:

- Device support -- includes support for device discovery, connection/disconnection, and sending/receiving MIDI messages.
- Commands -- includes a number of Objective-C classes that various represent MIDI message types as received from and sent to MIDI devices and endpoints.
- Mapping -- support for generating, saving, loading, and mapping files that associate physical MIDI controls with corresponding application features.
- Files -- support for reading and writing MIDI files.
- Synthesis -- support for turning MIDI into audio, e.g. playback of MIDI files and incoming MIDI keyboard input.
- Sequencing -- Recording and playback of MIDI.

Of course, these subsystems are used together to enable sophisticated features.

Device Support
--------------

MIKMIDI's device support architecture is based on the underlying CoreMIDI architecture. There are several major classes used to represent portions of a device. All of these classes are subclasses of `MIKMIDIObject`. These classes are listed below. In parentheses is the corresponding CoreMIDI class.

- MIKMIDIObject (MIDIObjectRef) -- Abstract base class for all the classes listed below. Includes properties common to all MIDI objects.
- MIKMIDIDevice (MIDIDeviceRef) -- Represents a single physical device, e.g. a DJ controller, MIDI keyboard, MIDI drum set, etc.
- MIKMIDIEntity (MIDIEntityRef) -- Groups related endpoints. Owned by MIKMIDIDevice, contains MIKMIDIEndpoints.
- MIKMIDIEndpoint (MIDIEndpointRef) -- Abstract base class representing a MIDI endpoint. Not used directly, only via its subclasses MIKMIDISourceEndpoint and MIKMIDIDestinationEndpoint.
- MIKMIDISourceEndpoint -- Represents a MIDI source. MIDI sources receive messages that your application can hear and process.
- MIKMIDIDestinationEndpoint -- Represents a MIDI destination. Your application passes MIDI messages to a destination endpoint in order to send them to a device.

`MIKMIDIDeviceManager` is a singleton class used for device discovery, and to send and receive MIDI messages to and from endpoints. To get a list of MIDI devices available on the system, call `-availableDevices` on the shared device manager:

    NSArray *availableMIDIDevices = [[MIKMIDIDeviceManager sharedDeviceManager] availableDevices];

`MIKMIDIDeviceManager` also includes the ability to retrieve 'virtual' endpoints, to enable communicating with other MIDI apps, or with devices (e.g. Native Instruments controllers) which present as virtual endpoints rather than physical devices.

`MIKMIDIDeviceManager`'s `availableDevices`, and `virtualSources` and `virtualDestinations` properties are Key Value Observing (KVO) compliant. This means that for example, `availableDevices` can be bound to an `NSPopupMenu` in an OS X app to provide an automatically updated list of connected MIDI devices. They can also be directly observed using key value observing to be notified when devices are connected or disconnected, etc. Additionally, `MIKMIDIDeviceManager` posts these notifications: `MIKMIDIDeviceWasAddedNotification`, `MIKMIDIDeviceWasRemovedNotification`, `MIKMIDIVirtualEndpointWasAddedNotification`, `MIKMIDIVirtualEndpointWasRemovedNotification`.

`MIKMIDIDeviceManager` is used to sign up to receive messages from MIDI endpoints as well as to send them. To receive messages from a `MIKMIDISourceEndpoint`, you must connect the endpoint and supply an event handler block to be called anytime messages are received. This is done using the `-connectInput:error:eventHandler:` method. When you no longer want to receive messages, you must call the `-disconnectInput:` method. To send MIDI messages to an `MIKMIDIDestinationEndpoint`, call `-[MIKMIDIDeviceManager sendCommands:toEndpoint:error:]` passing an `NSArray` of `MIKMIDICommand` instances. For example:

If you've used CoreMIDI before, you may be familiar with `MIDIClientRef` and `MIDIPortRef`. These are used internally by MIKMIDI, but the "public" API for MIKMIDI does not expose them -- or their Objective-C counterparts -- directly. Rather, `MIKMIDIDeviceManager` itself allows sending and receiving messages to/from `MIKMIDIEndpoint`s.

MIDI Messages
-------------

In MIKMIDI, MIDI messages are Objective-C objects. These objects are instances of concrete subclasses of `MIKMIDICommand`. Each MIDI message type (e.g. Control Change, Note On, System Exclusive, etc.) has a corresponding class (e.g. MIKMIDIControlChangeCommand). Each command class has properties specific to that message type. By default, MIKMIDICommands are immutable. Mutable variants of each command type are also available.

MIDI Mapping
------------

MIKMIDI includes features to help with adding MIDI mapping support to an application. MIDI mapping refers to the ability to map physical controls on a particular hardware controller to specific functions in the application. MIKMIDI's mapping support includes the ability to generate, save, load, and use mapping files that associate physical controls with an application's specific functionality. It also includes help with implementing a system that allows end users to easily generate their own mappings using a "MIDI learn" style interface.

The major components of MIKMIDI's MIDI mapping functionality are:

- MIKMIDIMapping - Model class containing information to map incoming messages to to the appropriate application functionality.
- MIKMIDIMappingManager - Singleton manager used to load, save, and retrieve both application-bundled, and user customized mapping files.
- MIKMIDIMappingGenerator - Class that can listen to incoming MIDI messages, and associate them with application functionality, creating a custom MIDI mapping file.

MIDI Files
----------

MIKMIDI includes features to make it easy to read and write MIDI files. This support is primarily provided by:

- MIKMIDISequence - This class is used to represent a MIDI sequence, and can be read from or written to a MIDI file.
- MIKMIDITrack - An MIKMIDISequence contains one or more MIKMIDITracks.
- MIKMIDIEvent - MIKMIDIEvent and its specific subclasses are used to represent MIDI events contained by MIKMIDITracks.

MIDI Synthesis
--------------

MIDI synthesis is the process by which MIDI events/messages are turned into audio that you can hear. This is accomplished using `MIKMIDIEndpointSynthesizer`. 

MIDI Sequencing
---------------

`MIKMIDISequencer` can be used to play and record to an `MIKMIDISequence`. It includes a number of high level features useful when implementing MIDI recording and playback.
