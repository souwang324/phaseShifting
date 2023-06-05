function result = mat2gray(x)
    height = size(x, 1);
    width = size(x,2); 
    value_min = min(min(x));
    value_max = max(max(x));    
    for m = 1:height
        for n = 1:width
            if (value_max-value_min) ~= 0
                y(m, n) = (x(m, n) -value_min)/(value_max-value_min);            
            else
                y(m, n) = 0;
        end
    end
    result = y;
end