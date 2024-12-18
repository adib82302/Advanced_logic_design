% Generate FIR filter coefficients for 64 taps
% Low-pass FIR filter example with a normalized cutoff frequency of 0.5
N = 64; % Number of coefficients (taps)
coeffs = fir1(N-1, 0.5); % Design a low-pass FIR filter with cutoff at 0.5

% Scale to signed 16-bit integers
coeffs_fixed = round(coeffs * 2^15);

% Save the coefficients to coeffs.txt
dlmwrite('coeffs.txt', coeffs_fixed, 'delimiter', '\n');
disp('64 coefficients saved to coeffs.txt');
