function [Pr_closest,Qr_closest] = unique_pairs(Pr,Qr, corresp)
% Filters out unique pairs of closest points and order each point
%   list such that matching points share an index.
    
    % Get list of unique correspondence indicies.
    u = unique(corresp, 'stable');
    
    % Create 2 new point cloud subsets that will only contain uniquely
    %   matching points
    Pr_closest = zeros([3, length(u)]);
    Qr_closest = zeros([3, length(u)]);
    
    for i=1:length(u)
        idx = find(corresp==u(i));
        Pr_closest(:, i) = Pr(:, idx(1));
        Qr_closest(:, i) = Qr(:, u(i));
        
        
        % not the right way...
%         Pr_closest(:, i) = Pr(:, u(i));
%         idx = find(corresp==u(i));
%         Qr_closest(:, i) = Qr(:, idx(1));
    end
end

