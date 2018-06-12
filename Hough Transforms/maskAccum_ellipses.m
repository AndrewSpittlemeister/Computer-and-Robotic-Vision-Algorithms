function [newA] = maskAccum_ellipses(A, a, b, x0, y0)
% This function masks out a region of the accumulator array centered at 
%   (a, b, x0, y0).
    maskSize = 30;
    sz = size(A);
    mask = ones(sz, class(A(1,1,1,1)));
    for i=-maskSize:maskSize
        for j=-maskSize:maskSize
            for k=-maskSize:maskSize
                for l = -maskSize:maskSize
                    aVal = a + i;
                    bVal = b + j;
                    x0Val = x0 + k;
                    y0Val = y0 + l;
                    if (aVal >= 1 && aVal <= sz(1) && bVal >= 1 && bVal <= sz(2) && x0Val >= 1 && x0Val <= sz(3) && y0Val >= 1 && y0Val <= sz(4))
                        mask(a + i, b + j, x0 + k, y0 + l) = 0;
                    end
                end
            end
        end
    end
    newA = A .* mask;
end