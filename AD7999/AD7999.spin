'AD7999.spin
'Version: 1.0
'Parker Dillmann
'The Longhorn Engineer (c) 2013 
'www.longhornengineer.com

'AD7999 Driver

AD7999 = %01010010                 'Device address for the AD7999. See page 12 of datasheet. Notice the padded 0 bit on the LSB.
        
VAR
                        
  byte SCL_
  byte COG_ID
  
  word ADC_Store[4]
  long ADC_Stack [35]
  
OBJ

  I2C   : "Basic_I2C_Driver_1"

PUB INIT (SCL) | ch
  'Initialize the I2C bus. If the AD7999 fails to respond return true (-1).

  SCL_ := SCL

  ch := %1000_0000

  I2C.Initialize(SCL_)
  
  if I2C.WriteByte( SCL_, AD7999, i2c#NoAddr, ch)                   
    return true

  COG_ID := 0
  
  return false

PUB Get_Value (ch)
  'Get the value for the ADC channel (ch) selected. 

  if (COG_ID == 0)
    return (Get_Conv(ch))

  else
    return ADC_Store[ch]

PUB Start_Stream
  'Start the streaming mode of the AD7999. This starts a cog to keep pulling values from the ADC in a constant stream.
  'Much faster then the single conversion but ties up a COG and the I2C bus.

  I2C.WriteByte( SCL_, AD7999, i2c#NoAddr, %1111_0000)

  COG_ID := COGNEW(Stream, @ADC_Stack)

  return COG_ID

PUB Stop_Stream
  'Stop the streaming mode.

  COGSTOP(COG_ID)

  COG_ID := 0
   
  return

PRI Get_Conv (ch)
  'Write config for a single channel read then get it.       
    
  I2C.WriteByte( SCL_, AD7999, i2c#NoAddr, %0001_0000 << ch)                    'Write the Configuration byte. Shift the bit over depending on which channel we want. i2c#NoAddr is used because the AD799X devices do not have address. 
   
  return Get_Read

PRI Stream | CurCh
  'Streaming mode main loop for new cog.

  CurCh := 0
  
  repeat
    ADC_Store[CurCh] := Get_Read                                                'Put data into global varible that can be pulled from another cog.
    
    if (CurCh > 2)
      CurCh := 0
    else
      CurCh++

PRI Get_Read | ADC_Value, ADC_Value_Temp
  'Reads data from I2C bus. Also rearanges the word we receive from the ADC.

  ADC_Value := I2C.ReadWord( SCL_, AD7999, i2c#NoAddr)                          'Read the 16bit Conversion register.
   
  if ADC_Value == true
    return false
                                                                                
  ADC_Value_Temp := ADC_Value << 8                                              'We receive the 2 bits backwards so flipping the two bytes around.
                                                                                
  ADC_Value := ADC_Value_Temp | (ADC_Value >> 8)                            
   
  ADC_Value := (%0000_1111_1111_0000 & ADC_Value) >> 4                          'Mask the Conversion register and shift it over 4 times to make it into a binary number.

  return ADC_Value