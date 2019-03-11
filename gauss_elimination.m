% Method implementents gauss elimination
% Javier Mondragon Martin del Campo
% @id A01365137
% @author Nickolas Cheilakos

A=input ('Enter the equations in matrix [A]');
b=input ('Enter the right hand side column vector [b]: '); 
% A=[2.25 -1 0 0; -1 2.25 -1 0; 0 -1 2.25 -1; 0 0 -2 2.25];
% b=[1 0 0 0]';
n=length(b); %  Size of input matrix i.e. Total number of unknowns
tic;
%---------------Creating an Upper Triangular Matrix--------------------% 
ss=0;
for j=1:n-1  % Forward Elimination 
    if A(j,j)==0 % Pivoting Operation
        m=j;
        for m=m+1:n
            if A(m,j)==0
                continue 
            end
            break
        end
        B=A(j,:); 
        C=b(j); 
        A(j,:)= A(m,:); 
        b(j)=b(m);
        A(m,:)= B; 
        b(m)=C;
    end
    for i=1+ss:n-1 % Elimination
        fac = A(i+1,j)/A(j,j);
        A(i+1,:) = A(i+1,:) - fac*A(j,:);
        b(i+1) = b(i+1) - fac*b(j);
    end
    ss=ss+1;
end 

%---------------Backward Substitution-------------------%

x(n)=b(n)/A(n,n);
for i=n-1:-1:1
    coefsum=0;
    for j=i+1:n 
        coefsum=coefsum+A(i,j)*x(j);
    end
    x(i)=(1/A(i,i))*(b(i)-coefsum);
end

%----------------Displaying Output----------------------%
toc
disp('Upper Triangular Form of Matrix [A] =');
disp(A)
disp('Solution of the system of equations is :');
disp(x')
