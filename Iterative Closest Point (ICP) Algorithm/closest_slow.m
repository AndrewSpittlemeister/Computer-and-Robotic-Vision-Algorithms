%CLOSEST Find closest points in N-dimensional space.
%
% K = CLOSEST(A, B) is the correspondence for N-dimensional point sets A (NxNA)
% and B (NxNB).  K (1 x NA) is such that the element J = K(I), that is, that 
% the I'th column of A is closest to the Jth column of B.
%
% [K, D1] = CLOSEST(A, B) as above and D1(I)=|A(I)-B(J)| is the distance of the
% closest point.
%
% See also DISTANCE.

function [K, D1] = closest_slow(A, B)
    assert(size(A, 2) == size(B, 2))
    N = size(A, 2);
    K = zeros(1, N);
    D1 = zeros(1, N);
    for i=1:N
        % calculate distance (D)
        D = B - A(:, i)*ones(1, N);
        % find minimum norm and index
        vec_norm = zeros(1, N);
        for j=1:N
            vec_norm(j) = norm(D(:, j));
        end
        [D1(i), K(i)] = min(vec_norm);
    end