function M3_benchmark_011_03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This function generates ideal model curves and plots them against the 
% benchmark data
%
% Function Call
% M3_benchmark_011_03
%
% Input Arguments
% None
%
% Output Arguments
% None
%
% Assignment Information
%   Assignment:     M3 , Problem 4a
%   Team member:    John Soares, soaresj@purdue.edu
%   Team ID:        011-03
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Ethan Zhang, Zhan5173@purdue.edu
%                           Peter Teal, pteal@purdue.edu
%                           Justin Clark, clar1062@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

% Load benchmark data
data = readmatrix('Sp25_cruiseAuto_M3benchmark_data.csv');
time = data(:,1);
speed_compact = data(:,2);
speed_sedan = data(:,3);
speed_suv = data(:,4);
n = length(time);

% Benchmark parameters from M0
ts_compact = 6.21;
tau_compact = 1.51;
yL_compact = -0.09;
yH_compact = 25.08;

ts_sedan = 9.39;
tau_sedan = 1.96;
yL_sedan = -0.22;
yH_sedan = 24.72;

ts_suv = 6.85;
tau_suv = 2.80;
yL_suv = 0.19;
yH_suv = 24.18;

% Create ideal models initialize vectors
model_compact = zeros(n,1);
model_sedan = zeros(n,1);
model_suv = zeros(n,1);

%% ____________________
%% CALCULATIONS

%loop to plot ideal models using set parameters
for index = 1:n
    t = time(index);
    if t < ts_compact
        model_compact(index) = yL_compact;
    else
        model_compact(index) = yL_compact + (yH_compact - yL_compact)...
            * (1 - exp(-(t - ts_compact) / tau_compact));
    end
    if t < ts_sedan
        model_sedan(index) = yL_sedan;
    else
        model_sedan(index) = yL_sedan + (yH_sedan - yL_sedan) ...
            * (1 - exp(-(t - ts_sedan) / tau_sedan));
    end
    if t < ts_suv
        model_suv(index) = yL_suv;
    else
        model_suv(index) = yL_suv + (yH_suv - yL_suv) * ...
            (1 - exp(-(t - ts_suv) / tau_suv));
    end
end

% Calculate modified SSE
sse_compact = sum((speed_compact - model_compact).^2) / n;
sse_sedan = sum((speed_sedan - model_sedan).^2) / n;
sse_suv = sum((speed_suv - model_suv).^2) / n;

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% Print results
fprintf("Modified SSE (Compact Hatchback): %.4f\n", sse_compact);
fprintf("Modified SSE (Midsize Sedan): %.4f\n", sse_sedan);
fprintf("Modified SSE (SUV): %.4f\n", sse_suv);

% graph results
figure;
sgtitle('Benchmark Data vs. Ideal Model, Noise Evaluation Using Reference Parameters');
subplot(3,1,1);
plot(time, speed_compact, 'b-');
hold on;
plot(time, model_compact, 'r-', LineWidth = 1.5);
title('Compact Hatchback');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Benchmark Data', 'Ideal Model', 'Location', 'best');
grid on;

%subplot 2
subplot(3,1,2);
plot(time, speed_sedan, 'b-');
hold on;
plot(time, model_sedan, 'r-', LineWidth = 1.5);
title('Midsize Sedan');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Benchmark Data', 'Ideal Model', 'Location', 'best');
grid on;


% subplot 3
subplot(3,1,3);
plot(time, speed_suv, 'b-');
hold on;
plot(time, model_suv, 'r-', LineWidth = 1.5);
title('SUV');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Benchmark Data', 'Ideal Model', 'Location', 'best');
grid on;

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.
