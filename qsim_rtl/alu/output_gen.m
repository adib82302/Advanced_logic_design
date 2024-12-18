% Load scaled input samples and coefficients
scaled_inputs = load('input_samples_int.txt');
coeffs_fixed = load('coeffs.txt');

% Compute expected outputs using convolution
expected_outputs = conv(scaled_inputs, coeffs_fixed, 'same');

% Save to file
dlmwrite('expected_outputs.txt', expected_outputs, 'delimiter', '\n');
disp('Expected outputs saved to expected_outputs.txt.');
