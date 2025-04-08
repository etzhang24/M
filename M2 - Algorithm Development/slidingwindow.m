data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");

compact_winter_test1 = data(:, 2);

% window size
w = 3;

% first pass
n1 = length(compact_winter_test1);
first_pass = zeros(n1 - w + 1, 1);

for i = 1:(n1 - w + 1)
    window = compact_winter_test1(i:i+w-1);
    first_pass(i) = mean(window);
end

% second pass
n2 = length(first_pass);
second_pass = zeros(n2 - w + 1, 1);

for i = 1:(n2 - w + 1)
    window = first_pass(i:i+w-1);
    second_pass(i) = mean(window);
end

%third pass
n3 = length(second_pass);
third_pass = zeros(n3 - w + 1, 1);

for i = 1:(n3 - w + 1)
    window = second_pass(i:i+w-1);
    third_pass(i) = mean(window);
end

% plot
figure;

subplot(4, 1, 1);
plot(compact_winter_test1, 'b.-');
title('Original Data');
xlabel('Index');
ylabel('Speed');
grid on;

subplot(4, 1, 2);
plot((w:n1), first_pass, 'g.-');
title('1st Pass - 3-Value Moving Average');
xlabel('Index');
ylabel('Speed');
grid on;

subplot(4, 1, 3);
plot((2*w-1:n1), second_pass, 'r.-');
title('2nd Pass - Smoothed Again');
xlabel('Index');
ylabel('Speed');
grid on;

subplot(4, 1, 4);
plot((2*w-1:n2), third_pass, 'k.-');
title('3rd Pass - Smoothed Again p2');
xlabel('Index');
ylabel('Speed');
grid on;