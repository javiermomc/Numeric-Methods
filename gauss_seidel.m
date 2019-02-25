% @author Javier Mondragon
% @id A01365137
%
% This script implements Gauss-Seidel Method
% to solve a system of linear equations
%
% INPUT:
% Matrix
% Vector
% Tolerance
%
% OUTPUT:
% Solutions

% 1.1 - User matrix
A = input('Matrix = ');

% 1.2 - User vector of constants
b = input('Vector of constants = ');

% 1.3 - User tolerance
tol = input('Tolerance = ');

% 1.4 - Evaluate the inputs for correct usage

% Evaluate if the matrix determinant is different from 0
if det(A)==0
    disp('The determinant from the function is 0');
    return;
end
% Evaluate if the dimentions are correct
[m,n] = size(A);
[p,q] = size(b);
if m~=p || q~=1
    disp('Dimentions of the vector not correct');
    return;
end

% 2.1 - Create the auxiliar matrix
x = zeros(m,1);
APRE = 100*ones(m,1);
prev = x;

% 3.1 - Calculate the solutions by using the Gauss-Seidel method
while sum(APRE>tol)>0
    for i=1:m
        sumatoria=0;
        for j=1:n
            if j~=i
                sumatoria = sumatoria + A(i,j)*x(j);
            end
        end
        x(i) = (b(i) - sumatoria)/A(i,i);
        APRE(i) = abs((x(i)-prev(i))/x(i))*100;
        prev(i) = x(i);
    end
end

% 4.1 - Display the answer
disp('Answer:');
disp(x);
