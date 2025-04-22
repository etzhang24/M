function [acc_t, t_const] = M3_sub3_011_03_soaresj(smooth_y, time)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program uses the smoothed speed data and the time data to find the time at
% which the wheel starts accelerating by scanning through the smoothed
% speed data, searching for a point where the slope of the speed v. time
% graph is greater than a set threshold. When this point is found, an
% indexing variable is used to find the corresponding time at this point.
% Once the acceleration start time is found the program then goes on to use
% the starting speed and ending speed which is found using a called function to
% then calculate the speed at the time of the time constant using the formula 
% given in M0. Once this speed is found, an indexing variable is again used
% to find the corresponding time where the speed data matches this
% calculated value. At the end of this process the acceleration start time
% and time constant values are then return as outputs of this function.
% 
%
% Function Call
% function [acc_t, t_const] = M2_sub1_011_03_soaresj(smooth_y, time)
%
% Input Arguments
% smooth_y --> Smoothed y values (m/s)
% time --> time values (s)
% Output Arguments
% acc_t --> Acceleration starting time (s)
% t_const --> Time constant
% Assignment Information
%   Assignment:     M2, Problem 1
%   Team member:    John Soares, soaresj@purdue.edu 
%   Team ID:        011-03
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Ethan Zhang, Zhan5173@purdue.edu
%                           Peter Teal, pteal@purdue.edu
%                           Justin Clark, clar1062@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% CODE
speed = smooth_y; % renames the smoothed speed vector speed
time_count = length(time); %finds the length of the time vector
acc_vector = zeros(time_count,1); %creates a vector of 0s to be reassigned

%zeros array.
%the below loop calculates the slope of each point by calculating the
%delta y / delta x of each data point on the  graph
for count = 1:(time_count - 1)
    acc_vector(count) = ((speed(count + 1) - speed(count)) / (time(count + 1) - time(count)));
end

%assigns the value of the acceleration of the second to last point to the
%last point (makes things work smoother because this entry cant be
%calculated using the loop)
acc_vector(time_count) = acc_vector(time_count - 1);


%% ACCELERATION STARTING TIME

acc_threshold = 4; %the threshold for the slope for the wheel to be considered accelerating
t_start_i = 1; %starting time index
window = 10; %the window of data points used to calculate the slope

%the below loop searches for a certain window where the average
%acceleration is higher than the threshold, at this point the loop ends and
%the time is recorded
while t_start_i <= (time_count - window)
    avg_acc = mean(acc_vector(t_start_i:t_start_i + window - 1));
    if avg_acc > acc_threshold
        break;
    end
    t_start_i = t_start_i + 1;
end

%assigns the accleration time to the found value's index in the time vector
acc_t = time(t_start_i);

%% TIME CONSTANT
%calls the function to find the initial and final velocities
[initial_v, final_v] = M3_sub4_011_03_pteal(smooth_y, time, acc_t);

%calculates the value of the speed when the time is the time constant
y_tau = initial_v + 0.632 * (final_v - initial_v);

%preassigns the loop control value for finding the index of the time vector
%corresponding to the time constant to initial time
t_tau_i = t_start_i;

%this loop searches through the speed index until a speed greater than
%y_tau is found at which point the loop ends and the corresponding index is
%recorded
while t_tau_i < time_count && speed(t_tau_i) < y_tau
    t_tau_i = t_tau_i + 1;
end

%assigns the value of the time constant to the time associated with the tau
%indexing variable, though the acceleration time is subtracted to account
%for the time spent traveling at a constant speed before the wheel
%accelerates
t_const = time(t_tau_i) - acc_t;

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



