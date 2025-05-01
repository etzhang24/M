function M4_main_011_03_Zhan5173
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description % 
% This program is for Part 4b of Milestone 3. It evaluates the accuracy of 
% a first-order model created by our team’s algorithm using benchmark 
% acceleration data for three vehicle types: a compact hatchback, 
% a midsize sedan, and an SUV.
% 
%
% Function Call
% function M3_main_011_03_Zhan5173
%
% Input Arguments
% none
%
% Output Arguments
% none
%
% Assignment Information
%   Assignment:     M3, Problem 4b
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

% Load benchmark data
T = readmatrix('Sp25_cruiseAuto_M3benchmark_data.csv');
time = T(:,1);
speeds = T(:,2:4);
n = length(time);

% Reference algorithm parameters
ref_ts = [6.21, 9.39, 6.85];
ref_tau = [1.51, 1.96, 2.80];
ref_yL = [-0.09, -0.22, 0.19];
ref_yH = [25.08, 24.72, 24.18];
vehicleNames = {'Compact Hatchback', 'Midsize Sedan', 'SUV'};

% Preallocate vectors
ts_vals = zeros(1,3);
tau_vals = zeros(1,3);
yL_vals = zeros(1,3);
yH_vals = zeros(1,3);
sse_vals = zeros(1,3);

%% ____________________
%% CALCULATIONS

for kindex = 1:3
    speed = speeds(:,kindex);
    clean_speed = M4_sub2_011_03_clar1062(speed);
    [ts, tau] = M4_sub3_011_03_soaresj(clean_speed, time);
    [yL, yH] = M4_sub4_011_03_pteal(clean_speed, time, ts);

    ts_vals(kindex) = ts;
    tau_vals(kindex) = tau;
    yL_vals(kindex) = yL;
    yH_vals(kindex) = yH;

    model = zeros(n,1);
    for index = 1:n
        t = time(index);
        if t < ts
            model(index) = yL;
        else
            model(index) = yL + (yH - yL) * (1 - exp(-(t - ts)/tau));
        end
    end

    sse_vals(kindex) = sum((speed - model).^2) / n;
end

%% ____________________
%% PART 4B: PARAMETER EXTRACTION FOR 45 TESTS

data = readtable('Sp25_cruiseAuto_experimental_data.csv');
t = table2array(data(:, 1)); % ensure t is globally accessible
labels = {
    'CH Summer', 'CH All-Season', 'CH Winter', ...
    'MS Summer', 'MS All-Season', 'MS Winter', ...
    'SUV Summer', 'SUV All-Season', 'SUV Winter'};

avgResults_M3 = zeros(9, 4);
avgResults_M4 = zeros(9, 4);

for i = 1:9
    idxStart = (i-1)*5 + 1;

    m3_group = zeros(5, 4);
    m4_group = zeros(5, 4);

    for j = 1:5
        colIdx = idxStart + j - 1;
        y = table2array(data(:, colIdx+1));

        cleaned_speed = M3_sub2_011_03_clar1062(y);
        [ts, tau] = M4_sub3_011_03_soaresj(cleaned_speed, t);
        [yL, yH] = M4_sub4_011_03_pteal(cleaned_speed, t, ts);
        m3_group(j, :) = [ts, tau, yL, yH];

        cleaned_speed_M4 = M4_sub2_011_03_clar1062(y);
        [tsM4, tauM4] = M4_sub3_011_03_soaresj(cleaned_speed_M4, t);
        [yLM4, yHM4] = M4_sub4_011_03_pteal(cleaned_speed_M4, t, tsM4);
        m4_group(j, :) = [tsM4, tauM4, yLM4, yHM4];
    end

    avgResults_M3(i, :) = mean(m3_group, 1, 'omitnan');
    avgResults_M4(i, :) = mean(m4_group, 1, 'omitnan');
end

fprintf('\nTable 4b.1 – M3 and M4 Algorithm Comparison of Experimental Data Parameters\n\n');
fprintf('%-25s %-8s %-8s %-10s %-10s %-8s %-8s %-10s %-10s\n', ...
    'Vehicle-Tire', 'M3_ts', 'M3_tau', 'M3_yL', 'M3_yH', 'M4_ts', 'M4_tau', 'M4_yL', 'M4_yH');

for idx = 1:9
    fprintf('%-25s %-8.2f %-8.2f %-10.2f %-10.2f %-8.2f %-8.2f %-10.2f %-10.2f\n', ...
        labels{idx}, avgResults_M3(idx,1), avgResults_M3(idx,2), avgResults_M3(idx,3), avgResults_M3(idx,4), ...
        avgResults_M4(idx,1), avgResults_M4(idx,2), avgResults_M4(idx,3), avgResults_M4(idx,4));
end

%% ____________________
%% PLOTS – 45 TESTS WITH MODEL OVERLAY

figure;
sgtitle('Experimental Data vs. M4 Model – 45 Tests');

for group = 1:9
    subplot(3,3,group);
    hold on;

    tsM4 = avgResults_M4(group, 1);
    tauM4 = avgResults_M4(group, 2);
    yLM4 = avgResults_M4(group, 3);
    yHM4 = avgResults_M4(group, 4);

    % Generate 5 distinguishable colors for the 5 trials
    colors = lines(5);

    % Plot all 5 trials with unique colors
    for trial = 1:5
        colIdx = (group-1)*5 + trial + 1;
        y = table2array(data(:, colIdx));
        plot(t, y, ':', 'Color', colors(trial,:), 'DisplayName', sprintf('Trial %d', trial));
    end

    % Plot model line once
    model = yLM4 * ones(size(t));
    idx = t >= tsM4;
    model(idx) = yLM4 + (yHM4 - yLM4) * (1 - exp(-(t(idx) - tsM4)/tauM4));
    plot(t, model, 'r-', 'LineWidth', 1.5, 'DisplayName', 'M4 Model');

    title(labels{group});
    xlabel('Time (s)');
    ylabel('Speed (m/s)');
    legend('Location', 'northeastoutside');
    grid on;
end
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



