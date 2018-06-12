function [T] = icp_simple(Pr,Qr, N)
%icp_simple runs the icp transition matrix estimation process N times.
    
    % Instantiate the intitial transition matrix with the identity.
    T = eye(4);
    for i=1:N
        
        % Find closest non-unique point pairs between Pr and Qr.
        corresp = closest(Pr, Qr);
        
        % Filter out unique pairs of closest points and order each point
        %   list such that matching points share an index.
        [Pr_closest,Qr_closest] = unique_pairs(Pr, Qr, corresp);
        
        % Find deltaT using pq2tr function.
        deltaT = pq2tr(Pr_closest, Qr_closest);
        %deltaT = pq2tr(Pr, Qr(:, corresp));
        
        % Update transition matrix T and point cloud Pr.
        T = deltaT * T;
        Pr = h2e(deltaT * e2h(Pr));
        
        % Display Current iteration and mean distance between point clouds.
        [~, D] = closest(Pr, Qr);
        disp(strcat("Iteration:", " ",  num2str(i)));
        disp(strcat("    Current mean distance: ", " ", num2str(mean(D)))); 
    end
end

