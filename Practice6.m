% Script for Practice 6
% Authors: Karen Leduc, Edgar Yañez and Javier Mondragon
% ID: A01364986, A01368348, A01365137

clc;
clear;

disp('Practice 6.');
disp('Authors: Karen Leduc, Edgar Yañez and Javier Mondragon');
disp('ID: A01364986, A01368348, A01365137');

disp('Exercise 1.');
 integralPractice('sin(x).*cos(x)./(1+sin(x)).^(1/2)', 0, 2);
 trapezoid('sin(x).*cos(x)./(1+sin(x)).^(1/2)', 0, 2, 1);
 trapezoid('sin(x).*cos(x)./(1+sin(x)).^(1/2)', 0, 2, 56);
 simpson13('sin(x).*cos(x)./(1+sin(x)).^(1/2)', 0, 2, 4);
 simpson38('sin(x).*cos(x)./(1+sin(x)).^(1/2)', 0, 2);

disp('Exercise 2.');
trapezoid2(10);
trapezoid2(5);
simpson13_2();
ex3();

function integralPractice(strF, a, b)

    figure;
    strF = strcat('@(x) ', strF);
    f = str2func(strF);

    real = integral(f, a, b);
    o = ['Integral: ', num2str(real)];
    disp(o);
end
function trapezoid(strF, a, b, n)
    d = ['Trapezoid function: '];
    disp(d);
    figure;
    strF = strcat('@(x) ', strF);
    f = str2func(strF);
    
    % Initialize values

    I = zeros(n, 1);
    base = (b-a)/n;

    x = a:base:b;
    y = f(x);

    % Obtain the areas

    for i = 1:n
        averageHeight = (y(i)+y(i+1))/2;
        I(i) = base*averageHeight;
        plot([x(i+1), x(i+1)], [0, y(i+1)], 'g');
        hold on;

        plot([x(i), x(i+1)], [y(i), y(i+1)], 'g');
        hold on;
    end

    % Calculate the area and the error
    area = sum(I);
    real = integral(f, a, b);
    APRE = abs((real-area)./real).*100;

    % Print results
    d = ['Area: ', num2str(abs(area))];
    disp(d);

    d = ['APRE: ', num2str(APRE)];
    disp(d);

    % Graph results
    x = linspace(a,b);
    y = f(x);
    plot(x, y);
end
function simpson13(strF, a, b, n)
    d = ['Simpson 1/3:'];
    disp(d)

    figure;
    strF = strcat('@(x) ', strF);
    f = str2func(strF);

    % Initialize values

    I = zeros(n, 1);
    base = (b-a)/n;
    h = base/2;

    x = a:h:b;
    y = f(x);

    plot([a, a], [0, y(1)], 'g');
    hold on;

    xPlot = linspace(a, b);
    yPlot = f(xPlot);
    plot(xPlot, yPlot);
    hold on;

    for i = 1:n
        aveHeight = (y(i*2-1) + 4*y(i*2) + y(i*2+1))/6;
        I(i) = base*aveHeight;

        plot([x(i*2+1), x(i*2+1)], [0, y(i*2+1)], 'g');
        hold on;

        % LaGrange
        DATA = [x(i*2-1), y(i*2-1); x(i*2), y(i*2); x(i*2+1), y(i*2+1)];
        x1 = linspace(x(i*2-1), x(i*2+1));
        y1 = zeros(size(x1));
        for k = 1:100
            L = ones(3,1);
            for q=1:3
                for j=1:3
                    if q~=j
                        L(q)=((x1(k) - DATA(j,1))/(DATA(q,1) - DATA(j,1)))*L(q);
                    end
                end
            end
            y1(k) = sum(L.*DATA(:,2));
        end
        plot(x1,y1, 'm');
        hold on;
    end

    area = sum(I);
    real = integral(f, a, b);
    APRE = abs((real-area)/real)*100;
    
    o = ['Area: ', num2str(area)];
    disp(o);
    o = ['APRE: ', num2str(APRE)];
    disp(o);
end
function simpson38(strF, a, b)
    strF = strcat('@(x) ', strF);
    f = str2func(strF);
    %Graph the function:
    figure;
    x1=linspace(a,b);
    y1=f(x1);
    plot(x1,y1)
    hold on
    % Area using ONE application of Simpson 3/8 rule:
    Area = (b-a)* (f(a)+ 3*f((2*a+b)/3) + 3*f((a+2*b)/3)+ f(b))/8;

    real = integral(f,a,b);
    APRE = abs((real-Area)/real)*100;
    
    o = ['Area: ', num2str(Area)];
    disp(o);
    o = ['APRE: ', num2str(APRE)];
    disp(o);
end
function trapezoid2(n)
    d = ['Trapezoid function: '];
    disp(d);
    figure;
    a = 0;
    b = 20;
    
    % Initialize values

    I = zeros(n, 1);
    base = (b-a)/n;

    x = a:base:b;
    if n==10
        y = [0; 1.8; 2; 4; 4; 6; 4; 3.6; 3.4; 2.8; 0];
    end
    if n==5
        y = [0; 2; 4; 4; 3.4; 0];
    end
    % Obtain the areas

    for i = 1:n
        averageHeight = (y(i)+y(i+1))/2;
        I(i) = base*averageHeight;
        plot([x(i+1), x(i+1)], [0, y(i+1)], 'g');
        hold on;

        plot([x(i), x(i+1)], [y(i), y(i+1)], 'g');
        hold on;
    end

    % Calculate the area and the error
    area = sum(I);
%     real = integral(f, a, b);
%     APRE = abs((real-area)./real).*100;

    % Print results
    d = ['Area: ', num2str(abs(area))];
    disp(d);

%     d = ['APRE: ', num2str(APRE)];
%     disp(d);

    % Graph results
    plot(x, y);
end
function simpson13_2()

    o = ['Simpson 1/3: '];
    disp(o);

    figure;
    area0 = (4-0).*(0+4*1.8+2)./6;
    area1 = (8-4).*(2+4*4+4)./6;
    area2 = (12-8).*(4+4*6+4)./6;
    area3 = (16-12).*(4+4*3.6+3.4)./6;
    area4 = (20-16).*(3.4+4*2.8+0)./6;
    areaTotal = area0+area1+area2+area3+area4;
    
    o = ['Area: ', num2str(areaTotal)];
    disp(o);
    
    plot(area0:area4)
    hold on
end
function ex3()
    figure;
    cadena = '@(x)0.2+25*x-200*x.^2+675*x.^3-900*x.^4+400*x.^5';
    fun = str2func(cadena);

    %Trapezoidal: 
    a = 0;
    b = .12;

    %Estimation using one trapezoid:
    %Area1 = (b-a)*(fun(a)+fun(b))/2;

    %Number of trapezoids:

    n = 1;
    I = zeros(n,1);
    base = (b-a)/n;


    %Get the basepints:
    x = linspace(a,b,n+1); 
    y = fun(x);

    %Graph the first wall:
    plot([a a],[0 y(1)],'g')
    hold on

    for i = 1:n 
        aveHeight = (y(i) + y(i+1))/2;
        I(i) = base*aveHeight;


        %Graph the right wall: 
        plot([x(i+1) x(i+1)],[0 y(i+1)],'g')
        hold on 

       plot([x(i) x(i+1)],[y(i) y(i+1)],'g')
        hold on

    end

    Area1 = sum(I);


    %Simpson 1/3
    a= 0.12;
    b= 0.32;

    %Graph the function
    x1=linspace(a,b);
    y1=fun(x1);
    plot(x1,y1)
    hold on

    %Area using one 
    %Area3=(b-a)*(fun(a)+4*fun((a+b)/2)+fun(b))/6

    %Area using multiple applications

    n1 = 1;
    I=zeros(n1,1);
    Area=sum(I);
    base = (b-a)/n1;
    h= base/2;

    %Base points:
    x= a:h:b;

    %Heigths
    y=fun(x);

    %Graph for the first wall
    plot([a a],[0 y(1)],'r')
    hold on

    for i=1:n1

       aveHeight = (y(2*i-1)+4*y(2*i)+y(2*i+1))/6;
       I(i)=base * aveHeight ;

       %Graph of the central wall
       plot([x(2*i) x(2*i)],[0 y(2*i)],'y--')
       hold on

       %Graph of the right wall
       plot([x(2*i+1) x(2*i+1)],[0 y(2*i+1)],'r')
       hold on

       %Graph of the roof:
       DATA = [x(2*i-1) y(2*i-1); x(2*i) y(2*i) ;x(2*i+1) y(2*i+1)];
        x2=linspace(x(2*i-1), x(2*i+1));
            y2=zeros(size(x2));
            for k=1:100
                L=ones(3,1);

            for q=1:3
                for j=1:3
                    if q~=j
                        L(q)=(x2(k)-DATA(j,1))/(DATA(q,1)-DATA(j,1))*L(q);
                    end
                end
            end 

            y2(k)=sum(L.*DATA(:,2));
            end


    end

    Area2=sum(I);

    %Simpson 3/8
    a= 0.32;
    b= 0.44;

    %Graph the function
    x1=linspace(a,b);
    y1=fun(x1);
    plot(x1,y1)
    hold on

    %Area using one 
    Area3 =(b-a)*(fun(a)+3*fun((2*a+b)/3)+3*fun((a+2*b)/3)+fun(b))/8;

    %Real=integral(fun,a,b)
    %Error=abs((Real-Area)/Real)*100

    %Simpson 1/3
    a= .44;
    b= .64;

    %Graph the function
    x1=linspace(a,b);
    y1=fun(x1);
    plot(x1,y1)
    hold on

    %Area using one 
    Area4=(b-a)*(fun(a)+3*fun((2*a+b)/3)+3*fun((a+2*b)/3)+fun(b))/8;

    %Real=integral(fun,a,b)
    %Error=abs((Real-Area)/Real)*100

    %Trapezoidal
    a = .64;
    b = .70;

    %Estimation using one trapezoid:
    %Area6 = (b-a)*(fun(a)+fun(b))/2

    %Number of trapezoids:
    n = 1;
    I = zeros(n,1);
    base = (b-a)/n;


    %Get the basepints:
    x = linspace(a,b,n+1); %x = linspacea:base:b
    y = fun(x);

    %Graph the first wall:
    plot([a a],[0 y(1)],'b')
    hold on

    for i = 1:n 
        aveHeight = (y(i) + y(i+1))/2;
        I(i) = base*aveHeight;


        %Graph the right wall: 
        plot([x(i+1) x(i+1)],[0 y(i+1)],'b')
        hold on 

       plot([x(i) x(i+1)],[y(i) y(i+1)],'b')
        hold on

    end

    Area5 = sum(I);
    %Real = integral(fun,a,b);
    %Error = abs((Real-Area)/Real)*100


    %Trapezoidal

    a = .70;
    b = .80;

    %Estimation using one trapezoid:
    %Area10 = (b-a)*(fun(a)+fun(b))/2

    %Number of trapezoids:
    n = 1;
    I = zeros(n,1);
    base = (b-a)/n;


    %Get the basepints:
    x = linspace(a,b,n+1); %x = linspacea:base:b
    y = fun(x);

    %Graph the first wall:
    plot([a a],[0 y(1)],'m')
    hold on

    for i = 1:n 
        aveHeight = (y(i) + y(i+1))/2;
        I(i) = base*aveHeight;


        %Graph the right wall: 
        plot([x(i+1) x(i+1)],[0 y(i+1)],'m')
        hold on 

       plot([x(i) x(i+1)],[y(i) y(i+1)],'m')
        hold on

    end

    Area6 = sum(I);


    TotalArea = Area1+Area2+Area3+Area4+Area5+Area6
    Real = integral(fun,0,.8)
    Error = abs((Real-TotalArea)/Real)*100
end

