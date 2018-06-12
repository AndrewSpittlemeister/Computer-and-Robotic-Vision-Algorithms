function [T] = pq2tr(P,Q)
%pq2tr estimates the transition matrix between 2 point clouds.
    p_mean = mean(P, 2);
    q_mean = mean(Q, 2);
    X = P - p_mean;
    Y=  Q - q_mean;
    W = eye(length(Q(1,:)));
    S = X * W * Y';
    [U, ~, V] = svd(S);
    
    % calculate R and t:
    R = V * U';
    t = q_mean - R * p_mean;
    
    % format R and t into transformation matrix:
    T = zeros(4);
    T(1:3, 1:3) = R;
    T(1:3, 4) = t;
    T(4,4) = 1;
end

