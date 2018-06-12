function [I] = fill_img(I)
% Takes binary image with one object and fills in all holes of the object.

    [H, W] = size(I);
    for row = 1:H
        obj_found = false;
        start_col = 0;
        stop_col = 0;
        for col = 1:W
            if (col == W) % if we are at the end of the row
                if (obj_found) % and we encounter the object in this row
                    if (stop_col > 0)
                        I(row, start_col:stop_col) = true; % fill object in
                    else
                        I(row, start_col:col) = true;
                    end
                end
            elseif (I(row, col))
                if (~obj_found) % then this is first 1 in this row.
                    obj_found = true;
                    start_col = col;
                elseif(I(row,col+1) == false) % then we found a stop
                    stop_col = col;
                end
            end
        end
    end
    
end

