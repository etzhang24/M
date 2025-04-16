data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");
compact_winter_test1 = data(:, 2);
compact_winter_test1 = compact_winter_test1(~isnan(compact_winter_test1));

num_passes = 500;

w = 7;
half_w = floor(w / 2);
sigma = w / 3;
x = -half_w:half_w;
gauss_kernel = exp(-(x.^2) / (2 * sigma^2));
gauss_kernel = gauss_kernel / sum(gauss_kernel);

smoothed = compact_winter_test1;

for pass = 1:num_passes
    n = length(smoothed);
    updated = zeros(n, 1);
    
    for i = 1:n
        start_i = max(1, i - half_w);
        end_i = min(n, i + half_w);
        
        k_start = (start_i - i) + half_w + 1;
        k_end = (end_i - i) + half_w + 1;
        
        seg = smoothed(start_i:end_i);
        wts = gauss_kernel(k_start:k_end)';
        
        updated(i) = sum(seg .* wts) / sum(wts);
    end
    
    smoothed = updated;
end

figure;
subplot(2,1,1);
plot(compact_winter_test1, 'b.-');
title('Original Data');
xlabel('Index');
ylabel('Speed');
grid on;

subplot(2,1,2);
plot(smoothed, 'r.-');
title(['Smoothed Data (' num2str(num_passes) ' passes)']);
xlabel('Index');
ylabel('Speed');
grid on;