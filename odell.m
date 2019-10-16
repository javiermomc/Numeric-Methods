%This scripts implements differential Runge-Kutta methods
%INPUTS
% -- ODE
% -- Interval
% -- Initial condition
%
%

close all
clear all
clc



%Ask the user for the inputs
cadena= input('Give me the ODE: ','s');
ode=str2func(cadena);

interval=input('Give me the interval (as a vector): ');
condition=input('Give me the initial condition (as a vector): ');

%Set step size:
h=0.5;

%Values for the "x":
a=interval(1);
b=interval(2);
x=a:h:b;
x=x';

%--------EULER METHOD----------
yEuler=zeros(size(x));
yEuler(1)=condition(2);

for i= 1:length(x)-1
    slope= ode(x(i),yEuler(i));
    yEuler(i+1)=yEuler(i)+slope*h;
end

%------HEUN METHOD------------

yHeun=zeros(size(x));
yHeun(1)=condition(2);

for i= 1:length(x)-1
    k1=ode(x(i),yHeun(i));
    k2=ode(x(i)+h,yHeun(i)+k1*h);
    slope=(k1 +k2)/2;
    yHeun(i+1)=yHeun(i)+slope*h;
end

%------MIDPOINT METHOD------------

yMid=zeros(size(x));
yMid(1)=condition(2);

for i= 1:length(x)-1
    k1=ode(x(i),yMid(i));
    k2=ode(x(i)+h/2,yMid(i)+((k1*h)/2));
    slope= k2;
    yMid(i+1)=yMid(i)+slope*h;
end

%------RALSTON METHOD------------

yRals=zeros(size(x));
yRals(1)=condition(2);

for i= 1:length(x)-1
    k1= ode(x(i),yRals(i));
    k2=ode(x(i)+3*h/4, yRals(i)+((3*(k1*h))/4));
    slope= (k1 +2*k2)/3;
    yRals(i+1)=yRals(i)+slope*h;
end

%------RALSTON METHOD------------

yBut=zeros(size(x));
yBut(1)=condition(2);

for i= 1:length(x)-1
    k1= ode(x(i),yBut(i));
    k2=ode(x(i)+1*h/4, yBut(i)+(k1*h)/4);
    k3=ode(x(i)+1*h/4, yBut(i)+((k1*h)/8)+(k2*h)/8);
    k4=ode(x(i)+1*h/2, yBut(i)-((k2*h)/2)+k3*h);
    k5=ode(x(i)+3*h/4, yBut(i)+((3*(k1*h))/16)+((9*(k4*h))/16));
    k6=ode(x(i)+h, yBut(i)-((3*(k1*h))/7)+((2*(k2*h))/7)+((12*(k3*h))/7)-((12*(k4*h))/7)+((8*(k5*h))/7));
    slope=(7*k1+32*k3+12*k4+32*k5+7*k6)/90;
    yBut(i+1)=yBut(i)+slope*h;
end

%Analytic solution:
fun=@(x,y) x.^2.*y-1.1*y;
yReal=fun(x);

%Graphic
plot(x,yReal,'r',x,yEuler,'b',x,yHeun, 'g',x,yMid,'c',x,yRals,'m',x,yBut,'y')
title('Runge-Kutta methods')
legend('Real','Euler','Heun','Midponit','Ralston','Butcher','Location','North')

%Display the results:
disp('        x      yReal    yEuler    yHeun    yMidpoint  yRalston   yButcher ')
disp([x yReal yEuler yHeun yMid yRals yBut])


