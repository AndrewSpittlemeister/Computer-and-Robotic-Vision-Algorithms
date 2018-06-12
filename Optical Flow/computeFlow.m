function [u,v] = computeFlow(im1,im2, iter)
    % Computes the optical flow between the 2 images given as inputs.
    
    avg_filter = gpuArray(ones(3)/9);
    
    % fx calculation with sobel:
    fx_img1 = conv2(im1,0.1111*[-1 0 1;-2 0 2;-1 0 1],'same');
    fx_img2 = conv2(im2, 0.1111*[-1 0 1;-2 0 2;-1 0 1],'same');
    fx = fx_img1 + fx_img2;
    
    % fy calculation with sobel:
    fy_img1 = conv2(im1, 0.1111*[-1 -2 -1;0 0 0;1 2 1], 'same');
    fy_img2 = conv2(im2, 0.1111*[-1 -2 -1;0 0 0;1 2 1], 'same');
    fy = fy_img1 + fy_img2;
    
    % ft calculation with 3x3 kernel:
    ft_img1 = conv2(im1, 0.1111*[1 1 1;1 1 1;1 1 1],'same');
    ft_img2 = conv2(im2, -0.1111*[1 1 1;1 1 1;1 1 1],'same');
    ft = ft_img1 + ft_img2;
    
    % initialize u and v vectors:
    u = gpuArray(zeros(size(im1)));
    v = gpuArray(zeros(size(im1)));
    
    % iterate to update u and v:
    for i = 1:iter
        % compute current averages:
        u_average = imfilter(u, avg_filter);
        v_average = imfilter(v, avg_filter);
        
        % update u and v estimates:
        P = (fx .* u_average) + (fy .* v_average) + ft;
        D = 1 + fx.^2 + fy.^2;
        u = u_average - (fx .* P) ./ D;
        v = v_average - (fy .* P) ./ D;
    end
    
    % zero out NaN values (debug technique found from Mohd Kharbat)
    u(isnan(u))=0;
    v(isnan(v))=0;
end