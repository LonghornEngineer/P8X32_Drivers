'S03701_13_016_Demo.spin
'Version: 1.0
'Parker Dillmann
'The Longhorn Engineer (c) 2013 
'www.longhornengineer.com

CON

  _CLKMODE      = XTAL1 + PLL16X                        
  _XINFREQ      = 5_000_000

  _1ms  = (_XINFREQ / 5) /     1_000

OBJ

  DISPLAY : "S03701_13_016"
  PST : "Parallax Serial Terminal"

VAR


PUB main     | temp_str

  PST.Start(9600)
  pause1ms(100)
  DISPLAY.flip_display_init
  pause1ms(100) 
  DISPLAY.flip_reset
  pause1ms(100)

  pst.Str(STRING("This is a serial interface demo for the IEE Flip 03701-13-016/S VFD"))
  pst.NewLine
  pst.Str(STRING("Type up to 16 characters."))
  pst.NewLine

  repeat
    PST.StrInMax(temp_str, 16)
    DISPLAY.flip_clear
    DISPLAY.flip_display_str(temp_str)
            

return

PRI pause1ms(period) | clkcycles

  clkcycles := ((clkfreq / _1ms * period) - 4296) #> 381     ' Calculate 1 ms time unit
  waitcnt(clkcycles + cnt)

return