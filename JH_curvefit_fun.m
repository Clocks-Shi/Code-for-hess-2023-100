function [feval]=JH_curvefit_fun(x,Data)
%nonlinear curve fit function:c(1)*exp(c(2)*x)+c(3)*exp(c(4)*x)+c(5)
feval=x(1).*(x(2).*Data(:,1)+x(3)).*(Data(:,2)).*(Data(:,3));
% feval=x(4).*(x(1).*Data(:,1)+x(2)).*(Data(:,2).*x(:,3)).*(Data(:,3));
end