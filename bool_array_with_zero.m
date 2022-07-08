function [bool] = bool_array_with_zero(array)
    %check if there is a zero in array
    bool=0;
    for i=1:length(array)
        if (array(i) == 0) 
            bool = 1;
            break;
        end
    end
end

