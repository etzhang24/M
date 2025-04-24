function [init_speed, final_speed] = M3_sub4_011_03_pteal(clean_speed, time, acc_t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program uses the acceleration start time to calculate the average of
% of the wheel's speed before this starting time, to then be outputted as
% the initial speed. And finds the average of the last 5 seconds of speed
% data to then be outputted as the final speed.
%
% Function Call
% function [init_speed, final_speed] = M3_sub4_011_03_pteal(clean_speed, time, acc_t)
%
% Input Arguments
% clean_speed - this is the cleaned speed data that is being analyzed
% time - this is the time data that is associated with the speed data
% acc_t - this is the time where the wheels start accelerating
%
% Output Arguments
% init_speed - this is the speed of the wheel when it starts acclerating
% final_speed - this is the speed of the wheel it it is done accelerating
%
% Assignment Information
%   Assignment:     M3, Problem 1
%   Team member:    Peter Teal, pteal@purdue.edu 
%   Team ID:        011-03
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Ethan Zhang, Zhan5173@purdue.edu
%                           John Soares, soaresj@purdue.edu
%                           Justin Clark, clar1062@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
%finds the first index in the time vector that is equal to the acceleration
%starting time
start_idx = find(time >= acc_t, 1, 'first');

%renames the length of the cleaned up speed vector for simplicity later
length_data = length(clean_speed);

%% ____________________
%% CALCULATIONS
%assigns the value of the initial speed to be the average of the speeds of
%the wheel from when the data collection starts to when it starts
%accelerating
init_speed = mean(clean_speed(100: start_idx - 5));

%calculates the final speed by finding the average of the last 500 speed
%data points which corresponds to the average speed of the wheel in the
%last 5 seconds 
final_speed = mean(clean_speed(length_data - 500: length_data));

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



