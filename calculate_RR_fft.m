function [RR_array] = calculate_RR_fft(breathing_intencity_vector,frames_per_window,frame_rate)
    %calculates respiration rate for each window with fft. 
    RR_array = zeros(length(breathing_intencity_vector),1);
    min_frame = 1;
    max_frame = frames_per_window;
    while (max_frame<length(breathing_intencity_vector))

        RR_array(min_frame:max_frame) = get_window_RR(breathing_intencity_vector(min_frame:max_frame),frame_rate);
        min_frame = min_frame+frames_per_window;
        max_frame = max_frame+frames_per_window;
    end
end

