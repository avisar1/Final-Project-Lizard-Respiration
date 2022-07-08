function [error_perecentage] = check_error(optical_flow_RR_array, frame_rate,time_of_frames)
    %interanal use for error checking according to manual data
    manual_data = zeros(length(optical_flow_RR_array),1);

    %%first video
    %first 2 minutes
    man = [28 26 25 25 24 24 23 23 22 23 21 20 20 21 20 19 ];
    first_minute=0;
    first_frame= first_minute*3*20*frame_rate;
    count=1;

    for index=(first_minute+1):1:first_minute+length(man)
        manual_data(first_frame+1+20*frame_rate*(index-1):first_frame+frame_rate*20*index)= man(count)*3;
        count=count+1;
    end
% 
%     %after 3 minutes
%     man = [23 21 20 20];
%     first_minute=3;
%     first_frame=first_minute*3*20*frame_rate;
%     count=1;
% 
%     for index=1:1:length(man)
%         manual_data(first_frame+1+20*frame_rate*(index-1):first_frame+frame_rate*20*index)= man(count)*3;
%         count=count+1;
%     end
    
    count_err = 0;
    total_err = 0;
    for i = 1:length(optical_flow_RR_array)
       if manual_data(i) ~= 0
           count_err = count_err+1;
           total_err = total_err + (abs(manual_data(i)-optical_flow_RR_array(i))/manual_data(i));
       end
    end
    figure(1)
 
%     plot(time_of_frames,optical_flow_RR_array, 'g');
%     hold on
%     plot(time_of_frames,manual_data, 'r');
%     hold on
%     plot(time_of_frames,rr_array_mean(1:length(time_of_frames)), 'b');
%     legend('Optical Flow','Manual', 'Mean Intensity')
%     set(gcf,'color','w')
% 
%     title('Breathing Ratev Vs Time ')
%     xlabel('Time[sec]')
%     ylabel('Brething Rate[bpm]')
    
    error_perecentage = 100*(total_err / count_err)
end

