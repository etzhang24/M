function M3_main_011_03_Zhan5173
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program plots all 45 graphs in groups of 5 based on tire and
% car type, and calls all other functions in order to calculate
% Acceleration start time, Time Constant, and initial/ final velocities and
% prints the results for all sets of test data
%
% Function Call
% function M2_main_011_03_Zhan5173
%
% Input Arguments
% none
%
% Output Arguments
% none
%
% Assignment Information
%   Assignment:     M2, Problem 1
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

T = readtable('Sp25_cruiseAuto_M3benchmark_data.csv');  % Read data
time = T{:, 1}; 
columnNames = T.Properties.VariableNames(2:end);  % Skip time
nTests = numel(columnNames);

acc_times = zeros(nTests,1);
time_consts = zeros(nTests,1);
init_speeds = zeros(nTests,1);
final_speeds = zeros(nTests,1);

%% ____________________
%% CALCULATIONS

for index = 1:nTests
    speed = T{:, index + 1};  %skip time
    clean_speed = M3_sub2_011_03_clar1062(speed);

    if any(isnan(clean_speed))
        acc_times(i) = NaN;
        time_consts(i) = NaN;
        init_speeds(i) = NaN;
        final_speeds(i) = NaN;
    else
        [acc_t, t_const] = M3_sub3_011_03_soaresj(clean_speed, time);
        [init_v, final_v] = M3_sub4_011_03_pteal(clean_speed, time, acc_t);
        acc_times(index) = acc_t;
        time_consts(index) = t_const;
        init_speeds(index) = init_v;
        final_speeds(index) = final_v;
    end
end

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

for i = 1:nTests
    fprintf('Test %d (%s):\n', i, columnNames{i});
    fprintf('  Acceleration start time: %.2f s\n', acc_times(i));
    fprintf('  Time constant: %.2f s\n', time_consts(i));
    fprintf('  Initial speed: %.2f m/s\n', init_speeds(i));
    fprintf('  Final speed: %.2f m/s\n\n', final_speeds(i));
end

nGroups = ceil(nTests / 5);
rows = ceil(sqrt(nGroups));
cols = ceil(nGroups / rows);

figure('Name', 'CruiseAuto Speed Tests');

for g = 1:nGroups
    subplot(rows, cols, g);
    hold on;

    start_idx = (g - 1) * 5 + 1;
    end_idx = min(start_idx + 4, nTests);
    
    for j = start_idx:end_idx
        speed = T{:, j + 1};  % +1 to skip time
        clean_speed = M3_sub2_011_03_clar1062(speed);
        plot(time, clean_speed);
        legendEntries{j - start_idx + 1} = columnNames{j};
    end

    title(sprintf('Group %d', g));
    xlabel('Time (s)');
    ylabel('Speed (m/s)');
    legend(legendEntries, 'Location', 'best');
    hold off;
end


%% ____________________
%% RESULTS

    
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



