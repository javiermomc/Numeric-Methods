% @author Javier Mondragon
% @id A01365137
%
% This script implements Newton-Raphson's Method
% to find the root of a nonlinear equation
%
% INPUT:
% Function (derivable)
% Derivative of the given function
% Approximation (First good one)
%
% OUTPUT:
% Root
% APRE
% Number of steps

% 1.1 - User function
strF = input('f(x)=', 's');
strF = strcat('@(x) ', strF);
f = str2func(strF);

% 1.2 - User derivative
strF = input('df(x)', 's');
strF = strcat('@(x) ', strF);
df = str2func(strF);

% 1.3 - User approximation
x0 = input('Approximation: ');

% 1.3 - User tolerance
e = input('Tolerance: ');

% 1.4 - Create APRE
apre = 100;

% 2.2 - Evaluate for a flat point and calculate next approximations until
%       find the root

max=1000;
n=0;

while(apre>e&&n<max)
    fx = f(x0);
    dx = df(x0);

    if(dx==0 || abs(dx)<1e-4)
        disp('Error: a flat point has been reached');
        return;
    end

    x1 = x0- fx/dx;
    apre = abs((x1-x0)/x1)*100;
    x0 = x1;
    n=n+1;
end

% 3.1 - Display results

d = ['Number of steps: ', num2str(n)];
disp(d);
d = ['APRE: ', num2str(apre)];
disp(d);
d = ['Root: ', num2str(x1)];
disp(d);




