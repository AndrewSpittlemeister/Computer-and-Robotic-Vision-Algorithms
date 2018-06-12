function [BW] = niblack(I, S, k)
    
    % get image attributes:
    [H, W] = size(I);
    NP = length(I(:));
    
    % pad image:
    pad = floor(S/2);
    WorkingImg = padarray(I, [pad,pad]);
    BW = zeros(size(I), 'logical');
    
    for row = 1+pad:H+pad
        for col = 1+pad:W+pad
            window = WorkingImg((row-pad):(row+pad), (col-pad):(col+pad));
            m = mean(window(:));
            window = (window - m).^2;
            s = sum(window(:));
            T = m + k * sqrt(s/NP);
            if (WorkingImg(row, col) > T)
                BW(row-pad, col-pad) = 0;
            else
                BW(row-pad, col-pad) = 1;
            end
        end
    end
end

