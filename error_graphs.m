close all
clear
optical_flow_errors = [ 7.57 5.3 4.71 3.01 2.82];
mean_errors = [10.06 5.47 7.36 21.57 18.26 15.31 17.33];
sum_error = [ 8.57 7.59 16.4 13.27 9.85 8.49]; 


    figure(1)
    title('Video Vs Average Error')
    xlabel('Video [number]')
    ylabel('Error [%]')
    set(gcf,'color','w');
    hold on
    plot([ 3 4 5 6 7],optical_flow_errors, 'g');
    hold on 
    plot([1 2 3 4 5 6 7],mean_errors, 'b');
    hold on
    plot([ 2 3 4 5 6 7],sum_error, 'r');
    legend('optical flow error','mean error','sum error')
    hold off

    