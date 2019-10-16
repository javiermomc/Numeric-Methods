% Script for Practice 5
% Authors: Karen Leduc, Edgar Yañez and Javier Mondragon
% ID: A01364986, A01368348, A01365137

clc;
clear;

disp('Practice 5.');
disp('Authors: Karen Leduc, Edgar Yañez and Javier Mondragon');
disp('ID: A01364986, A01368348, A01365137');

disp('Exercise 1.');
linearInterpolation([12 2.48490665;8 2.079441542;14 2.63905733;6 1.791759469]);
linearInterpolation([11 2.397895273;8 2.079441542;12 2.48490665;9 2.197224577]);

disp('Exercise 2.');
interpolarNewton([-10, 10.078647; -8, 6.553114; -6, 5.834336; -4, 4.334511; -2, 0.723695; 0, 0; 2, 3.737724; 4, 3.861999; 6, 6.293255; 8, 9.541717; 10, 9.99690; 12, 11.99701]);
interpolarNewton([6, 6.293255; 8, 9.541717; 10, 9.99690; 12, 11.99701]);

disp('Exercise 3.');

lagrangef([1, 800; 3, 2310; 5, 3090; 7, 3940; 13, 4755], 10);
lagrangef([3, 2310; 5, 3090; 7, 3940; 13, 4755], 10);
lagrangef([5, 3090; 7, 3940; 13, 4755], 10);
lagrangef([7, 3940; 13, 4755], 10);

disp('Excercise 4.');
lagrangef2([0.8, 2; 0.9, 3; 0.941176, 4; 0.961538, 5], 0.85);

% Lagrange function
function lagrangef(DATA, x)
    [n,p] = size(DATA);
    if p~=2
        disp('The matrix does not have two columns')
        return
    end
    if(x < min(DATA(:,1)) || x > max(DATA(:,1)))
        disp('Sorry, we cannot make an extrapolation.')
        return
    end
    %Graph of the data points
    figure
    plot(DATA(:,1), DATA(:,2), 'o')
    hold on

    %Calculate the estimation
    L = ones(n,1);

    for i=1:n
        for j=1:n
            if i~=j
                L(i)=((x - DATA(j,1))/(DATA(i,1) - DATA(j,1)))*L(i);
            end
        end
    end
    y = sum(L.*DATA(:,2));
    plot(x,y, '*r')

    %Graph of the polynomial
    x1 = linspace(min(DATA(:,1)), max(DATA(:,1)));
    y1 = zeros(size(x1));
    for k = 1:100
        L = ones(n,1);

    for i=1:n
        for j=1:n
            if i~=j
                L(i)=((x1(k) - DATA(j,1))/(DATA(i,1) - DATA(j,1)))*L(i);
            end
        end
    end
    y1(k) = sum(L.*DATA(:,2));
    end
    plot(x1,y1);
    d = ['Value at ', num2str(x), ' is ', num2str(y)];
    disp(d)
end

% Linear interpolation function
function linearInterpolation(DATA)
    %Graph of the data points:.
    figure
    plot(DATA(:,1), DATA(:,2),'ob')
    hold on
   
    %Graph of the linear interpolation
    DATA=sortrows(DATA);
    plot(DATA(:,1), DATA(:,2))
    hold on
    
    x=10;
    
    if( x> min(DATA(:,1)) && x< max(DATA(:,1)) )
        pos= sum(x>DATA(:,1));
        x0=DATA(pos,1);
        y0=DATA(pos,2);
        x1=DATA(pos+1,1);
        y1=DATA(pos+1,2);
        
        y = y0+ ((y1-y0)/(x1-x0))*(x-x0);
        plot(x,y,'dm')
    else
        disp('The value is out of range, we cannot make an estimation')
    end
    
    PRE = ((2.302585-y)/2.302585)*100;
    
    d = ['The y is ', num2str(y)];
    disp(d);
    
    d = ['The PRE is ', num2str(PRE)];
    disp(d);
end

% Interpolar Newton function
function interpolarNewton(DATA)
    A = DATA;
    n=numel(A(:,1));
    val=7;

    if (val<min(A(:,1)) || val>max(A(:,1)))
        disp(' ERROR: Value out of range, we cannot make an extrapolation!!')
        return
    else

        %Matrix of finite divided differences
        DDF = zeros(n,n);

        %First column --- Values of the Yi's
        DDF(:,1) = A(:,2);

        %Columns 2 to n:
        for j = 2:n
          for i = 1:n-(j-1)
            DDF(i,j) = (DDF(i+1,j-1)-DDF(i,j-1))/(A(i+j-1,1)-A(i,1));
          end
        end
        %The first row of the matrix will contain the Newton coefficients of
        %the polynomial
        disp(' The "bi´s" coefficients of the Newton´s Interpolation Polynomial are:')
        bi = DDF(1,:)'

          %Calculating the estimation:
          T=ones(n,n);
          T(1,:)= DDF(1,:);
          for j=2:n
              for i=2:n
                if j>=i
                  T(i,j) = val - A(i-1,1);
                end
              end
          end 
          Yaprox = sum(prod(T));


        %Graph of the points
        figure
        plot(A(:,1),A(:,2),'or')
        hold on

        %Graph of the estimation:
        plot(val,Yaprox,'*k')
        hold on

        %Graph of the polynomial:
        %(This is an inefficient way to plot the polynomial, but I think it makes the process clear)
        x1=linspace(min(A(:,1)),max(A(:,1)));
        y1=zeros(100,1);

        for k=1:100
          T=ones(n,n);
          T(1,:)= DDF(1,:);
          for j=2:n
              for i=2:n
                if j>=i
                  T(i,j) = x1(k) - A(i-1,1);
                end
              end
           end 
        y1(k)=sum(prod(T(:,:)));
        end
        plot(x1,y1,'b')
        title('Newton´s Polynomial')
        hold on

        %Graph of the real function:
        y2 = sin(x1) + sqrt((x1.^3)./(x1-1));
        plot(x1,y2,'g')
        hold on

        %Calculation of the PRE:
        real = sin(val) + sqrt(val^3/(val-1));
        PRE = abs((real - Yaprox)/real)*100;

        legend('Data','Estimation','Newton','Real',"location",'southeast')
        hold off

        d = ['The y aproximation is ', num2str(Yaprox)];
        disp(d);
        d = ['The PRE is ', num2str(PRE)];
        disp(d);
    end
end

% Use only on exercise 4
function lagrangef2(DATA, x)
    [n,p] = size(DATA);
    if p~=2
        disp('The matrix does not have two columns')
        return
    end
    if(x < min(DATA(:,1)) || x > max(DATA(:,1)))
        disp('Sorry, we cannot make an extrapolation.')
        return
    end
    %Graph of the data points
    figure
    plot(DATA(:,1), DATA(:,2), 'o')
    hold on

    %Calculate the estimation
    L = ones(n,1);

    for i=1:n
        for j=1:n
            if i~=j
                L(i)=((x - DATA(j,1))/(DATA(i,1) - DATA(j,1)))*L(i);
            end
        end
    end
    y = sum(L.*DATA(:,2));
    plot(x,y, '*r')

    %Graph of the polynomial
    x1 = linspace(min(DATA(:,1)), max(DATA(:,1)));
    y1 = zeros(size(x1));
    for k = 1:100
        L = ones(n,1);

    for i=1:n
        for j=1:n
            if i~=j
                L(i)=((x1(k) - DATA(j,1))/(DATA(i,1) - DATA(j,1)))*L(i);
            end
        end
    end
    y1(k) = sum(L.*DATA(:,2));
    end
    plot(x1,y1);
    x2 = [0; 0.5; 0.8; 0.9; 0.941176; 0.961538];
    y2 = [0; 1; 2; 3; 4; 5];
    plot(x2, y2, 'ob');
    d = ['Value at ', num2str(x), ' is ', num2str(y)];
    disp(d)
end