###AD7999
***
**Driver for the AD7999 8 bit ADC 4 Channel**  

The demo goes through modes this driver is capable of and displays the results to a serial monitor. It also attempts to bench mark the different modes
by counting how many cycles it takes to read all 4 channels.

Single Channel Conversion is the slowest to read all 4 channels but for a single channel it is the fastest mode and uses less resources.<br/>
Streaming Mode is the fastest to read all 4 channels but it takes up a dedicated cog and ties up the I2C bus.<br/>  

You will need the [Basic_I2C_Driver_1.spin] (http://obex.parallax.com/sites/default/files/obj/id/155/Basic_I2C_Driver_1.spin) object to run this driver.

[AD7999 Datasheet] (http://www.analog.com/static/imported-files/data_sheets/AD7991_7995_7999.pdf).