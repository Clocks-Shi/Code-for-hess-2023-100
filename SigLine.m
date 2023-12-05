function [x1,yfit,fx,fy,p,r,Pv,R,P]=SigLine(x,y,a)
%%% This function is to get the 95% significance region for a  simple linear fitting
%%% x,y are the input data, a is the interval to adjust x to x1
%%% yfit is data after regression by adjustive x1, fx,fy are the input for
%%% fill region
aa=isnan(y);
[m1,n1]=find(aa==0);
x=x(m1);y=y(m1);
[p,s] = polyfit(x,y,1);
m1=length(x);
X=[ones(m1,1),x];
[B,Bint,E,Eint,Stats]=regress(y,X);
r=Stats(1);  Pv=Stats(3);
x1=x;
[yfit,dy] = polyconf(p,x1,s,'predopt','curve');
y_up=yfit+dy;
y_low=yfit-dy;
[Y1,R,S,P]=linear_R(x1,y_up,1);
[Y2,R,S,P]=linear_R(x1,y_low,1);
fx=[x1;flipud(x1)];
fy=[Y1;flipud(Y2)];
end