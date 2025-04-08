%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% this program plots the performance envelope for an ACC system, this
% simulates two distinct first order system responses.
%
% Assignment Information
%   Assignment:     AM0, Problem 2
%   Author:         Ethan Zhang, Zhan5173@purdue.edu
%   Team ID:        011-03
%   Academic Integrity:
%     [] I worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers I worked with: none
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% ____________________
%% INITIALIZATION

% time vec
t = linspace(0, 30, 1000);

% left params
ts_left = 4.50;
tau_left = 1.26;
yL_left = 1.10;
yH_left = 25.82;

% right params
ts_right = 6.00;
tau_right = 3.89;
yL_right = -0.90;
yH_right = 23.36;

% init vecs
y_left = zeros(size(t));
y_right = zeros(size(t));

%% ____________________
%% CALCULATIONS

% left boundary function
for i = 1:length(t)
    if t(i) < ts_left
        y_left(i) = yL_left;
    else
        y_left(i) = yL_left + (1 - exp(-(t(i) - ts_left)/tau_left))...
            * (yH_left - yL_left);
    end
end

% right boundary function
for j = 1:length(t)
    if t(j) < ts_right
        y_right(j) = yL_right;
    else
        y_right(j) = yL_right + (1 - exp(-(t(j) - ts_right)/tau_right))...
            * (yH_right - yL_right);
    end
end

%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS

%plotting the graph
figure;
hold on;
grid on;

plot(t, y_left, 'b-', 'LineWidth', 1.8); 
plot(t, y_right, 'k-', 'LineWidth', 1.8);

%labelling the graph
xlabel('Time (s)');
ylabel('Speed (m/s)');
title('ACC System Performance Boundaries');

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified. I have not provided
% access to my code to anyone in any way. The script I am 
% submitting is my own original work.





