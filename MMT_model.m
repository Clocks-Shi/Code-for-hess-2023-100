clear,clc
close all
%% load
in_path1='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
o_path='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
load([in_path1,'DySdata.mat'])
for i =3% 1:8
data_text=DySdata{i};
date=data_text(4:end,1);
data=cell2mat(data_text(4:end,2:end));
Eo=data(:,3);
RH=data(:,16);
Ta=data(:,24);
Ts=data(:,26);
U=data(:,18);
ea=data(:,20)*10;
ws=0.90; 
es=0.6105.*exp((17.27*Ts)./(Ts+237.7));
P=data(:,22);
de=ws.*es-ea;
RIC=data(:,end)./100;
a=data(:,15);
qs=0.622.*es./P;
qa=RH*10^(-2).*qs;
dei=qs-qa;
ra=(1.293.*(273.15./(273.15+Ta)).*(P/101.325));
ri=905;
Ce=2.5*10^(-3);

Y=(1-a).*((ra.*Ce.*dei.*U*10^(3))./ri)*3600*24;
X=U.*de; 
y=Eo;
e=ones(size(Y,1),1);
x=[e,Y,X];
[b,bint,r,rint,stats]=regress(y,x,0.05);
rcoplot(r,rint);


% options = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','TolX',1e-1);
% lb = [];
% ub = [];
% [N,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(@FMTO,0.1,X,y,lb,ub,options);
% Ea=(1-RIC).*N.*X+Y;
    
end