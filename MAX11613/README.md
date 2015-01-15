###MAX11613
***
**Driver for the MAX11613 8 bit ADC 4 Channel**  

The demo goes through modes this driver is capable of and displays the results to a serial monitor. It also attempts to bench mark the different modes
by counting how many cycles it takes to read all 4 channels.

Single Channel Conversion is the slowest to read all 4 channels but for a single channel it is the fastest mode.<br/>
Streaming Mode is the fastest to read all 4 channels but it takes up a dedicated cog and ties up the I2C bus.<br/>  
Averaging Mode the MAX11613 samples a channel 8 times and returns the average of them. Performance is somewhere in between Single and Streaming mode.<br/>

You will need the [Basic_I2C_Driver_1.spin] (http://obex.parallax.com/sites/default/files/obj/id/155/Basic_I2C_Driver_1.spin) object to run this driver.

[MAX11613 Datasheet] (http://datasheets.maximintegrated.com/en/ds/MAX11612-MAX11617.pdf).