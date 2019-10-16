% @author Javier Mondragon Martin del Campo
% @id A01365137
% @date 03/21/2019
% 
% This script implements a linear interpolation
% to calculate an estimation on a new 'x' value
% 
% INPUT:
% - Data points
% - Value where the estimation is needed
% 
% OUTPUT:
% - Estimation
% - Graph

% Ask the inputs
DATA = input('Data as two column matrix:');
x = input('Value of estimation:');

[n, p] = size(DATA);

if p~=2
    disp('The matrix is not correct');
    return;
end 

% Graph the data points
plot(DATA(:,1), DATA(:,2), 'o');
hold on;

% Graph linear interpolation
DATA = sortrows(DATA);
plot(DATA(:,1), DATA(:,2));

if x>min(DATA(:,1)) && x<max(DATA(:,2))
    
    pos = sum(x>DATA(:, 1));
    x0 = DATA(pos, 1);
    y0 = DATA(pos, 2);
    x1 = DATA(pos+1, 1);
    y1 = DATA(pos+1, 2);
    
    y = y0 + ((y1-y0)/(x1-x0))*(x-x0);
    
    plot(x,y, '*k');
else
    disp('Value out of range');
end
