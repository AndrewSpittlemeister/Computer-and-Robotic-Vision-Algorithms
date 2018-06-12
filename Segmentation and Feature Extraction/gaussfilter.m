function [FinalImg] = gaussfilter(I, S, sigma)

    I = single(I);
    pad = floor(S/2);
    WorkingImg = padarray(I, [pad,pad]);
    [H, W] = size(I);
    FinalImg = zeros(size(I), 'single');
    
    filter = single(fspecial('gaussian', S, sigma));
    
    for row = 1+pad:H+pad
        for col = 1+pad:W+pad
            window = WorkingImg((row-pad):(row+pad), (col-pad):(col+pad));
            FinalImg(row-pad, col-pad) = sum(sum(window .* filter));
        end
    end
    FinalImg = uint8(FinalImg);
end

