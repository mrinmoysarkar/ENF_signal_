#include <SD.h>

const int chipSelect = 10;    
File myFile;

void setup()
{
  Serial.begin(115200);
  while (!Serial);
  pinMode(chipSelect, OUTPUT);
  if (!SD.begin(chipSelect)) {
    //Serial.println("initialization failed!");
    return;
  }
  //Serial.println("initialization done.");
  
  myFile = SD.open("test.txt", FILE_WRITE);  
   if (myFile) {
   //Serial.print("Writing to test.txt...");
   //myFile.println("testing 1, 2, 3.");
   for(int i = 0;i<100;i++)
   {
   double z = 1-cos(2*PI*50*i/1000);
   myFile.println(z,4);
   }
   myFile.close();
   //Serial.println("done.");
   } 
   else {
   //Serial.println("error opening test.txt");
   }
   /*
   myFile = SD.open("test.txt");
   if (myFile) {
   //Serial.println("test.txt:");
   while (myFile.available()) {
   Serial.write(myFile.read());
   }
   myFile.close();
   } 
   else {
   //Serial.println("error opening test.txt");
   }*/
}
void loop()
{/*
  for(int i = 0;i<100;i++)
 {
 double z = sin(2*PI*50*i/1000);
 Serial.println(z,4);
 delay(500);
 }*/
 String ss="-10.00";
 Serial.println(ss);
 delay(1000);
  if(true)//Serial.available()>0)
  {
   // Serial.read();
    myFile = SD.open("test.txt");
    if (myFile) {
      String s = "";
      //Serial.println("test.txt:");
      while (myFile.available()) {
        char c = myFile.read();
        if(c == '\n')
        {
          Serial.println(s);
          Serial.flush();
          s="";
        }
        else
        {
          s += c;
        }
      }
      myFile.close();
    } 
    else {
      //Serial.println("error opening test.txt");
    }
  }
  while(true);
}




