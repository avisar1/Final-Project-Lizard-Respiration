function [intensity] = gen_intensity_from_orientation(center_x,center_y,important_array,orientation);
    %optical flow counter method - generates breathing pattern according to
    %breathing orientation
    intensity = 0;
    for x = 1:length(important_array(:,1))
        for y =1:length(important_array)
            
            if important_array(x,y)> 0
                
                points_angle = rad2deg(atan2(center_y-y,center_x-x));
                velocity_angle = rad2deg(orientation(x,y));
                if and(points_angle<velocity_angle+90,points_angle>velocity_angle-90)
                    intensity = intensity + 1;
                else                
                  intensity = intensity - 1;
                end 
            end
            
        end
    end
end

