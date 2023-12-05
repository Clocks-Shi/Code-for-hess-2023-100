function [feval]=AD_curvefit_fun(x,Data)
%nonlinear curve fit function:c(1)*exp(c(2)*x)+c(3)*exp(c(4)*x)+c(5)
feval= x(1).*0.622.*Data(:,6).*Data(:,1).*Data(:,2).*3.6*10^6.*Data(:,3)./(Data(:,4).*Data(:,5));
end