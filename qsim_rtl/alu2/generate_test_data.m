input_samples = int16(1:64);
coeffs = int16(ones(1, 64));
result = sum(int32(input_samples) .* int32(coeffs));

% Save to files
dlmwrite('input_samples.txt', input_samples, 'delimiter', '\n');
dlmwrite('coeffs.txt', coeffs, 'delimiter', '\n');
fp16_result = single(result) / (2^15); % Convert to FP16 for expected results
dlmwrite('fir.results', fp16_result, 'delimiter', '\n');
