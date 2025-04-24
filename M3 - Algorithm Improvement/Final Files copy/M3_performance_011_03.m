function M3_performance_011_03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% this program takes in the models and compares them with the bounds from
% M0 to see how our model does
%
% Function Call
% M3_performance_011_03
%
% Input Arguments
% None
%
% Output Arguments
% None
%
% Assignment Information
%   Assignment:     M3 , Problem 5
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

% Load benchmark time and speed data
data = readmatrix('Sp25_cruiseAuto_M3benchmark_data.csv');
time = data(:,1);
speeds = data(:,2:4);
n = length(time);

vehicleNames = {'Compact Hatchback', 'Midsize Sedan', 'SUV'};

% outputs from Part 4b
ts_vals = [5.86, 9.17, 6.94];
tau_vals = [1.98, 2.29, 2.83];
yL_vals = [-0.13, -0.26, 0.23];
yH_vals = [24.97, 24.60, 24.11];

% Performance bounds from M0
ts_bounds = [4.5, 6.0];
tau_bounds = [1.26, 3.89];
yL_bounds = [1.10, -0.90];
yH_bounds = [25.82, 23.36];

target_ts = 5.0;

% Build performance bounds once on the normal time axis
left_model = zeros(n,1);
right_model = zeros(n,1);
for index = 1:n
    t = time(index);
    if t < target_ts
        left_model(index) = yL_bounds(1);
        right_model(index) = yL_bounds(2);
    else
        left_model(index) = yL_bounds(1) + (yH_bounds(1) - ...
            yL_bounds(1)) * (1 - exp(-(t - target_ts)/tau_bounds(1)));
        right_model(index) = yL_bounds(2) + (yH_bounds(2) - ...
            yL_bounds(2)) * (1 - exp(-(t - target_ts)/tau_bounds(2)));
    end
end

% Plot each vehicle
figure;
for kindex = 1:3
    yL = yL_vals(kindex);
    yH = yH_vals(kindex);
    tau = tau_vals(kindex);
    ts = ts_vals(kindex);

    % Shift the data
    time_shifted = time - (ts - 5.0);

    % Build your model using ts = 5
    your_model = zeros(n,1);
    for iindex = 1:n
        t = time(iindex);
        if t < target_ts
            your_model(iindex) = yL;
        else
            your_model(iindex) = yL + (yH - yL) * (1 - exp(-(t - target_ts)/tau));
        end
    end

    % Plot 
    sgtitle('Performance Boundary Evaluation, Model Validity at Standardized Start Time');
    subplot(3,1,kindex);
    plot(time_shifted, speeds(:,kindex), 'b-', 'DisplayName','Benchmark Data'); hold on;
    plot(time, your_model, 'r--', 'DisplayName','First Order Model');
    plot(time, left_model, 'k:', 'DisplayName','Left Bound', 'LineWidth', 2);
    plot(time, right_model, 'k--', 'DisplayName','Right Bound', 'LineWidth', 2);
    title(vehicleNames{kindex});
    xlabel('Time (s)');
    ylabel('Speed (m/s)');
    legend('Location','southeast');
    grid on;
end
end