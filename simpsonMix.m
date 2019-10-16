% This script implements a Simpson 1/3 rule to
% estimate the area below the curve
% Inputs:
%  - Function
%  - Lower limit
%  - Upper limit
%  - Number of trapezoids

% Ask for inputs to the user
strF = '0.2+25*x-200*x.^2+675*x.^3-900*x.^4+400*x.^5';
a = 0;
b = .8;
n = 11;

% strF = input('f(x)=', 's');
strF = strcat('@(x) ', strF);
f = str2func(strF);

% a = input('Lower limit: ');
% b = input('Upper limit: ');
% 
% n = input('Number of applications: ');


% Initialize values

I = zeros(n, 1);
base = (b-a)/n;
h = base/2;

x = a:h:b;
y = f(x);

plot([a, a], [0, y(1)], 'g');
hold on;

xPlot = linspace(a, b);
yPlot = f(xPlot);
plot(xPlot, yPlot);
hold on;

for i = 1:n
    aveHeight = (y(i*2-1) + 4*y(i*2) + y(i*2+1))/6;
    I(i) = base*aveHeight;
    
    plot([x(i*2+1), x(i*2+1)], [0, y(i*2+1)], 'g');
    hold on;
    
    % LaGrange
    DATA = [x(i*2-1), y(i*2-1); x(i*2), y(i*2); x(i*2+1), y(i*2+1)];
    x1 = linspace(x(i*2-1), x(i*2+1));
    y1 = zeros(size(x1));
    for k = 1:100
        L = ones(3,1);
        for q=1:3
            for j=1:3
                if q~=j
                    L(q)=((x1(k) - DATA(j,1))/(DATA(q,1) - DATA(j,1)))*L(q);
                end
            end
        end
        y1(k) = sum(L.*DATA(:,2));
    end
    plot(x1,y1, 'm');
    hold on;
end

area = sum(I);
real = integral(f, a, b);
error = abs((real-area)/real)*100;

o = ['Area: ', num2str(area)];
disp(o);
o = ['Error: ', num2str(error)];
disp(o);