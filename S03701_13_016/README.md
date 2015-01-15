###S03701_13_016
***
**Driver for the S03701_13_0l6 16x1 Char VFD**  

![S03701_13_016 VFD] (http://longhornengineer.com/images/projects/IEE_FLIP_DISPLAY/_DSC3337.JPG)

The IEE Flip VFD is a display that has a onboard voltage converter and microcontroller to handle driving the display. 
The interface is very simple. 
There is a 8bit parallel bus. 
You control the display by placing the data on the 8bit bus then pull the WR line to low briefly then back to high. 
All the commands are sent this way. 
Data can be read from the display but this is not implemented yet.
The display also supports a serial connection which would save 9 I/O pins. This is not implemented yet. 

[S03701_13_016 Datasheet] (http://longhornengineer.com/images/projects/IEE_FLIP_DISPLAY/S03701_13_016_REVB.pdf).