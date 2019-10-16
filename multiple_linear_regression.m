% Multiple linear regression
% This script implements the multiple linear regression model in order to
% obtain an equation from a sample of data loaded from files in the same
% directory.
%
% The data must be as [x1,x1,x1,x1;x2,x2,x2,x2;x3,x3,x3,x3;x4,x4,x4,x4;...]
% for x and y, the x values will be loaded from the file x.txt writen as an
% ASCII File and the y values will be loaded from y.txt with the same
% restrictions (remember y values must be only 1 row).
%
% Authors: 
%     Javier Mondragon Martin del Campo A01365137
%     Edgar Yañez Castro A01368348
%     Karen Leticia Bielma Leduc A01364986

clc;
clear;

% Load data from txt
data = load('x.txt');
yData = load('y.txt');

% Check if y values are correct
[o, p] = size(yData);
if o>1
    disp('Y are not correct');
    return;
end

% Create the initial values
[o, p] = size(data);
x = zeros(o,1);
y = zeros(o+1, 1);
A = zeros(o+1, o+1);

% Fill an array for the first row and column of the matrix A and y vector
for i=1:1:o+1
    for j=1:1:p
        if i~=1
            x(i-1) = x(i-1)+data(i-1, j);
        end
        if i~=1
            y(i) = y(i)+data(i-1, j)*yData(j);
        else
            y(i) = y(i)+yData(j);
        end
    end
end

A(1,1) = p;

for i=2:1:o+1
    A(i,1) = x(i-1);
    A(1,i) = x(i-1);
end

% Obtain the rest of the values for matrix A
for i=1:1:o
    for j=1:1:o
        for k=1:1:p
            A(i+1,j+1) = A(i+1,j+1)+data(i,k)*data(j,k);
        end
    end
end

% Obtain the oefficients
b = inv(A)*y;

% Create the function on string
strF = '';
var = '@(';
for i=1:1:o+1
    if i==o+1
        strF = strF+"("+num2str(b(i))+").*x"+num2str(i-1);
        var = var+"x"+num2str(i-1);
    elseif i~=1
        strF = strF+"("+num2str(b(i))+").*x"+num2str(i-1)+"+";
        var = var+"x"+num2str(i-1)+",";
    else
        strF = num2str(b(i))+"+";
    end
end
var = var + ') ';
strF = var+strF;
disp(strF)

% Create the matlab function
f = str2func(strF);
% From this point if you know the number of values to enter into the
% function you could use the f to evaluate that ex. if f(x1, x2) use
% f(1,2) the obtained function is displayed con console.


% Ask if the user wants to get an approximation
in = input('Do you want to make a proposal? y/n\n', 's');
if in~='y'
    disp('You have selected an option different from y');
    disp('Program finished...');
    return;
end

% Ask and insert the user values into the function as string
strF = '';
var = '@(x) ';
for i=1:1:o+1
    s = ['Proposal for x',num2str(i-1), '= '];
    if i==o+1
        strF = strF+"("+num2str(b(i))+").*"+input(s, 's');
    elseif i~=1
        strF = strF+"("+num2str(b(i))+").*"+input(s, 's')+"+";
    else
        strF = num2str(b(i))+"+";
    end
end
strF = var+strF+'+x';

% Convert the string function into matlab function and display the result
f = str2func(strF);
output = ['Approximation: ', num2str(f(0))];
disp(output);
disp('Program finished...');
