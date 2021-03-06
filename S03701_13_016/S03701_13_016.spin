'flip_display_driver.spin
'Version: 1.0
'Parker Dillmann
'The Longhorn Engineer (c) 2013 
'www.longhornengineer.com

CON

  _CLKMODE      = XTAL1 + PLL16X                        
  _XINFREQ      = 5_000_000

  _1ms  = 1_000_000 /     1_000

  RESET = 1
  CS    = 2
  RD    = 3
  A0    = 4
  WRI   = 5
  B0    = 13
  B7    = 6

PUB flip_display_init

  DIRA[RESET] := %1
  DIRA[CS] := %1
  DIRA[RD] := %1
  DIRA[WRI] := %1
  DIRA[A0] := %1
  DIRA[B0..B7] := %11111111

  OUTA[WRI] := %1
  OUTA[RD] := %1
  OUTA[CS] := %0

return

PUB flip_backspace

  OUTA[A0] := %0
  OUTA[B0..B7] := $08
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1

return

PUB flip_advance

  OUTA[A0] := %0    
  OUTA[B0..B7] := $09
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_linefeed

  OUTA[A0] := %0    
  OUTA[B0..B7] := $0A
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_cr

  OUTA[A0] := %0    
  OUTA[B0..B7] := $0D
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_clear

  OUTA[A0] := %0    
  OUTA[B0..B7] := $0A
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1

  OUTA[B0..B7] := $0D
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_reset

  OUTA[A0] := %1    
  OUTA[B0..B7] := $40 
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_display_char(char)

  OUTA[A0] := %0    
  OUTA[B0..B7] := char         
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_display_str(stringptr)

  repeat STRSIZE(stringptr)
    flip_display_char(BYTE[stringptr++])

return

PUB flip_cursor_on

  OUTA[A0] := %0    
  OUTA[B0..B7] := $0F         
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_cursor_off

  OUTA[A0] := %0    
  OUTA[B0..B7] := $0E         
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_scroll_mode_on

  OUTA[A0] := %0    
  OUTA[B0..B7] := $13        
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_scroll_mode_off

  OUTA[A0] := %0    
  OUTA[B0..B7] := $11        
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PUB flip_move_cursor(loc)

  OUTA[A0] := %1    
  OUTA[B0..B7] := ($3F & loc)      
  OUTA[WRI] := %0
  pause
  OUTA[WRI] := %1
  
return

PRI pause | clkcycles

  clkcycles := ((clkfreq / _1ms * 1) - 4296) #> 381     ' Calculate 1 ms time unit
  waitcnt((clkcycles/4) + cnt)

return