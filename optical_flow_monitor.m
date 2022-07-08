function [breathing_intencity_vector,time_of_frames, frams_per_sec] = optical_flow_monitor(window_length_in_seconds,video_path,skip_evm,Valid_Frames_For_RR)
    %generates breathing intensity according to optical flow counter method
    opticFlow = opticalFlowLK('NoiseThreshold',0.009);
    vidObj = VideoReader(video_path);
    frams_per_sec = ceil(vidObj.FrameRate);
    num_of_frames_in_window = frams_per_sec * window_length_in_seconds;
    breathing_intencity_vector = zeros(vidObj.NumFrames,1);
    % time_of_frames vector in length of num of frames
    time_of_frames=1:1:vidObj.NumFrames;
    % change n vector untis to second - 30fps
    time_of_frames=time_of_frames/frams_per_sec;

    min_frame_for_clc=1;
    max_frame_for_clc=num_of_frames_in_window;
    
    while (max_frame_for_clc<vidObj.NumFrames)
        non_valid_frame = bool_array_with_zero(Valid_Frames_For_RR(min_frame_for_clc:max_frame_for_clc));
%         if (non_valid_frame)
%             min_frame_for_clc = min_frame_for_clc + num_of_frames_in_window;
%             max_frame_for_clc = max_frame_for_clc + num_of_frames_in_window;
% 
%             percentage = ((max_frame_for_clc/vidObj.NumFrames)*100);
%             if(percentage<100)
%                 percentage
%             else
%                 disp("100%"+ newline + "Optical Flow Algorithm Ended Successfuly" + newline);
%             end
%             continue;
%         end
        if skip_evm
            for i = min_frame_for_clc:max_frame_for_clc
                frame=readFrame(vidObj);
                frameGray = im2gray(frame);
                %frameGray = histeq(frameGray);
                flow = estimateFlow(opticFlow,frameGray);
                center_x = ceil(length(frameGray)/2);
                center_y = ceil(length(frameGray(:,1))/2);
                index_of_more_than_mean_magnitude_array = detect_more_than_mean_indexes(flow.Magnitude);%more than mean magnitude
                breathing_intencity_vector(i) = gen_intensity_from_orientation(center_x,center_y,index_of_more_than_mean_magnitude_array,flow.Orientation);
            end
        else
        breathing_intencity_vector(min_frame_for_clc:max_frame_for_clc)= calculate_intensity_EVM_optical_flow(video_path, 10, 16, 0.4, 0.05, 0.1,min_frame_for_clc,max_frame_for_clc);
        end        
        min_frame_for_clc = min_frame_for_clc + num_of_frames_in_window;
        max_frame_for_clc = max_frame_for_clc + num_of_frames_in_window;
        
        percentage = ((max_frame_for_clc/vidObj.NumFrames)*100);
        if(percentage<100)
            percentage
        else
            disp("100%"+ newline + "Optical Flow Algorithm Ended Successfuly" + newline);
        end
    end

end

