function [outputData] = sub1_011_03_clar1062(inputData)

data = inputData;
num_passes = 500; 

%Gaussian kernel
w = 7;              
half_w = floor(w/2);  
sigma = w / 3;
x = -half_w:half_w;
gauss_kernel = exp(-(x.^2) / (2 * sigma^2));
gauss_kernel = gauss_kernel / sum(gauss_kernel); 

%passes
smoothed = data;

for pass = 1:num_passes
    nData = length(smoothed);
    temp_smooth = zeros(nData, 1);
    
    for idx = 1:nData
        start_idx = max(1, idx - half_w);
        end_idx   = min(nData, idx + half_w);
        
        kernel_start = (start_idx - idx) + half_w + 1;
        kernel_end = (end_idx - idx) + half_w + 1;
        
        data_segment = smoothed(start_idx:end_idx);
        weights = gauss_kernel(kernel_start:kernel_end)';
        
        temp_smooth(idx) = sum(data_segment .* weights) / sum(weights);
    end
    
    smoothed = temp_smooth;
end

outputData = smoothed;