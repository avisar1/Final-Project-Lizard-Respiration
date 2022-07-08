%Automated Analysis of Breathing Dynamics in Moving Lizards
% Documentation This program gets a video of breathing lizard as an input and plots two graphs from a lizard video:
% 1)Respiration rate graph.
% 2)Breathing pattern graph.
%Fill the parameters below (according to readme.txt file) and run the
%program.

clear
close all
%inputs: 
generate_crop = 1; %if turned off make sure there is a video in "croped_video_path" parameter
skip_evm = 0; %recommended not to skip EVM amplification
window_length_in_seconds = 10;%set 10 to 30 seconds
video_path = "Copy_of_Lizard_moving_1min.mp4";
croped_video_path = "Lizard_moving_1min_cropped_by_DLC.avi";
DLCcsvfile_path = "lizrad_moving_1_min.csv";
[frame_size_x,frame_size_y] = get_frame_size(video_path);

if (generate_crop)
    [Roi_Frame_Num, Roi_Rect, Valid_Frames_For_RR] = Dlc_Roi_Tracking(video_path, croped_video_path, DLCcsvfile_path, frame_size_x, frame_size_y);
end

[breathing_intencity_vector_optical,time_of_frames, frame_rate] = optical_flow_monitor(window_length_in_seconds,croped_video_path,skip_evm,Valid_Frames_For_RR);
breathing_intencity_vector_optical = average_filter(breathing_intencity_vector_optical);
RR_array_smooth_fft = calculate_RR_fft(breathing_intencity_vector_optical,frame_rate*window_length_in_seconds,frame_rate);
plot_graph(breathing_intencity_vector_optical,RR_array_smooth_fft,time_of_frames.');

