function [acc_t, t_const] = M2_sub3_011_03_soaresj(smooth_y, time)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This is a skeleton program for programmer soaresj's task
%
% Function Call
% function [acc_t, t_const] = M1B_sub1_011_03_soaresj(smooth_y, time)
%
% Input Arguments
% smooth_y --> Smoothed y values (m/s)
% time --> time values (s)
% Output Arguments
% acc_t --> Acceleration starting time (s)
% t_const --> Time constant
% Assignment Information
%   Assignment:     M1B, Problem 1
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
speed = smooth_y;
time_count = length(time);
acc_vector = zeros(time_count,1);

%zeros array.
for count = 1:(time_count - 1)
    acc_vector(count) = ((speed(count + 1) - speed(count)) / (time(count + 1) - time(count)));
end


acc_vector(time_count) = acc_vector(time_count - 1);


%% ACCELERATION STARTING TIME

acc_threshold = 4;

t_start_i = 1;
window = 10;

while t_start_i <= (time_count - window)
    avg_acc = mean(acc_vector(t_start_i:t_start_i + window - 1));
    if avg_acc > acc_threshold
        break;
    end
    t_start_i = t_start_i + 1;
end

acc_t = time(t_start_i);

%% TIME CONSTANT
[initial_v, final_v] = M2_sub4_011_03_pteal(smooth_y, time, acc_t);

y_tau = initial_v + 0.632 * (final_v - initial_v);

t_tau_i = 1;

while t_tau_i < time_count && speed(t_tau_i) < y_tau
    t_tau_i = t_tau_i + 1;
end

t_const = time(t_tau_i) - acc_t;

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



