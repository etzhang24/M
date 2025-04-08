function M1B_examinedata_011_03_Zhan5173
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program plots all 45 graphs in groups of 5 based on tire and
% car type
%
% Function Call
% function M1B_examinedata_011_03_Zhan5173
%
% Input Arguments
% none
%
% Output Arguments
% none
%
% Assignment Information
%   Assignment:     M1B, Problem 1
%   Team member:    Name, Zhan5173@purdue.edu
%   Team ID:        011-03
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: John Soares, soaresj@purdue.edu
%                           Peter Teal, pteal@purdue.edu
%                           Justin Clark, clar1062@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION


data = readmatrix('Sp25_cruiseAuto_experimental_data.csv');
time = data(:, 1);     

%% ____________________
%% CALCULATIONS
% To plot this, we split the 45 tests into groups of 5 based on tire type.

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

figure;

% plot 1
subplot(3, 3, 1);
hold on;
plot(time, data(:, 2)); 
plot(time, data(:, 3)); 
plot(time, data(:, 4));  
plot(time, data(:, 5)); 
plot(time, data(:, 6));  
title('Wheel Speeds Compact Winter Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'Comp_{Win1}', 'Comp_{Win2}', 'Comp_{Win3}', 'Comp_{Win4}', 'Comp_{Win5}'}, 'Location', 'best');
hold off;

% plot 2
subplot(3, 3, 2);
hold on;
plot(time, data(:, 7)); 
plot(time, data(:, 8)); 
plot(time, data(:, 9));  
plot(time, data(:, 10)); 
plot(time, data(:, 11));
title('Wheel Speeds Compact All Season Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'Comp_{AS1}', 'Comp_{AS2}', 'Comp_{AS3}', 'Comp_{AS4}', 'Comp_{AS5}'}, 'Location', 'best');
hold off;

% plot 3
subplot(3, 3, 3);
hold on;
plot(time, data(:, 12)); 
plot(time, data(:, 13));  
plot(time, data(:, 14)); 
plot(time, data(:, 15));
plot(time, data(:, 16)); 
title('Wheel Speeds Compact Summer Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'Comp_{Sum1}', 'Comp_{Sum2}', 'Comp_{Sum3}', 'Comp_{Sum4}', 'Comp_{Sum5}'}, 'Location', 'best');
hold off;

% plot 4
subplot(3, 3, 4);
hold on;
plot(time, data(:, 17));
plot(time, data(:, 18));
plot(time, data(:, 19));
plot(time, data(:, 20));
plot(time, data(:, 21));
title('Wheel Speeds Sedan Winter Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'Sed_{Win1}', 'Sed_{Win2}', 'Sed_{Win3}', 'Sed_{Win4}', 'Sed_{Win5}'}, 'Location', 'best');
hold off;

% plot 5
subplot(3, 3, 5);
hold on;
plot(time, data(:, 22));  
plot(time, data(:, 23));  
plot(time, data(:, 24));
plot(time, data(:, 25));  
plot(time, data(:, 26)); 
title('Wheel Speeds Sedan All Season Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'Sed_{AS1}', 'Sed_{AS2}', 'Sed_{AS3}', 'Sed_{AS4}', 'Sed_{AS5}'}, 'Location', 'best');
hold off;

% plot 6
subplot(3, 3, 6);
hold on;
plot(time, data(:, 27)); 
plot(time, data(:, 28)); 
plot(time, data(:, 29)); 
plot(time, data(:, 30));  
plot(time, data(:, 31));  
title('Wheel Speeds Sedan Summer Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'Sed_{Sum1}', 'Sed_{Sum2}', 'Sed_{Sum3}', 'Sed_{Sum4}', 'Sed_{Sum5}'}, 'Location', 'best');
hold off;

% plot 7
subplot(3, 3, 7);
hold on;
plot(time, data(:, 32)); 
plot(time, data(:, 33));  
plot(time, data(:, 34));  
plot(time, data(:, 35));
plot(time, data(:, 36));  
title('Wheel Speeds SUV Winter Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'SUV_{Win1}', 'SUV_{Win2}', 'SUV_{Win3}', 'SUV_{Win4}', 'SUV_{Win5}'}, 'Location', 'best');
hold off;

% plot 8
subplot(3, 3, 8);
hold on;
plot(time, data(:, 37));
plot(time, data(:, 38));
plot(time, data(:, 39));
plot(time, data(:, 40));
plot(time, data(:, 41));
title('Wheel Torques SUV All Season Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'SUV_{AS1}', 'SUV_{AS2}', 'SUV_{AS3}', 'SUV_{AS4}', 'SUV_{AS5}'}, 'Location', 'best');
hold off;

% plot 9
subplot(3, 3, 9);
hold on;
plot(time, data(:, 42));
plot(time, data(:, 43));
plot(time, data(:, 44));
plot(time, data(:, 45));
plot(time, data(:, 46));
title('Wheel Torques Summer Tire');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend({'SUV_{Sum1}', 'SUV_{Sum2}', 'SUV_{Sum3}', 'SUV_{Sum4}', 'SUV_{Sum5}'}, 'Location', 'best');
hold off;

%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



