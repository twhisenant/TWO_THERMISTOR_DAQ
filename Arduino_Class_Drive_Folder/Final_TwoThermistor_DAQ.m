% Beefed_Thermistor_Movie_2.m
% 8/27/2018
% MATLAB 2016b
%
% Request Data from Arduino, Read serial feed from Ardy Arduino, live-plot,
% save figure and data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear Workspace
clear all
close all
clc

% Reset all External Instruments
instrreset

% Create a Serial Object
Ardy = serial('/dev/cu.usbmodem1411','BaudRate',115200); 
fopen(Ardy);
pause(2)
fwrite(Ardy,1);
flushinput(Ardy)

% Set Number of Loops
N_loops = 30;

% Set Wait Time
wait = 0.2;


Ardy.ReadAsyncMode = 'manual';

% Set Read Async
readasync(Ardy)

% Set Up the Plot
hold on
grid on
title('2-Thermistor Data','Fontsize',16);
xlabel('Time (s)','Fontsize',14);
ylabel('Temperature (C)','Fontsize',14);

% Set Axis
axis([0 N_loops*wait 15 40])

% Start Timer
tic

% Main Read Loop

for i=1:N_loops
    
    % Timestamp for pause time, not data
    loop_begin = toc;
    
    try

        % Assign Value
        Temp_Array(i,[1:5]) = fscanf(Ardy,'%f,%f,%f,%f,%f');


            % Convert millis to seconds
            Temp_Array(i,2) = Temp_Array(i,2)/1000

        % Live-Plot the Data
        plot(Temp_Array(i,2),Temp_Array(i,3),'oblue')
        plot(Temp_Array(i,2),Temp_Array(i,4),'+red')

        % Pause Between each loop so total_time = 1 second
        pause(wait)
        
    end
        
        
    
end

% print figure and save data
   print('2_Thermistor_Serial_DAQ','-dpng','-r300')
   save 2_Thermistor_Serial_DATA Temp_Array
   
   % DONE!