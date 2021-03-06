'WS2801.spin
'Version: 1.0
'Parker Dillmann
'The Longhorn Engineer (c) 2013 
'www.longhornengineer.com

'WS2801 PWM Driver

'This driver is designed to control 1 WS2801 chip
'Usually setup the WS2801 so that it drives 3 mosfets which can control any number of RGB LEDs
'The purpose of this driver is to minimize cog time on the propeller and not waste a cog doing PWM work

'Call Init in your main program to setup the driver.
'Pass the CLK pin as an arguement.
'The driver assumes that the data line will be the next pin. 
'
CON

  Pin_Low  = 0
  Pin_High = 1

VAR

  byte CLK                

PUB Init(CLK_T)

  CLK := CLK_T

  DIRA[CLK] ~~
  DIRA[CLK+1] ~~

  OUTA[CLK] := Pin_Low
  OUTA[CLK+1] := Pin_Low
  
return

PUB Color(RED,GREEN,BLUE)

  repeat 8
    OUTA[CLK] := Pin_Low
    OUTA[CLK+1] := RED
    OUTA[CLK] := Pin_High
    RED := RED >> 1

  repeat 8
    OUTA[CLK] := Pin_Low
    OUTA[CLK+1] := GREEN
    OUTA[CLK] := Pin_High
    GREEN := GREEN >> 1

  repeat 8
    OUTA[CLK] := Pin_Low
    OUTA[CLK+1] := BLUE
    OUTA[CLK] := Pin_High
    BLUE := BLUE >> 1

  OUTA[CLK] := Pin_Low

return