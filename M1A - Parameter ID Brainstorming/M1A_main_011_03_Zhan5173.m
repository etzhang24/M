function M1A_main_011_03_Zhan5173
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program is a skeleton function for the main program written by
% programmer Zhan5173
%
% Function Call
% function M1A_main_011_03_Zhan5173
%
% Input Arguments
% none
%
% Output Arguments
% none
%
% Assignment Information
%   Assignment:     M1A, Problem 1
%   Team member:    Ethan Zhang, Zhan5173@purdue.edu
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
%Reading all the data
data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");

%Compact car matrices
compact_winter = data(:, 2:6);
compact_allSeason = data(:, 7:11);
compact_summer = data(:, 12:16);

%Sedan car matrices
sedan_winter = data(:, 17:21);
sedan_allSeason = data(:, 22:26);
sedan_summer = data(:, 27:31);

%SUV car matrices
SUV_winter = data(:, 32:36);
SUV_allSeason = data(:, 37:41);
SUV_summer = data(:, 42:46);


%% ____________________
%% CALCULATIONS
%skeleton function
M1A_sub1_011_03_soaresj(compact_summer)
M1A_sub2_011_03_pteal(compact_summer)
M1A_sub3_011_03_clar1062(compact_summer)

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS


%% ____________________
%% RESULTS

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



