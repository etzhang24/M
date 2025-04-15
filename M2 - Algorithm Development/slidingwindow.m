data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");
compact_winter_test1 = data(:, 2);

% Remove NaN
compact_winter_test1 = compact_winter_test1(~isnan(compact_winter_test1));

% window size
w = 7;              % Total number of points in kernel
half_w = floor(w/2);  % Number of points in each half

% stddev for the Gaussian.
sigma = w/3;

% kernel centered on 0
x = -half_w:half_w;
gauss_kernel = exp(-(x.^2) / (2 * sigma^2));

% unitize the kernel vals
gauss_kernel = gauss_kernel / sum(gauss_kernel);

% array creation
nData = length(compact_winter_test1);
gauss_smooth = zeros(nData, 1);

% manual convolution
for idx = 1:nData
    % find indicies in window
    start_idx = max(1, idx - half_w);
    end_idx   = min(nData, idx + half_w);
    
    % Find corr. indicies in kernel
    kernel_start = (start_idx - idx) + half_w + 1;
    kernel_end = (end_idx   - idx) + half_w + 1;
    
    % get data
    data_segment = compact_winter_test1(start_idx:end_idx);
    weights = gauss_kernel(kernel_start:kernel_end)';
    
    % weighted avg
    gauss_smooth(idx) = sum(data_segment .* weights) / sum(weights);
end

% Plot
figure;

subplot(2,1,1);
plot(compact_winter_test1, 'b.-');
title('original data');
xlabel('Index');
ylabel('Speed');
grid on;

subplot(2,1,2);
plot(gauss_smooth, 'r.-');
title('smoothed data');
xlabel('Index');
ylabel('Speed');
grid on;