
clear,clc
close all
%% load
in_path1='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
o_path='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
load([in_path1,'DySdata.mat'])
N=[1.2 1.2 1.7 1.05 1.31 1.28 2.3 1.45];
% sp1=1:8;
for i =3% 1:8
 data_text=DySdata{i};
date=data_text(4:end,1);
data=cell2mat(data_text(4:end,2:end));
Eo=data(100:208,3);
RH=data(100:208,16)*10^(-2);
Ta=data(100:208,24);
Ts=data(100:208,26);
U=data(100:208,18);
ea=data(100:208,20);
P=data(100:208,22);
ws=1;
% RIC=data(:,end)/100;
% es=data(:,21);
 es=0.6105.*exp((17.27*Ts)./(Ts+237.7));
% de=ws.*es-ea;
% de=data(:,34);
% a=data(:,15);
% us=data(:,13);

% es=exp(9.096936*(1-273.15./(273.15+Ts))-3.56654*log(273.15./(273.15+Ts))+0.87682*(1-273.15./(273.15+Ts))+0.78614);

qs=0.622.*es./P;
qa=RH.*qs;
de=qs-qa;
% g=9.8;


%% 函数拟合
y=Eo;
ra=(1.293.*(273.15./(273.15+Ta)).*(P/101.325));
% rw=1.011*10^(3);
ri=905;
Ce=1.6*10^(-3);

Ea=2.15*((ra.*Ce.*de.*U*10^(3))./ri)*3600*24;

Roo=Eo-Ea;
RMSE_AD(i,1)=(sum((Roo).^2,1)/length(Eo)).^(0.5);
% Roo(Roo>mean(Roo)+2*std(Roo) | Roo<mean(Roo)-2*std(Roo))=nan;
Eo(Ea<0)=nan;
Ea(Ea<0)=nan;
% Eo(isnan(Roo))=nan;
% Ea(isnan(Roo))=nan;
SenX=[Eo,Ea];
[m,b] = TheilSen(SenX);
K_AD(i)=m; B_AD(i)=b;
ya=m.*Eo+b;
Rs_AD(i,1)=abs(1-(nansum((ya-Eo).^2,1)/nansum((nanmean(Eo,1)-Eo).^2,1)));
Ead{i,1}=Eo;
Ead{i,2}=Ea;
Ead{i,3}=ya;
% H=figure(i);
% subplot(2,1,1)
% plot(Eo,Ea,'ro')
% hold on
% plot(Eo,ya,'b-')
% hold on
% plot(Eo,Eo,'k-')
% subplot(2,1,2)
% plot(Eo,'r-')
% hold on 
% plot(Ea,'b-')
% % 创建 textbox
% annotation(H,'textbox',...
%     [0.149928571428571 0.832857141812648 0.354285722306797 0.0676190486635481],...
%     'String',['y = ', num2str(m),'*x + ',num2str(b)],...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial');
% annotation(H,'textbox',...
%     [0.135642857142856 0.377619046574556 0.261428577235767 0.0676190486635481],...
%     'String',['RMSE = ', num2str(RMSE_AD(i,1))],...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial');
% annotation(H,'textbox',...
%   [0.215642857142855 0.790952379907897 0.261428577235766 0.0676190486635481],...
%     'String',['R^2 = ', num2str(Rs_AD(i,1))],...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial');
Ea_sy=accsum(Ea,1);
Eo_sy=accsum(Eo,1);
plot(Ea_sy)
hold on
plot(Eo_sy)
title('Cumsum of ET in IC of 2014')
corr(Ea_sy',Eo_sy')
end
save([o_path,'ADmodel_output.mat'],'Ead','K_AD','B_AD','RMSE_AD','Rs_AD');







