% @author Javier Mondragon
% @id A01365137
% @date 04/03/2019
%
% This script implements Regression and interpolation
% to find the equation of a sample
%
% INPUT:
% Data points (2D)
% Tolerance
%
% OUTPUT:
% The linear model
% Quantification of an error

% 1.1 - Ask the user for data
data = input('Matrix of the data [x y; x y; ...]= ');

% 1.2 - Verify if the data is in correct format
[n, p] = size(data);

if p~=2
    disp('The matrix is not in correct format');
    return;
end

% 2.1 - Get the matrix of coefficients
A = [n sum(data(:,1)); sum(data(:,1)) sum(data(:,1).^2)];

% 2.2 - Vector of constants
b = [sum(data(:,2)); sum(data(:,1).*data(:,2))];

% 2.3 - Solve the system
a = A\b;

% 3.1 - Display results
disp('The linear model that best fit the data is:');
s = ['y=', num2str(a(2)), ' x=', num2str(a(1))];
disp(s);

% 3.2 - Plot the answer
plot(data(:,1), data(:,2), 'o');
hold on

x = min(data(:,1)) : max(data(:, 1));
y = a(2)*x + a(1);
plot(x,y, 'r');
