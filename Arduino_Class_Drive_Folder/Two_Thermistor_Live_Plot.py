# Two_Thermistor_Live_Plot.py
# Tristan Whisenant
# September, 2018
# Serial Read and Live Plot from Arduino (should be running Final_Serial_2Therm)
# or anything with output: 8888,Time,Temp1,Temp2,8888
###########################################################################

# Import Packages
import serial
import io
import matplotlib.pyplot as plt
#import numpy as np
import time

### Close open serial ports
##if (serialArduino>0):
##    serialArduino.close()
##end

# Initialize Serial Communication
serialArduino = serial.Serial(
    port = '/dev/cu.usbmodem1411',
    baudrate = 115200,
    write_timeout = 0)

time.sleep(2)

serialArduino.flushInput()

# Stop_Time
stoptime = 15

# Save Desired 'y'or 'n'
Save = 'n'

# Turn Interactive Mode ON
plt.ion()
plt.grid(True)
plt.title('Serial value from Arduino')
plt.ylabel('Temperature (C)')
plt.xlabel('Time (S)')
plt.ylim(15,40)
plt.xlim(0,stoptime)

# Keep Plotting
kill = False
serialArduino.write(1)

while kill == False:
    
    while (serialArduino.inWaiting()==0):
        pass
    
    try:       
        valueRead = serialArduino.readline()
        serialArduino.flushInput()

        valueLine = valueRead.split(',')

        if len(valueLine) == 5:
                valueLine[1] = float(valueLine[1]) / 1000.0

                x  = float(valueLine[1])
                y1 = float(valueLine[2])
                y2 = float(valueLine[3])

                if x > stoptime:
                    kill = True

                plt.plot(x,float(valueLine[2]), 'bo-',x,float(valueLine[3]), 'rx-')
                
                plt.pause(0.01)

                plt.draw()
                       
        else:
            pass
        
    except KeyboardInterrupt:
        kill = True

# Close the serial feed
serialArduino.close()

# Save, if wanted
if (Save == 'y'):
    plt.savefig('DAQ_Python_Out.png', bbox_inches='tight')
else:
    pass
                           
# Close the graphing window
plt.close()

        






        
