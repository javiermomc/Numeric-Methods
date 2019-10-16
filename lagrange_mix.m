% @author Javier Mondragon
% @id A01365137
%
% This script implements La Grange Interpolation Polynomials
% to find the root of a nonlinear equation
%
% INPUT:
% Matrix of data
%
% OUTPUT:
% Root
% APRE
% Number of steps

DATA = input('Set of data as a matrix [x1 y1; x2 y2; ... xn yn]: ');

x = input('Value of estimation:');

if (x>max(DATA(:,1))||x<min(DATA(:,1)))
    disp('Value out of range.');
    return;
end
plot(DATA(:, 1), DATA(:, 2), 'o');
hold on;



y = sum(L.*DATA(:, 2));

plot(x, y, 'r');

x1 = linspace(min(DATA(:, 1)), max(DATA(:, 1)));
y1 = zeros(size(x1));
for k= 1:100
    L = ones(n,1);

    for i=1:n
        for j=1:n
            if i~=j
                L(i) = (( x ~ DATA(j, 1))/(DATA(i, 1) - DATA(j, 1)))*L(i);
            end
        end
    end
    y1(k) = sum(L.*DATA(:, 2));
end
plot(x1, y1);


















