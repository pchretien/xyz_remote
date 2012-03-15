#include <Wire.h>

int x, y, z; 
int pin13 = LOW;

int slaveAddress;
byte headingData[2];
int i, headingValue;
int HMC6352Address = 0x42;

void setup()
{
  Wire.begin();
  slaveAddress = HMC6352Address >> 1;  
  
  pinMode(13, OUTPUT);
  Serial.begin(19200);
}
void loop()
{
  // Send a "A" command to the HMC6352
  Wire.beginTransmission(slaveAddress);
  Wire.send("A");  // The "Get Data" command
  Wire.endTransmission();
  delay(10);

  i = 0;
  Wire.requestFrom(slaveAddress, 2);        // Request the 2 byte heading (MSB comes first)
  while(Wire.available() && i < 2)
  { 
    headingData[i] = Wire.receive();
    i++;
  }
  
  headingValue = headingData[0]*256 + headingData[1];
  
  Serial.print("<");
  Serial.print(int (headingValue / 10));
  //Serial.print(".");
  //Serial.print(int (headingValue % 10));
  Serial.print(":");
  
  x = analogRead(0);
  y = analogRead(1);
  z = analogRead(2);

  Serial.print(x, DEC);
  Serial.print(":");
  Serial.print(y, DEC);
  Serial.print(":");
  Serial.print(z, DEC);
  Serial.print(">");
  
  delay(10);
} 
