'WS2801_Demo.spin
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
    
  _CLKMODE      = XTAL1 + PLL16X                        
  _XINFREQ      = 5_000_000

  time = 100000000

  CLK_Pin = 16

OBJ

  RGB : "WS2801.spin"

PUB Main

RGB.Init(CLK_Pin)

repeat
  RGB.Color(%11111111,%11111111,%11111111)
  waitcnt(cnt + time) 
  RGB.Color(%11111111,%00000000,%00000000)
  waitcnt(cnt + time)
  RGB.Color(%00000000,%11111111,%00000000)
  waitcnt(cnt + time)
  RGB.Color(%00000000,%00000000,%11111111)
  waitcnt(cnt + time)
  RGB.Color(%00000000,%11111111,%11111111)
  waitcnt(cnt + time)
  RGB.Color(%11111111,%11111111,%00000000)
  waitcnt(cnt + time)
  RGB.Color(%11111111,%00000000,%11111111)
  waitcnt(cnt + time) 

return