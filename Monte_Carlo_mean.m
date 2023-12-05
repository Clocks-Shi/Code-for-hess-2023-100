function [xmean,xm05,xm95]=Monte_Carlo_mean(x,a)
%%%% x is a vec
%%% a is the times for Monte Carlo
xmean=nanmean(x);
L=length(x);
yd=nan(a,1);
for i = 1:a
    y=randsample(x,L,'true');
    yd(i,1)=nanmean(y)-xmean;  
end
xm95 = prctile(yd,95);
xm05 = prctile(yd,5);
end
%%%% x=rand(30,1);
%%%% [xmean,xm05,xm95]=Monte_Carlo_mean(x,10000)