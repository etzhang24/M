function M4_performance_011_03
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

% time vector
time = linspace(0, 50, 5001)';
n = length(time);

% Vehicle and Tire Labels
labels = { ...
    'Compact Hatchback - Summer', 'Compact Hatchback - All-Season', 'Compact Hatchback - Winter', ...
    'Midsize Sedan - Summer', 'Midsize Sedan - All-Season', 'Midsize Sedan - Winter', ...
    'Large SUV - Summer', 'Large SUV - All-Season', 'Large SUV - Winter'};

% Parameters from Part 4b (M4 outputs)
tau_vals = [2.78, 1.87, 1.57, 2.80, 2.01, 1.56, 3.77, 2.46, 3.07];
yL_vals  = [-0.03, 0.00, 0.00, -0.04, 0.00, 0.00, -0.03, -0.02, -0.02];
yH_vals  = [25.06, 24.92, 24.67, 24.94, 24.89, 24.95, 23.64, 24.03, 24.06];

% Performance bounds from M0
ts_bounds = [4.5, 6.0];
tau_bounds = [1.26, 3.89];
yL_bounds = [1.10, -0.90];
yH_bounds = [25.82, 23.36];

target_ts = 5.0;

% Generate performance bounds curves
left_model = zeros(n,1);
right_model = zeros(n,1);
for index = 1:n
    t = time(index);
    if t < target_ts
        left_model(index) = yL_bounds(1);
        right_model(index) = yL_bounds(2);
    else
        left_model(index) = yL_bounds(1) + (yH_bounds(1) - yL_bounds(1)) * ...
            (1 - exp(-(t - target_ts)/tau_bounds(1)));
        right_model(index) = yL_bounds(2) + (yH_bounds(2) - yL_bounds(2)) * ...
            (1 - exp(-(t - target_ts)/tau_bounds(2)));
    end
end

%% PLOTTING

figure;
sgtitle('Performance Boundary Evaluation for All Vehicle-Tire Combinations');

for i = 1:9
    tau = tau_vals(i);
    yL = yL_vals(i);
    yH = yH_vals(i);

    model = zeros(n,1);
    for j = 1:n
        t = time(j);
        if t < target_ts
            model(j) = yL;
        else
            model(j) = yL + (yH - yL) * (1 - exp(-(t - target_ts)/tau));
        end
    end

    subplot(3,3,i);
    plot(time, model, 'r-', 'LineWidth', 1.5, 'DisplayName', 'First Order Model'); hold on;
    plot(time, left_model, 'k:', 'LineWidth', 2, 'DisplayName', 'Left Bound');
    plot(time, right_model, 'k--', 'LineWidth', 2, 'DisplayName', 'Right Bound');
    title(labels{i});
    xlabel('Time (s)');
    ylabel('Speed (m/s)');
    legend('Location','southeast');
    grid on;
end
end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.
