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
n = 500;

% strF = input('f(x)=', 's');
strF = strcat('@(x) ', strF);
f = str2func(strF);

% a = input('Lower limit: ');
% b = input('Upper limit: ');
% 
% n = input('Number of trapezoids: ');


% Initialize values

I = zeros(n, 1);
base = (b-a)/n;

x = a:base:b;
y = f(x);

% Obtain the areas

for i = 1:n
    averageHeight = (y(i)+y(i+1))/2;
    I(i) = base*averageHeight;
    plot([x(i+1), x(i+1)], [0, y(i+1)], 'g');
    hold on;
    
    plot([x(i), x(i+1)], [y(i), y(i+1)], 'g');
    hold on;
end

% Calculate the area and the error
area = sum(I);
real = integral(f, a, b);

% Print results
d = ['Area: ', num2str(area)];
disp(d);

d = ['Error: ', num2str(real)];
disp(d);

% Graph results
x = linspace(a,b);
y = f(x);
plot(x, y);

