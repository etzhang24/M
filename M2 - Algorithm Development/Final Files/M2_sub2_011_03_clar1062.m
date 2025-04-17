function [outputData] = M2_sub2_011_03_clar1062(inputData)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This is a gaussian window function
%
% Function Call
% function [outputData] = M2_sub2_011_03_clar1062(inputData)
%
% Input Arguments
%  inputData - this is the velocity data that gets passed into this
%  function and then smoothed
%
% Output Arguments
%  outputData - this is the data that is outputted once its been "cleaned"
%
% Assignment Information
%   Assignment:     M2, Subfunction 2
%   Team member:    Justin Clark, clar1062@purdue.edu
%   Team ID:        011-03
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Ethan Zhang, Zhan5173@purdue.edu
%                           John Soares, soaresj@purdue.edu
%                           Peter Teal, pteal@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = inputData;
num_passes = 50; 

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
        
        valid = ~isnan(data_segment);
        if any(valid)
            temp_smooth(idx) = sum(data_segment(valid) .* weights(valid)) / sum(weights(valid));
        else
            temp_smooth(idx) = NaN;
        end
    end
    
    smoothed = temp_smooth;
end

outputData = smoothed;