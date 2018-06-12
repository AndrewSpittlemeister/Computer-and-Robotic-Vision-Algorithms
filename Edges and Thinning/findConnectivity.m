function [ConnectivityNum] = findConnectivity(window)
%   Window should be 3 x 3
    i = 2;
    j = 2;
    edge = [window(i,j+1), window(i-1,j+1), window(i-1,j), window(i-1,j-1), window(i,j-1), window(i+1,j-1), window(i+1,j), window(i+1,j+1)];
    ConnectivityNum = 0;
    for k = 1:8
        if (k < 8)
            ConnectivityNum = ConnectivityNum + (edge(k) < edge(k+1));
        else
            ConnectivityNum = ConnectivityNum + (edge(8) < edge(1));
        end
    end

end

