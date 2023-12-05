function [Y,R,S,P]=linear_R(x,y,a)
%%% This function is for simple linear regression
%%% x,y are the input data, Y is data after  regression, R is correlation index
B=polyfit(x,y,a);
S=poly2str(B,'x');
Y=polyval(B,x);
[R,P]=corr(x,y);
end