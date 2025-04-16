function [init_speed, final_speed] = M2_sub4_011_03_pteal(clean_speed, time)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This is a skeleton program for programmer pteal's task
%
% Function Call
% function [output] = M1B_sub2_011_03_pteal(input)
%
% Input Arguments
% input
%
% Output Arguments
% output
%
% Assignment Information
%   Assignment:     M1B, Problem 1
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

% input validation
if length(time) < 2 || length(clean_speed) ~= length(time)
    error('Time and speed vectors must be same length and contain at least 2 points.');
end

%% ____________________
%% CALCULATIONS


% find time step
dt = time(2) - time(1);
if dt <= 0
    error('Time vector must be increasing.');
end

% points
n = round(1 / dt);
n = min(n, floor(length(clean_speed) / 2));  % keep in bounds

% fail safe
if n < 1
    init_speed = NaN;
    final_speed = NaN;
    return;
end


%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS


%% ____________________
%% RESULTS

% Calculate average
init_speed = mean(clean_speed(1:n));
final_speed = mean(clean_speed(end-n+1:end));
end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



