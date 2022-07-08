function [current_frequency] = gen_fft(breathing_intencity_vector,min_frame_for_clc,max_frame_for_clc,frams_per_sec,window_length_in_seconds)
window_length = (max_frame_for_clc-min_frame_for_clc)+1;
fs = frams_per_sec ;   % sampling frequency

window_size_sec = 20;
t = 0:(1/fs):(window_size_sec-1/fs); % time vector
S = breathing_intencity_vector(min_frame_for_clc:max_frame_for_clc);

low_pass_X = lowpass(S,2.5,fs) ;

n = length(S);
X = fft(S);
low_pass_X = fft(low_pass_X);
f = (0:n-1)*((fs)/n);     %frequency range
power = abs(X).^2/n;    %power
% figure(8)
% plot(f,power)
% title('fft ')
% xlabel('frequency')
% ylabel('power')
Y = fftshift(X);
low_pass_Y = fftshift(low_pass_X);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;  % zero-centered power
low_pass_powershift = abs(low_pass_Y).^2/n;

figure(9)
title('fft SHIFT ')
xlabel('frequency')
ylabel('power')
plot(fshift,powershift)

figure(10)
title('fft SHIFT - After BPF ')
xlabel('frequency')
ylabel('power')
plot(fshift,low_pass_powershift)
% hold off
[val, idx] = max(powershift);
current_frequency = abs(low_pass_powershift(idx));

end



