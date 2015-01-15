###P8X32_Drivers
***
**Drivers for various hardware written for the Parallax P8X32 Propeller.**  

This repository holds Spin and ASM drivers for different hardware for the Parallax P8X32 Propeller.  

The following hardware have code for them. Each driver has a demo file that will hopefully show how the driver is used.

| Hardware | Description | Notes |
|---|---|---|
| AD7999 | ADC 4CH 8-Bit w/ I2C  | Possible use with AD7991/AD7995 |
| MAX11613 | ADC 4CH 12-Bit w/ I2C | Possible use with MAX1161X Family |
| S03701_13_016 | 16 x 1 Char VFD Display | 8-Bit Wide Parallel Bus ONLY | 
| WS2801 | Constant current RGB LED driver | Only supports 1 WS801 |

For an I2C object I use the [Basic_I2C_Driver_1.spin] (http://obex.parallax.com/sites/default/files/obj/id/155/Basic_I2C_Driver_1.spin).