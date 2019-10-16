% @author Javier Mondragon
% @id A01365137
% @date 04/03/2019
%
% This script implements Regression Mix
% to find the equation of a sample and
% create a prediction using the Regression
% and Interpolation method
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

% 4.1 - y given by the model
data(:,3) = a(2)*data(:,1)+a(1);
% 4.2 - Sum of residuals
sr = sum((data(:,2)-data(:,3)).^2);

% 4.2 - Obtain the standar deviation
sy = std(data(:,2));

% 4.3 - Obtain the standar error from estimate(distance from points to the line)
syx = sqrt(sr/(n-2)); 
disp(syx);

if (syx<sy)
    disp('the model was worth it');
else
     disp('the model was not worth it');
end

prom = mean(data(:,2));
st = sum((data(:,2)-prom).^2);
% 4.4 - Obtain coefficient of determination
r2 = (st-sr)/st;

% 4.5 - Obtain coefficient of correlation

r = sqrt(r2);

% 4.4 - Obtain percentage of uncertain explained by the model
puem = r2*100;

% 5.1 - Create a prediction 

Q = input('Make prediction? (y/n)', 's');
if Q=='y'
    x = input('Give me the value where you need the prediction');
    y = a(2)*x+ a(1);
    plt(x,y,'*k');
    hold on;
else
    disp('Finished');
end