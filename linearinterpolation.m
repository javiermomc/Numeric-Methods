%
%NAME:Karen Leduc
%Date:21/03/19
%
%This script uses Linear interpolation to calculate an estimate on a new
%"x" value.
%
% This model has to touch all the points. Se ocupa solo para grados bajos
% porque para los altos esta mal condicionado.
% INPUTS:
% - Data points
% - Value where the estimation is needed.
%
% OUTPUTS:
% - Estimation
% - Graph

%Table1
%Ask for the data
DATA = [12 2.48490665;8 2.079441542;14 2.63905733;6 1.791759469];
[n,p]=size(DATA);
    %Graph of the data points:.
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
        
        y=y0+ ((y1-y0)/(x1-x0))*(x-x0)
        plot(x,y,'dm')
    else
        disp('The value is out of range, we cannot make an estimation')
    end
    
    PRE=((2.302585-y)/2.302585)*100
  
    
    
    
    %Table2
    DATA = [11 2.397895273;8 2.079441542;12 2.48490665;9 2.197224577];
[n,p]=size(DATA);

    %Graph of the data points:.
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
        
        y=y0+ ((y1-y0)/(x1-x0))*(x-x0)
        plot(x,y,'dm')
    else
        disp('The value is out of range, we cannot make an estimation')
    end
    
    PRE=((2.302585-y)/2.302585)*100
