

% Parameters
fs = 44100;                % Sampling frequency (44.1 kHz) nyquist
duration = 2;              % 2 second signal
t = 0:1/fs:duration-1/fs;  % Time vector

signal = sin(2 * pi * 500 * t);  % 500 Hz base signal

noise = 0.5 * sin(2 * pi * 10000 * t) + 0.3 * randn(size(t));  % 10 Khz noise signal

noisy_signal = signal + noise; 

% 64-tap low-pass FIR filter
N = 64;                        % Number of taps 
cutoff_freq = 2000 / (fs/2);   % Cutoff frequency at 2 kHz
b = fir1(N-1, cutoff_freq);    % random FIR filter coefficients simulating a low pass filter

% 
filtered_signal = fir_filter(noisy_signal, b);  % FIR function to signal


% Frequency axis
f = linspace(-fs/2, fs/2, length(noisy_signal));

% FFT of noisy and filtered signals to get freuqencies
noisy_signal_fft = fftshift(fft(noisy_signal));
filtered_signal_fft = fftshift(fft(filtered_signal));

% DB scaling
noisy_signal_dB = 20 * log10(abs(noisy_signal_fft));
filtered_signal_dB = 20 * log10(abs(filtered_signal_fft));

% Plot of my results

figure;

% Time-domain plot
subplot(2, 2, 1);
plot(t, noisy_signal);
title('Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0, 0.01]);  

% Frequency spectrum 
subplot(2, 2, 2);
plot(f / 1000, noisy_signal_dB);  % Frequency in kHz for easier interpretation
title('Noisy Signal Frequency Spectrum');
xlabel('Frequency (kHz)');
ylabel('Amplitude (dB)');
ylim([-100, 20]);

% Time-domain plot of filtered signal
subplot(2, 2, 3);
plot(t, filtered_signal);
title('Filtered Signal ');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0, 0.01]);  

% Frequencies of filtered signal
subplot(2, 2, 4);
plot(f / 1000, filtered_signal_dB);
title('Filtered Signal frequency spectrum');
xlabel('Frequency (kHz)');
ylabel('Amplitude (dB)');
ylim([-100, 20]);
