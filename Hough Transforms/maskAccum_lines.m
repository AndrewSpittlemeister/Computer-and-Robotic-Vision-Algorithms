function [newA] = maskAccum_lines(A, rho, theta)
% This function masks out a region of the accumulator array centered at 
%   (rho, theta).
    maskSize = 30;
    mask = ones(size(A));
    for i=-maskSize:maskSize
        for j=-maskSize:maskSize
            mask(rho + i, theta + j) = 0;
        end
    end
    newA = A .* mask;
end