// Final_Serial_2Therm.ino
// 9/20/2018
// Created by Tristan Whisenant
// Analog Read on 2 Thermistors, Convert to Temp, Serial Print Temp
// Good for use with MATLAB/Python/Processing etc. anything with a
// serial read command.

// Include the Math Library (for log)
#include <math.h>

// Define Fixed Variables
double Divider_Resistors = 10000.0; //Resistor in V divider (ohms)

// Steinhart and Hart Coefficients
double SH_COEFF_1 = 0.00116741481796827;
double SH_COEFF_2 = 0.000227371846448138;
double SH_COEFF_3 = 0.000000119663032602201;

// Anticipate long unsigned variable for time reading
long Start ;

void setup() 
  {
    // Begin Serial Communication
    Serial.begin(115200);

    // Set Pin 5 to be a digital output
    pinMode(5, OUTPUT); 

     // Start the Timer
     Start = millis();
  
  }

void loop() 
  {
    // If serial connection established by other program!
        // Please comment out to just have Arduino print freely
    if (Serial.available() > 0)
      {

      // Take Time Reading
      long Time = millis() - Start;
    
      // Analog Read of A0 and A1
      int Reading = analogRead(0);
         double Temp1 = Read_to_Temp(Reading);
         
         Reading = analogRead(1);
         double Temp2 = Read_to_Temp(Reading);

      delay(50);
  
      // Print the Time and the Temperatures, bracketed by 8888
      Serial.print("8888"); Serial.print(","); 
      Serial.print(Time);   Serial.print(",");  
      Serial.print(Temp1);  Serial.print(","); 
      Serial.print(Temp2);  Serial.print(","); Serial.println("8888");

      } 
  }
  

// Define the conversion function from Reading(10bit) to Temperature(C)
double Read_to_Temp(int Read) 
  {
      // Convert Reading to a Voltage
      float Voltage = Read * (5.0/1023.0);

      // Find Resistance Based on Voltage Divider Eq
      float log_Resistance = log( (Voltage / (5 - Voltage)) * Divider_Resistors );

      // Use Steinhart_Hart Coeffs to Find Temp
      double Temp = 1.0/(SH_COEFF_1 + (SH_COEFF_2 * log_Resistance) + (SH_COEFF_3 * pow(log_Resistance,3)));
      
      // Convert K to C
      Temp = Temp - 273.15;

      return Temp;  
  }


  
