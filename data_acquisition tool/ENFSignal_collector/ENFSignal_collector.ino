long n = 0;
void setup()
{
  Serial.begin(115200);
  
  delay(1000);
}
void loop()
{
  n = millis();
  for(int i =0 ;i<1000;i++)
  {
  Serial.print(analogRead(A0));
  Serial.print(" ");
  //delayMicroseconds(200);
  }
  Serial.println();
  Serial.println(millis()-n);
  while(1);
}
