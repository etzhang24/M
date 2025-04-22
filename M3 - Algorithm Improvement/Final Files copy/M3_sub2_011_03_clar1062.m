function [outputData] = M3_sub2_011_03_clar1062(inputData)

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
n    = length(data);

w_dip   = 11;                    % window length for median test
half_d  = floor(w_dip/2);
dip_thresh = 3;                 % m/s below median to consider a glitch
num_passes_dip = 5;             % repeat

for p = 1:num_passes_dip
    for i = (half_d+1):(n-half_d)
        window = data(i-half_d : i+half_d);
        sorted = sort(window);
        medval = sorted(half_d+1);
        % if this point is too far below the local median, bump it up
        if medval - data(i) > dip_thresh
            data(i) = medval;
        end
    end
end

num_passes = 150; 

%Gaussian kernel
w = 11;              
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

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.
