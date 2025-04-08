function [output] = M1A_sub1_011_03_clar1062(input)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This is a skeleton program for programmer soaresj's task
%
% Function Call
% function [output] = M1A_sub1_011_03_clar1062(input)
%
% Input Arguments
% input
%
% Output Arguments
% output
%
% Assignment Information
%   Assignment:     M1A, Problem 1
%   Team member:    Justin Clark, clar1062@purdue.edu 
%   Team ID:        011-03
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Ethan Zhang, Zhan5173@purdue.edu
%                           Peter Teal, pteal@purdue.edu
%                           John Soares, soaresj@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");

col_length = length(data(:,1));
row_length = length(data(1,:));

new_data = [];

%% ____________________
%% CALCULATIONS
for (col = 2:col_length)
    for (row = 1:row_length)
        if(row == 1)
            if (isnan(data(row,col)) == 1)
                new_data(row,col) = [new_data,data(row,col)];
            else
                new_data = [new_data, mean(data(col,row), data(row+1, col+1))];
            end
            elseif row == row_length
                if isnan(data(row, col)) == 1
                    new_data = [new_data, data(row-1, col-1)];
                else
                    new_data = [new_data, mean(data(row-1,col-1), data(row,col))];
                end
            else
                new_data = [new_data, mean9data(row-1,col-1),data(row_col),data(row+1,col+1)];
         end
     end
end




fprintf("Data successfully passed to subfunction 1 programmed by Justin Clark\n");

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



