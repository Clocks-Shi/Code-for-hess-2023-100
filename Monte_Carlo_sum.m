function [xsum,xs05,xs95]=Monte_Carlo_sum(x,a)
%%%% x is a vec
%%% a is the times for Monte Carlo
xsum=nansum(x);
L=length(x);
yd=nan(a,1);
for i = 1:a
    y=randsample(x,L,'true');
    yd(i,1)=nansum(y)-xsum;  
end
xs95 = prctile(yd,95);
xs05 = prctile(yd,5);
end
%%%% x=rand(30,1);
%%%% [xsum,xs05,xs95]=Monte_Carlo_sum(x,1000);