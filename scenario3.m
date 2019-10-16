%
%NAME:Karen Leduc
%Date:04/03/19
%
%This script uses Linear regression to find the line that better fits a set
%of data points (2D).
% Scenario 1
% INPUTS:
% - Set of data points (2D)
%
%
% OUTPUTS:
% - Linear model
% - Quantification of the error
%
%Scenario 3

clc
close all

%Ask for the data
DATA = input('Give me the data points as a 2- column matrix: ');
[n,p]=size(DATA);



%System of normal equations:
%Matrix of coefficients:
A=[n sum(DATA(:,1));sum(DATA(:,1)) sum(DATA(:,1).^2)];
%Vector of constants: 
b=[sum(DATA(:,2)); sum(DATA(:,1).*DATA(:,2))];
%Solve the system:
a= A\b;

disp('The linear model that best fit the data is: ')
% [5 17; 10 24; 15 31; 20 33; 25 37; 30 37; 35 40; 40 40 ; 45 42; 50 41]
fprintf('y= %f x + %f \n', a(2),a(1))

%Graph the data points:
plot(DATA(:,1),DATA(:,2),'d')
hold on 

%Graph of the line
x= min(DATA(:,1)): max(DATA(:,1));
y=a(2)*x+a(1);
plot(x,y,'b')
hold on

title('Linear Regression')
xlabel('X axis')
ylabel('Y axis')


%Quantification of the error:

%Calculate the "y" given by the model:
DATA(:,3)= a(2)*DATA(:,1)+ a(1);

%Sum of the residuals:
Sr=sum((DATA(:,2)-DATA(:,3)).^2);

%Traditional standar deviation:
Sy=std(DATA(:,2));

%Standar error of the estimate:
Syx=sqrt(Sr/(n-2))

if Syx<Sy
    disp('The model was worth it!')
else
    disp('The model was not worth the effort ')
end

prom= mean(DATA(:,2));
St=sum((DATA(:,2)-prom).^2);

%Coefficient of determination:
r2=(St-Sr)/St;

%Coefficient of correlation:
r=sqrt(r2)

%Percentage of uncertainty explained by the model:
PUEM=r2*100

%Population growth model
 ORI=[1000000 100000 10000 1000 100 10 1; 420 550 625 800 925 1000 1100]
 figure(1)
 plot(ORI(:,1),ORI(:,2),'o')
  hold on
 
 DATA=ORI;
 %Transform the "x" values:
 DATA(:,1)=log10(ORI(:,1));
 %Transform the "y" values.
 DATA(:,2)=log10(ORI(:,2));
 DATA
 
%Graph of the transformed data:
figure (2)
plot(DATA(:,1),DATA(:,2),'o')
hold on

[n,q]=size(DATA);
%Systems of NORMAL EQUATIONS:
%Define the matrix of coefficients:
A=[n sum(DATA(:,1)):sum(DATA(:,1)) sum(DATA(:,1).^2)];
%Define vector of constants:
b=[sum(DATA(:,2));sum(DATA(:,1).*DATA(:,2))];

%Solve the system:
a=A\b

fprintf('The linear regression model for yout transfromed data is...')

%Graph the line:
x1=linespace(0,1);
y1=a(1)+ a(2)*x1;
plot(x1,y1,'r')
hold on
xlabel('log(x)')
ylabel('log(y)')
title('Linealization')

%Graph the power model:
figure(1)
x2=linespace(0,6);
y2=10^a(1)*x2.^a(2);
plot(x2,y2,'r')
hold on
xlabel('x')
ylabel('y ')
title('Original data and power model')

%Quantification of the error:

%Calculate the "y" given by the model:
DATA(:,3)= a(2)*DATA(:,1)+ a(1);

%Sum of the residuals:
Sr=sum((DATA(:,2)-DATA(:,3)).^2);

%Traditional standar deviation:
Sy=std(DATA(:,2));

%Standar error of the estimate:
Syx=sqrt(Sr/(n-2))

if Syx<Sy
    disp('The model was worth it!')
else
    disp('The model was not worth the effort ')
end

prom= mean(DATA(:,2));
St=sum((DATA(:,2)-prom).^2);
   
%Coefficient of determination:
r2=(St-Sr)/St;

%Coefficient of correlation:
r=sqrt(r2)

%Percentage of uncertainty explained by the model:
PUEM=r2*100


%Calculate a prediction:
Q=input('Do you want to make a prediction (Y/N) ','s')
if Q=='Y'
    X= input('Give me the value where you need the prediction : ')
    Y= a(2)*X +a(1)
    plot( X, Y,'*m')
 
else
    disp('Thank you, have a nice day! ')
end

