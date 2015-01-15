'Demo_AD7999.spin
'Version: 1.0
'Parker Dillmann
'The Longhorn Engineer (c) 2015 
'www.longhornengineer.com

'AD7999 Demo

'Demos all the modes this driver is capable of and displays the results to a serial monitor. Attempts to bench mark the different modes
'by counting how many cycles each pass to read all 4 channels it takes.

'Single Channel Conversion is the slowest to read all 4 channels but for a single channel it is the fastest mode.
'Streaming Mode is the fastest to read all 4 channels but it takes up a dedicated cog and ties up the I2C bus.  

CON
_clkmode = xtal1 + pll16x                                                      
_xinfreq = 6_000_000

SCL = 28                           'Default SCL Pin.

        
VAR
  long time0
  long time1
  
OBJ
  pst   : "Parallax Serial Terminal"
  ADC   : "AD7999"

PUB Main | i

  pst.Start(115_200)
  pst.Clear
  pst.Str(String("AD7999 ADC I2C DEMO"))
  pst.NewLine       
                      
  pst.Str(String("Initialize AD7999..."))
  pst.NewLine

  if ADC.INIT(SCL)
    pst.Str(String("FAILED!"))
    pst.NewLine
    COGSTOP(COGID)
    
  pst.Str(String("Initialization Complete!"))
  pst.NewLine

  repeat

    pst.Str(STRING("Starting Single Channel Conversions..."))
    pst.NewLine    
    repeat 5
      time0 := cnt
      pst.Str(String("ADC0:"))
      pst.Dec(ADC.Get_Value(0))
      pst.NewLine
      pst.Str(String("ADC1:"))  
      pst.Dec(ADC.Get_Value(1))
      pst.NewLine
      pst.Str(String("ADC2:"))  
      pst.Dec(ADC.Get_Value(2))
      pst.NewLine
      pst.Str(String("ADC3:"))  
      pst.Dec(ADC.Get_Value(3))
      pst.NewLine
      time1 := cnt
      pst.Str(String("CNTs to get 4 channels: "))
      pst.Dec(time1 - time0)
      pst.Newline
      waitcnt(cnt+100000000)

    pst.Str(String("Starting ADC Streaming on COG: "))      
    pst.Dec(ADC.Start_Stream)
    pst.NewLine     
    repeat 5
      time0 := cnt
      pst.Str(String("ADC0:"))
      pst.Dec(ADC.Get_Value(0))
      pst.NewLine
      pst.Str(String("ADC1:"))  
      pst.Dec(ADC.Get_Value(1))
      pst.NewLine
      pst.Str(String("ADC2:"))  
      pst.Dec(ADC.Get_Value(2))
      pst.NewLine
      pst.Str(String("ADC3:"))  
      pst.Dec(ADC.Get_Value(3))
      pst.NewLine
      time1 := cnt
      pst.Str(String("CNTs to get 4 channels: "))
      pst.Dec(time1 - time0)
      pst.Newline

      waitcnt(cnt+100000000)

    pst.Str(String("Stopping ADC Streaming..."))
    pst.NewLine
    ADC.Stop_Stream
  