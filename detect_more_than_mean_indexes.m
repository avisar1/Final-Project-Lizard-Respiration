function [index_of_more_than_mean_magnitude_array] = detect_more_than_mean_indexes(magnitude_array)
    mean_magnitude = mean (magnitude_array,'all');
    index_of_more_than_mean_magnitude_array = zeros(length(magnitude_array(:,1)),length(magnitude_array));
    for i = 1:length(magnitude_array(:,1))
        for j =1:length(magnitude_array)
            
            if magnitude_array(i,j)> mean_magnitude
                index_of_more_than_mean_magnitude_array(i,j) = 1;
            end
            
        end
    end

end

