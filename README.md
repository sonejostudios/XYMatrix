# XYMatrix
XY Surround Matrix for one Source (Mono Input) with 4 Outputs (Left, Right, Surround Left, Surround Right) and Position Lock.

![screenshot](https://raw.githubusercontent.com/sonejostudios/XYMatrix/master/xy.png "XYMatrix controlled with Cadence XY-Controller")

It takes one input (mono) source and spread the sound between 4 ouputs acording to the xy position.

Use an XY controller for best workflow (e.g Cadence XY-Controller)
Midi Bindings: xpos[midi: ctrl 1] , ypos[midi: ctrl 2]

__Build/Install:__
* Use the Faust Online Compiler to compile it as Audio Plugin (LV2, VST, etc) or Standalone Jack Application: http://faust.grame.fr/compiler
* Or just download the LV2 binary here: https://github.com/sonejostudios/XYMatrix/releases/tag/1.0
* For Linux, copy the xymatrix.lv2 folder to your LV2 Folder (usually at /home/you/.lv2)

Cadence XY-Controller: http://kxstudio.linuxaudio.org/Applications:Cadence-XYController



