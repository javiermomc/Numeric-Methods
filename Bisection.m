% @author Javier Mondragon
% @id A01365137
%
% This script implements Bisection Method
% to find the root of a nonlinear equation
%
% INPUT:
% Continous function
% Interval
% Tolerance
%
% OUTPUT:
% Approximation
% Number of steps

% 1.1 - User function
strF = input('f(x)=', 's');
strF = strcat('@(x)', strF);
f = str2func(strF);

% 1.2 - User interval
a = input('Lower interval: ');
b = input('Upper interval: ');

% 1.3 - User tolerance
e = input('Tolerance: ');

% 1.4 - Evaluate the function on the intervals
u = f(a);
v = f(b);

% 1.5 - Check if the intervals are the roots
if u == 0
    o = fprintf('Root: %d', a);
    disp(o);
    o = fprintf('Count: %d', 0);
    disp(o);
    return
elseif v == 0
    o = fprintf('Root: %d', b);
    disp(o);
    o = fprintf('Count: %d', 0);
    disp(o);
    return
end

% 1.6 - Check if the intervals are in a good range
if u*v>0
    disp('Intervals not valid');
    return
end

% 1.7 - Create the counter
i=1;

% 2.1 - Calculate the approximation
x = (a+b)/2;

% 2.2 - Evaluate the approximation
w = f(x);

% 2.3 - Check if the approximation is a root
if w==0
    o = fprintf('Root: %d', x);
    disp(o);
    o = fprintf('Count: %d', i);
    disp(o);
    return
end

% 3.1 - Recursively run the the process 2 until find the root
while w~=0 && abs(w)-fix(abs(w))>e
    if u*w<0
        b = x;
        v = f(b);
    else
        a = x;
        u = f(a);
    end
    x = (a+b)/2;
    w = f(x);
    i = i+1;
end

% 3.2 - Display the results
o = fprintf('Root: %d', x);
disp(o);
o = fprintf('Count: %d', i);
disp(o);