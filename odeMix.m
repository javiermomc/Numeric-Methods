clc;
clear;

% Ask for inputs to the user
strF = '-2.*x.^3+12.*x.^2-20.*x+8.5';
interval = [0, 4];
condition = [0, 1];

% Ask the user for inputs

% strF = input('f(x)=', 's');
% interval = input('Interval as vector:');
% condition = input('Condition as vector:');

strF = strcat('@(x) ', strF);
f = str2func(strF);

h = 0.001;
a = interval(1);
b = interval(2);
x = a:h:b;
x = x';

yEuler = zeros(size(x));
yEuler(1) = condition(2);

for i = 1:length(x)-1
    slope = f(x(i));
    yEuler(i+1) = yEuler(i) + slope.*h;
end

% Analytic solution:
strF2 = '-x.^4./2+4.*x.^3-10.*x.^2+8.5.*x+1';
strF2 = strcat('@(x) ', strF2);
f2 = str2func(strF2);
yR = f2(x);

% Display results
disp('    x         yEuler         yReal');
disp([x, yEuler, yR]);

plot(x, yR, 'r', x, yEuler, 'b');
title('Runge-Kutta Methods');
legend('Real', 'Euler');

% d = ['Error: ', num2str(real)];
% disp(d);





















