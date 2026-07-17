% Load built-in MATLAB audio sample
load splat % Loads 'y' and 'Fs'

% Generate echo: 0.25s delay, 0.6 amplification
output = echo_gen(y, Fs, 0.25, 0.6);

% Plot and Compare Waveforms
dt = 1/Fs;
figure;
subplot(2,1,1);
plot(0:dt:dt*(length(y)-1), y);
title('Original Audio Signal'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(0:dt:dt*(length(output)-1), output);
title('Processed Signal with Echo Effect'); xlabel('Time (s)'); ylabel('Amplitude');

% Play final output 
sound(output, Fs);