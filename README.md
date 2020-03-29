#  Cube Draft Simulation

A simple implementation of a simulated MTG Cube draft.

## Running

The project incudes two targets, a command line utility and a library inteded to be used in a Swift Playground.

To run the command line tool from Xcode, edit the scheme and add the path to a .csv file as a launch argument.

To run in the incldued playground, first select the "CubeDraftSimulatorPlaygroundSupport" library and build it. This includes an example CSV, but can be replaced with a path to another.


## CSV Structure

The CSV must include the headings:

```
Name,Type,Sum Playability,Aggro,Midrange,Control,W,U,B,R,G,WU,UB,BR,RG,GW,BW,BG,UG,UR,RW
```
