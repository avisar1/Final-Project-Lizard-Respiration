function [respiration_rate] = get_window_RR(breathing_intencity_vector_optical,frame_rate)
       %calculates window RR with fft 
       Fs = frame_rate;
       x = breathing_intencity_vector_optical;
       x = lowpass(x,2,Fs);
       x = highpass(x,0.3,Fs);
       xdft = fftshift(fft(x));
       df = Fs/length(x);
       half_res = df/2;
       freq = -Fs/2+half_res:df:Fs/2-half_res;
       figure(10)
%        plot(freq,abs(xdft))
%            set(gcf,'color','w');
%            hold on
%        title('fft Shift')
%        xlabel('frequency')
%        ylabel('power')
%        plot(freq,abs(xdft))
%            set(gcf,'color','w');
%            hold on
%        title('fft Shift - After BPF ')
%        xlabel('frequency')
%        ylabel('power')
       [M,I] = max(xdft);
       current_frequency = abs(freq(I));
       respiration_rate = current_frequency*60;
       if (respiration_rate>120 || respiration_rate<20)
           respiration_rate=0;
       end

end

