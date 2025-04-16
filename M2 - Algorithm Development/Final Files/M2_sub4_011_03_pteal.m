function [init_speed, final_speed] = M2_sub4_011_03_pteal(clean_speed, time, acc_t)
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

start_idx = find(time >= acc_t, 1, 'first');
init_speed = clean_speed(start_idx);

%% ____________________
%% CALCULATIONS

window = 10;
threshold = 0.1;

% Search backwards
for i = length(clean_speed) - window:-1:start_idx
    slope = mean(abs(diff(clean_speed(i:i+window))));
    if slope < threshold
        final_speed = mean(clean_speed(i:i+window));
        break;
    end
end

%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



