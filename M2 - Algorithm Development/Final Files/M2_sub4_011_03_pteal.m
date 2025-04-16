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

n = length(clean_speed);
acc_vector = zeros(n, 1);
for i = 1:n-1
    acc_vector(i) = (clean_speed(i+1) - clean_speed(i)) / (time(i+1) - time(i));
end
acc_vector(n) = acc_vector(n-1);

%% ____________________
%% CALCULATIONS


threshold = 4; % same as in sub3
window = 10;
start_i = 1;

while start_i <= (n - window)
    avg_acc = mean(acc_vector(start_i:start_i + window - 1));
    if avg_acc > threshold
        break;
    end
    start_i = start_i + 1;
end

end_i = n - window;
while end_i > start_i
    % idx in bounds
    window_end = min(end_i + window - 1, n);
    
    avg_acc = mean(abs(acc_vector(end_i:window_end)));
    
    if avg_acc > 0.15
        break;
    end
    
    end_i = end_i - 1;
end


%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS


%% ____________________
%% RESULTS


init_speed = mean(clean_speed(1:n));
final_speed = mean(clean_speed(end-n+1:end));
end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



