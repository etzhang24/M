function M2_main_011_03_Zhan5173
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
nTests = 45;

acc_times = zeros(nTests,1);
time_consts = zeros(nTests,1);
init_speeds = zeros(nTests,1);
final_speeds = zeros(nTests,1);

group_labels = {'Comp_{Win}', 'Comp_{AS}', 'Comp_{Sum}', ...
                'Sed_{Win}', 'Sed_{AS}', 'Sed_{Sum}', ...
                'SUV_{Win}', 'SUV_{AS}', 'SUV_{Sum}'};


%% ____________________
%% CALCULATIONS

for i = 1:nTests
    speed = data(:, i + 1);
    clean_speed = M2_sub2_011_03_clar1062(speed);

    if any(isnan(clean_speed))
        acc_times(i) = NaN;
        time_consts(i) = NaN;
        init_speeds(i) = NaN;
        final_speeds(i) = NaN;
    end

    [acc_t, t_const] = M2_sub3_011_03_soaresj(clean_speed, time);
    [init_v, final_v] = M2_sub4_011_03_pteal(clean_speed, time);

    acc_times(i) = acc_t;
    time_consts(i) = t_const;
    init_speeds(i) = init_v;
    final_speeds(i) = final_v;
end


%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% printing times for all 45 tests
for i = 1:nTests
    group = group_labels{ceil(i/5)};
    fprintf('Test %d (%s):\n', i, group);
    fprintf('  Acceleration start time: %.2f s\n', acc_times(i));
    fprintf('  Time constant: %.2f s\n', time_consts(i));
    fprintf('  Initial speed: %.2f m/s\n', init_speeds(i));
    fprintf('  Final speed: %.2f m/s\n\n', final_speeds(i));
end

figure('Name','CruiseAuto Speed Tests','NumberTitle','off');

%plotting each test
for g = 1:9
    subplot(3,3,g);
    hold on;

    start_col = (g - 1) * 5 + 2;

    % Plot and store labels manually
    plot(time, M2_sub2_011_03_clar1062(data(:, start_col)));
    label1 = [group_labels{g}, '1'];

    plot(time, M2_sub2_011_03_clar1062(data(:, start_col + 1)));
    label2 = [group_labels{g}, '2'];

    plot(time, M2_sub2_011_03_clar1062(data(:, start_col + 2)));
    label3 = [group_labels{g}, '3'];

    plot(time, M2_sub2_011_03_clar1062(data(:, start_col + 3)));
    label4 = [group_labels{g}, '4'];

    plot(time, M2_sub2_011_03_clar1062(data(:, start_col + 4)));
    label5 = [group_labels{g}, '5'];

    title([group_labels{g}]);
    xlabel('Time (s)');
    ylabel('Speed (m/s)');
    legend(label1, label2, label3, label4, label5, 'Location', 'best');
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



