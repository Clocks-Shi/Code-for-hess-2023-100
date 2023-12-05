function [days]=Dtrans(year,month,day)
LM=[0 31 29 31 30 31 30 31 31 30 31 30 31];
PM=[0 31 28 31 30 31 30 31 31 30 31 30 31];
if mod(year,4)==0
    days=sum(LM(1:month))+day;
else
    days=sum(PM(1:month))+day;
end
end