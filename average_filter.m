function [breathing_intencity_vector_optical] = average_filter(breathing_intencity_vector_optical)
    %input: array
    %output: average filtered array
    frames_per_average = 10;
    coeff_avg_filter = ones(1, frames_per_average)/frames_per_average;
    breathing_intencity_vector_optical = filter(coeff_avg_filter, 1, breathing_intencity_vector_optical);
end

