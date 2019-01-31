% @author Javier Mondragon
% @id A01365137
% @date 31/01/2019
%
% This script implements Secant Method
% to find the root of a nonlinear equation
%
% INPUT:
% Continous function
% Two approximations
% Tolerance
%
% OUTPUT:
% Approximation
% Number of steps

% 1.1 - User function
strF = input('f(x)=', 's');
strF = strcat('@(x) ', strF);
f = str2func(strF);

% 1.2 - Approximations interval
a = input('First approximation: ');
b = input('Second approximation: ');

% 1.3 - User tolerance
e = input('Tolerance: ');
prev = 0;

% 1.4 - Evaluate the function on the intervals
u = f(a);
v = f(b);

% 1.5 - Check if the approximations are the roots
if u == 0
    o = ['Root: ', num2str(a)];
    disp(o);
    o = ['Count: ', num2str(0)];
    disp(o);
    return
elseif v == 0
    o = ['Root: ', num2str(b)];
    disp(o);
    o = ['Count: ', num2str(0)];
    disp(o);
    return
end

% 1.6 - Create the counter
i=1;

% 2.1 - Calculate the next approximation
x = b-v*(a-b)/(u-v);

% 3.1 - Recursively run the the process 2 until find the root
while u~=0 && v~=0 && abs((x-prev)/x)*100>e
    prev = x;
    a=b;
    b=x;
    x = b-v*(a-b)/(u-v);
    i = i+1;
end

% 3.2 - Display the results
o = ['Root: ', num2str(x)];
disp(o);
o = ['Count: ', num2str(i)];
disp(o);