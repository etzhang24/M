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

% Loop through each vehicle
for kindex = 1:3
    speed = speeds(:,kindex);
    clean_speed = M4_sub2_011_03_clar1062(speed);
    [ts, tau] = M4_sub3_011_03_soaresj(clean_speed, time);
    [yL, yH] = M4_sub4_011_03_pteal(clean_speed, time, ts);

    % Save estimated values
    ts_vals(kindex) = ts;
    tau_vals(kindex) = tau;
    yL_vals(kindex) = yL;
    yH_vals(kindex) = yH;

    % Build model using estimated values
    model = zeros(n,1);
    for index = 1:n
        t = time(index);
        if t < ts
            model(index) = yL;
        else
            model(index) = yL + (yH - yL) * (1 - exp(-(t - ts)/tau));
        end
    end

    % Calculate modified SSE
    sse_vals(kindex) = sum((speed - model).^2) / n;


%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

    %plotting the benchmark data vs our model
    sgtitle('Benchmark Data vs. Algorithm Generated Model, Parameter Estimation Accuracy');
    subplot(3,1,kindex);
    plot(time, speed, 'b-', 'DisplayName','Benchmark Data'); hold on;
    plot(time, model, 'r-', 'DisplayName','First Order Model', 'LineWidth', 1.5);
    title(vehicleNames{kindex});
    xlabel('Time (s)');
    ylabel('Speed (m/s)');
    legend('Location','best');
    grid on;
end

%% ____________________
%% RESULTS

% printing results for all parameters in command window
for kkindex = 1:3
    fprintf("\n%s\n", vehicleNames{kkindex});
    fprintf("Estimated ts: %.2f, Reference: %.2f, Error: %.2f%%\n", ...
        ts_vals(kkindex), ref_ts(kkindex), 100*abs(ref_ts(kkindex)-...
        ts_vals(kkindex))/ref_ts(kkindex));
    fprintf("Estimated tau: %.2f, Reference: %.2f, Error: %.2f%%\n", ...
        tau_vals(kkindex), ref_tau(kkindex), 100*abs(ref_tau(kkindex)-...
        tau_vals(kkindex))/ref_tau(kkindex));
    fprintf("Estimated yL: %.2f, Reference: %.2f, Error: %.2f%%\n", ...
        yL_vals(kkindex), ref_yL(kkindex), 100*abs(ref_yL(kkindex)-...
        yL_vals(kkindex))/abs(ref_yL(kkindex)));
    fprintf("Estimated yH: %.2f, Reference: %.2f, Error: %.2f%%\n", ...
        yH_vals(kkindex), ref_yH(kkindex), 100*abs(ref_yH(kkindex)-...
        yH_vals(kkindex))/ref_yH(kkindex));
    fprintf("Modified SSE: %.4f\n", sse_vals(kkindex));
end

plot(time, clean_speed, 'k');

%part 4b, printing parameters of 45 testts
data = readtable('Sp25_cruiseAuto_experimental_data.csv');
labels = {
    'CH Summer', 'CH All-Season', 'CH Winter', ...
    'MS Summer', 'MS All-Season', 'MS Winter', ...
    'SUV Summer', 'SUV All-Season', 'SUV Winter'};

avgResults_M3 = zeros(9, 4); % ts, tau, yL, yH
avgResults_M4 = zeros(9, 4);

for i = 1:9
    idxStart = (i-1)*5 + 1;
    idxEnd = idxStart + 4;

    m3_group = zeros(5, 4);
    m4_group = zeros(5, 4);

    for j = 1:5
        colIdx = idxStart + j - 1;
        y = table2array(data(:, colIdx+1)); % +1 to account for time in column 1
        t = table2array(data(:, 1)); % time vector

        % Run M3 algorithm
        
        cleaned_speed = M3_sub2_011_03_clar1062(y);
        [ts, tau] = M4_sub3_011_03_soaresj(cleaned_speed, t);
        [yL, yH] = M4_sub4_011_03_pteal(cleaned_speed, t, ts);
        m3_group(j, :) = [ts, tau, yL, yH];

        % Run M4 algorithm 
        
        cleaned_speed_M4 = M4_sub2_011_03_clar1062(y);
        [tsM4, tauM4] = M4_sub3_011_03_soaresj(cleaned_speed_M4, t);
        [yLM4, yHM4] = M4_sub4_011_03_pteal(cleaned_speed_M4, t, tsM4);
        m4_group(j, :) = [tsM4, tauM4, yLM4, yHM4];
    end

    avgResults_M3(i, :) = mean(m3_group, 1, 'omitnan');
    avgResults_M4(i, :) = mean(m4_group, 1, 'omitnan');
end

% Print a table to the console
fprintf('\nTable 4b.1 – M3 and M4 Algorithm Comparison of Experimental Data Parameters\n\n');
fprintf('%-25s %-8s %-8s %-10s %-10s %-8s %-8s %-10s %-10s\n', ...
    'Vehicle-Tire', ...
    'M3_ts', 'M3_tau', 'M3_yL', 'M3_yH', ...
    'M4_ts', 'M4_tau', 'M4_yL', 'M4_yH');

for i = 1:9
    fprintf('%-25s %-8.2f %-8.2f %-10.2f %-10.2f %-8.2f %-8.2f %-10.2f %-10.2f\n', ...
        labels{i}, ...
        avgResults_M3(i,1), avgResults_M3(i,2), ...
        avgResults_M3(i,3), avgResults_M3(i,4), ...
        avgResults_M4(i,1), avgResults_M4(i,2), ...
        avgResults_M4(i,3), avgResults_M4(i,4));
end


end


    
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



