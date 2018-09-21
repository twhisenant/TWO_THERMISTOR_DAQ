// TJW - Visualizing Temperature
// August 2018
// Visualize Temperature from Two Thermistors on Control Panel

import processing.serial.*;
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;

Serial myPort;  // Create object from Serial class
String data;
String[] tempstr;
String delimiter;
float[]  tempsfloat;
float scale_1;
float distance_old;

float Scale_1 = 5.0;

String[] legend_1= new String[2];
String[] legend_2= new String[2];

void setup()
  {
     size (500, 500);
     smooth();

    String portName = "/dev/cu.usbmodem1411" ; 
    myPort = new Serial(this, portName, 115200);
    delay(2000);
    myPort.write(65);
    myPort.bufferUntil('\n');
    // Open the serial port
  }
  
  void serialEvent (Serial myPort) 
  { 
    // starts reading data from the Serial Port
    
    if (myPort.available() > 0) 
  
    data = myPort.readStringUntil('\n');
    
    delimiter= ",";
   
    // Splits String to Array
    tempstr = data.split(delimiter);
    
    // converts to float
    tempsfloat = float(tempstr);
    tempsfloat[1] = tempsfloat[1] / 1000.0;
    
  }
  
  void draw() 
{
      background(200);
      
      fill(5);
      textSize(15);
      text("Temp Control Panel",140,20);
      
      strokeWeight(2);  // Default
      line(50, 20, 130, 20);
      line(50,20, 50, 400);
      line(130,20,130,400);
      
      line(300, 20, 380, 20);
      line(300,20, 300, 400);
      line(380,20, 380,400);
      
      // Therm Bulb
      int x = 5;
      int y = 400;
      float r = (x-y) / 2;
      
      fill(300,50,0);

      // Thermometer Bulbs
      ellipse(90, 450, 130, 130);
      ellipse(340, 450, 130, 130);
      
      if (abs(tempsfloat[2] - tempsfloat[3]) > 3)
      {
        fill(20,0,300);
      }
      else
      {
        fill(300,300,300);
      }
       
      ellipse(215, 400, 30, 30);
      
      
      
      textSize(20);
      fill(5);
      text("Therm 1", 50, 460);
      text("Therm 2", 300, 460);
      text("LED", 198,440);
      
      for (int i = 0; i < 21; i = i+1)
      {
        line(50, 20 + i*19, 70, 20 + i*19);
        line(300, 20 + i*19, 320, 20 + i*19);
      }

     
 
      
      
      
      

                float height_1 = 800 - (tempsfloat[2] * 20.0); 
                float height_2 = 800 - (tempsfloat[3] * 20.0); 
                
                
                
                  
      
                  // Draw Top Line and Measurement
                  strokeWeight(2);  // Default
                  
                      fill(5);
                  
                      line(50, height_1, 130, height_1);
                      text((nf(tempsfloat[2],2,1)) + " C",  140, height_1);
                 
                      line(300, height_2, 380, height_2);
                      text((nf(tempsfloat[3],2,1)) + " C",  390, height_2);
                      
                      fill(300,50,0);
                      
                      rect(50,  height_1, 80, 400 - height_1);
                      rect(300,  height_2, 80, 400 - height_2);
                      
                      
                  

    
}
  
  
  
  
  
  
  
  
  
  