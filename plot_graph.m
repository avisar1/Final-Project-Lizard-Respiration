function  [] = plot_graph(breathing_intencity_vector,RR_array,time_of_frames)
    %plot breathing pattern and RR graphs
    disp("Generating breathing intensity and RR graphs");
    time_of_frames = time_of_frames.';

    figure(1)
    plot(time_of_frames,breathing_intencity_vector, 'g');

    title('Breathing Optical Flow - Average Filter')
    xlabel('Time[sec]')
    ylabel('Optical Flow Counter ')
    set(gcf,'color','w');


    figure(2)
    plot(time_of_frames,RR_array, 'g');
    title('Respiration Rate Vs Time  ')
    xlabel('Time[sec]')
    ylabel('Respiration Rate [bpm]')


end

