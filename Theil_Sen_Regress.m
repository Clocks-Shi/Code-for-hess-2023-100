function b = Theil_Sen_Regress(x,y)
N=length(x);
Comb = combnk(1:N,2);
deltay=diff(y(Comb),1,2);
deltax=diff(x(Comb),1,2);
theil=deltay./deltax;
b=median(theil);
end
