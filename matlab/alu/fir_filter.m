
function y = fir_filter(x, b)
    N = length(b);        % Number of taps
    y = zeros(size(x));   % output vector, same length as input

    % FIR filter
    for n = N:length(x)      % first position where we have 64 samples
        acc = 0;             % Accumulator starts at zero
        for i = 1:N
            acc = acc + x(n-i+1) * b(i);   % Multiply and accumulate with each tap
        end
        y(n) = acc;          % Accumulate result in y(n)
    end
end
