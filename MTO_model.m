clear,clc
close all
%% load
in_path1='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
o_path='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
load([in_path1,'DySdata.mat'])
% N=[0.128 0.118 1.7 1.05 1.31 1.28 2.3 1.45];
% sp1=1:8;
for i = 4%1:8
 data_text=DySdata{i};
date=data_text(4:end,1);
data=cell2mat(data_text(4:end,2:end));
Eo=data(1:92,3);
RH=data(1:92,16);
Ta=data(1:92,24);
Ts=data(1:92,26);
U=data(1:92,18);
ea=data(1:92,20)*10;
ws=0.93;
% eb=data(:,21);
eb=6.105.*exp((17.27*Ts)./(Ts+237.7));
de=ws.*eb-ea;
% de=data(:,34);
a=data(:,15);
%% 函数拟合
y=Eo;
X=U.*de;
% X1=[U(1:1096) a(1:1096) de(1:1096)];
% options = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','TolX',1e-1);
% [beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(X,y,@CMO,0.2,options);
% N=0.001:0.00001:1;
% Ea=N.*X1;
% RMSE=(sum((y-Ea).^2,1)).^(0.5);
% Q=(sum((y-Ea).^2,1));
% Rn=1-(Q/sum(y.^2)).^(0.5);
%  [A,B]=min(RMSE);
%  Ni=N(A);
% R=(sum((Ea-mean(Ea,1)).^2,1))./(sum((y-mean(y,1)).^2,1));
%%
% options = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','TolX',1e-1);
% lb = [];
% ub = [];
% [N,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(@FMTO,0.1,X,y,lb,ub,options);
% MT(i,1)=N;
N=0:0.001:0.3;
for j = 1:length(N)
Eaj=N(j).*X;
Eoj=Eo;
Eoj(Eaj<0)=nan;
Eaj(Eaj<0)=nan;
Ea_syj=accsum(Eaj,1);
Eo_syj=accsum(Eoj,1);
Roo=Eo_syj-Ea_syj;
RMSEj(j,1)=(sum((Roo).^2,2)/length(Eo_syj)).^(0.5);
end
[rmse,a]=min(RMSEj);
Ea=N(a).*X;
SN(i,1)=N(a);
RMSE(i,1)=rmse;
X=[ones(size(Eo,1),1),Eo];
[~,~,~,~,sts]=regress(Ea,X);
% Roo(Roo>mean(Roo)+2*std(Roo) | Roo<mean(Roo)-2*std(Roo))=nan;
Eo(Ea<0)=nan;
Ea(Ea<0)=nan;
% Eo(isnan(Roo))=nan;
% Ea(isnan(Roo))=nan;
SenX=[Eo,Ea];
[m,b] = TheilSen(SenX);
K(i)=m; B(i)=b;
ya=m.*Eo+b;
% r=corr(Ea,Eo);
% Rs(i,1)=r^2;
Rs(i,1)=1-((nansum((ya-Eo).^2,1)/nansum((Eo-nanmean(Eo,1)).^2,1)));
Emt{i,1}=Eo;
Emt{i,2}=Ea;
Emt{i,3}=ya;
Ea_sy=accsum(Ea,1);
Eo_sy=accsum(Eo,1);
%%
% H=figure(i);
% subplot(3,1,1)
% plot(Eo,Ea,'ro')
% hold on
% plot(Eo,ya,'b-')
% hold on
% plot(Eo,Eo,'k-')
% % title('S=0.90')
% subplot(3,1,2)
% plot(Eo,'r-')
% hold on 
% plot(Ea,'b-')
% subplot(3,1,3)
% plot(Ea_sy)
% hold on
% plot(Eo_sy)
% corr(Ea_sy',Eo_sy')^2
% % 创建 textbox
% annotation(H,'textbox',...
%     [0.149928571428571 0.832857141812648 0.354285722306797 0.0676190486635481],...
%     'String',['y = ', num2str(m),'*x + ',num2str(b)],...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial');
% annotation(H,'textbox',...
%     [0.143455357142856 0.224630191458042 0.261428577235767 0.0676190486635483],...
%     'String',['RMSE = ', num2str(RMSE(i,1))],...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial');
% annotation(H,'textbox',...
%   [0.215642857142855 0.790952379907897 0.261428577235766 0.0676190486635481],...
%     'String',['R^2 = ', num2str(Rs(i,1))],...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial');
Ea_sy=accsum(Ea,1);
Eo_sy=accsum(Eo,1);
plot(Ea_sy)
hold on
plot(Eo_sy)
title('Cumsum of ET in Summer of 2014')
end
% save([o_path,'MTmodel_output.mat'],'Emt','K','B','RMSE','Rs');