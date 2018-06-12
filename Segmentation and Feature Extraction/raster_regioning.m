function [I] = raster_regioning(I)
    

    % make sure pixels are of incrementable type:
    I = single(I);
    
    % get image dimensions:
    [H, W] = size(I);
    
    % pad array to make indexing not fail without additional checking
    I = padarray(I, [1,1]);
    
    % initiate current label:
    cur_lbl = 0;
    
    conflicts = [];
    
    % first pass through image:
    for row = 2:H+1
        for col = 2:W+1
            if (I(row,col) == 1) % check if foreground object

                % first check if left pixel was assigned.
                if (I(row, col-1) >= 1)
                   % if so, then propogate assignment
                   I(row, col) = I(row, col-1);
                   
                   % check for conflicts
                   if ((I(row-1,col) >= 1) && I(row-1,col) ~= I(row,col))
                        conflicts = [conflicts; [row, col]];
                   end
                % otherwise check if top pixel was assigned.
                elseif (I(row-1, col) >= 1)
                    % if so, then propogate assignment
                    I(row, col) = I(row-1, col);
                else
                    cur_lbl = cur_lbl + 1;
                    I(row,col) = cur_lbl;
                end
            end
        end
    end
    
    %I = I(2:end-1, 2:end-1);
    
    % second pass
    for row = 2:H+1
        for col = 2:W+1
            if (I(row, col) >= 1) % if pixel is labelled:
                % check top
                if (I(row-1, col) >= 1)
                    I(I == I(row-1, col)) = I(row, col);
                end
                % check bottom
                if (I(row+1, col) >= 1)
                    I(I == I(row+1, col)) = I(row, col);
                end
                % check left
                if (I(row, col-1) >= 1)
                    I(I == I(row, col-1)) = I(row, col);
                end
                % check right
                if (I(row, col+1) >= 1)
                    I(I == I(row, col+1)) = I(row, col);
                end
            end
        end
    end
    
    I = I(2:end-1, 2:end-1);
end

