
A = [-10, 10.078647; -8, 6.553114; -6, 5.834336; -4, 4.334511; -2, 0.723695; 0, 0; 2, 3.737724; 4, 3.861999; 6, 6.293255; 8, 9.541717; 10, 9.99690; 12, 11.99701];


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