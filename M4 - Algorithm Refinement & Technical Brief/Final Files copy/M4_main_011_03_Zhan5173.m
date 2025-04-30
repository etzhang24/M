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

end


    
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



