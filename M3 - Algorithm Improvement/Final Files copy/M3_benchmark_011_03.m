function [bench_comp, bench_sudan, bench_suv] = M3_benchmark_011_03(data, model_comp, model_sudan, model_suv)
%M3_BENCHMARK_011_03 Summary of this function goes here
%   Detailed explanation goes here


%Compact Hatchback benchmark parameters
comp_ts = 6.21; %Acceleration start time (s)
comp_tau = 1.51; %Time constant (s)
comp_ispeed = -0.09; %Initial speed (m/s)
comp_fspeed = 25.08; %Final speed (m/s)

%Midsize Sudan benchmark parameters
sudan_ts = 9.39; %Acceleration start time (s)
sudan_tau = 1.96; %Time constant (s)
sudan_ispeed = -0.22; %Initial speed (m/s)
sudan_fspeed = 24.72; %Final speed (m/s)

%SUV benchmark parameters
suv_ts = 6.85; %Acceleration start time (s)
suv_tau = 2.80; %Time constant (s)
suv_ispeed = 0.19; %Initial speed (m/s)
suv_fspeed = 24.18; %Final speed (m/s)


%For loops

%Control variable for loop, and input
x_data = data(:,1);
count_x = length(x_data);

y_comp = [];
y_sudan =[];
y_suv = [];

%For loop to calculate y-values for each of the cars
for count = 1:count_x
    %Compact Hatchback y-values
    if(0 <= x_data(count) && x_data(count) < comp_ts)
        y_comp = [y_comp, comp_ispeed];
    elseif(x_data(count) >= comp_ts)
        y_c = comp_ispeed + (comp_fspeed - comp_ispeed) * (1 - exp(-(x_data(count) - comp_ts) / (comp_tau)));
        y_comp = [y_comp, y_c];
    end
    %Sudan y-values
    if(0 <= x_data(count) && x_data(count) < sudan_ts)
        y_sudan = [y_sudan, sudan_ispeed];
    elseif(x_data(count) >= sudan_ts)
        y_s = sudan_ispeed + (sudan_fspeed - sudan_ispeed) * (1 - exp(-(x_data(count) - sudan_ts) / (sudan_tau)));
        y_sudan = [y_sudan, y_s];
    end
    %SUV y-values
    if(0 <= x_data(count) && x_data(count) < suv_ts)
        y_suv = [y_suv, suv_ispeed];
    elseif(x_data(count) >= suv_ts)
        y_sv = suv_ispeed + (suv_fspeed - suv_ispeed) * (1 - exp(-(x_data(count) - suv_ts) / (suv_tau)));
        y_suv = [y_suv, y_sv];
    end
end

%Outputs being assigned to the values created by the for loop.

bench_comp = y_comp;
bench_sudan = y_sudan;
bench_suv = y_suv;

%Plotting value

figure(1)
plot(x_data, bench_comp, 'b*');
title('Compact Hatchback Graphical Comparison');
hold on
grid on
plot(x_data, model_comp, 'r-');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Benchmark data', 'Model data', 'Location','southeast');
hold off


figure(2)
plot(x_data, bench_sudan, 'b*');
title('Sudan Graphical Comparison');
hold on
grid on
plot(x_data, model_sudan, 'r-');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Benchmark data', 'Model data', 'Location','southeast');
hold off

figure(3)
plot(x_data, bench_suv, 'b*');
title('SUV Graphical Comparison');
hold on
grid on
plot(x_data, model_suv, 'r-');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Benchmark data', 'Model data', 'Location','southeast');
hold off

%SSE calculations

%Compact
sse_comp = sum(bench_comp - model_comp).^2 ./ length(bench_comp);

fprintf("SSE for Compact Hatchback: %.2f\n", sse_comp);

%Sudan
sse_sudan = sum(bench_sudan - model_sudan).^2 ./ length(bench_sudan);

fprintf("SSE for Sudan: %.2f\n", sse_sudan);

%SUV
sse_suv = sum(bench_suv - model_suv).^2 ./ length(bench_suv);

fprintf("SSE for SUV: %.2f\n", sse_suv);


end

