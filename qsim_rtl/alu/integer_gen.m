% Load floating-point input samples
input_samples = load('input_samples.txt');

% Scale to signed 16-bit integer range
scaled_samples = round(input_samples * 2^15);

% Save to a new file
dlmwrite('input_samples_int.txt', scaled_samples, 'delimiter', '\n');
disp('Converted input_samples_int.txt saved.');
