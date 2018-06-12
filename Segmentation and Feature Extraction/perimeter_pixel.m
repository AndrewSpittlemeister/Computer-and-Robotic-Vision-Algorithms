function [valid] = perimeter_pixel(I, row, col)
% Takes in a binary image with a row and column specification and checks
%   all neighbors (8 connectivity) to see if this pixel is part of a
%   perimeter.
        
    % pad image to avoid index out of bound error when checking 
    %   neighboring pixels, modify row and col accordingly such that they 
    %   will correspond to the correct pixel in the padded image.
    I = padarray(I, [1,1]);
    row = row + 1;
    col = col + 1;
    
    window = I(row-1:row+1, col-1:col+1);

    % if this pixel is a perimeter pixel or is on the border of the image,
    %   then s will be less than 9.
    valid = (sum(window(:)) < 9);

end

