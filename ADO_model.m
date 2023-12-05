
clear,clc
close all
%% load
in_path1='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
o_path='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
load([in_path1,'EEMD_DySdata.mat'])
% sp1=1:8;
for i =1% 1:8
 data_text=DySdata{i};
date=data_text(4:end,1);
data=cell2mat(data_text(4:end,2:end));
Eo=data(:,3);
RH=data(:,16);
Ta=data(:,24);
Ts=data(:,26);
U=data(:,18);
ea=data(:,20)*10;
ws=1;
% eb=data(:,21);
eb=6.105.*exp((17.27*Ts)./(Ts+237.7));
de=ws.*eb-ea;
% de=data(:,34);
a=data(:,15);
us=data(:,13);
P=data(:,22)*10;
g=9.8;
%% 函数拟合
y=Eo;
ra=1.293.*(273.15./(273.15+Ta)).*(P/1013.25);
rw=1.011*10^(3);
v0=1.5*10^(-5);
v=v0.*((Ta+273.15)/(20+273.15)).*1.5.*((20+273.15+110.4)./(Ta+273.15+110.4));                       % 萨特兰公式计算
Zom=us.^2./(81*g);
Zov=7.4.*Zom.*exp(-2.25.*(us./v).^(0.25));
Ce=0.41^2./(log(12.5./Zov).*log(12.5./Zom));
Ea=0.622.*Ce.*ra.*U.*3.6*10^6*10^2.*de./(rw.*P);
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
Rs_AD(i,1)=1-((nansum((ya-Eo).^2,1)/nansum((Eo-nanmean(Eo,1)).^2,1)));
Ead{i,1}=Eo;
Ead{i,2}=Ea;
Ead{i,3}=ya;
H=figure(i);
subplot(2,1,1)
plot(Eo,Ea,'ro')
hold on
plot(Eo,ya,'b-')
hold on
plot(Eo,Eo,'k-')
subplot(2,1,2)
plot(Eo,'r-')
hold on 
plot(Ea,'b-')
% 创建 textbox
annotation(H,'textbox',...
    [0.149928571428571 0.832857141812648 0.354285722306797 0.0676190486635481],...
    'String',['y = ', num2str(m),'*x + ',num2str(b)],...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial');
annotation(H,'textbox',...
    [0.135642857142856 0.377619046574556 0.261428577235767 0.0676190486635481],...
    'String',['RMSE = ', num2str(RMSE_AD(i,1))],...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial');
annotation(H,'textbox',...
  [0.215642857142855 0.790952379907897 0.261428577235766 0.0676190486635481],...
    'String',['R^2 = ', num2str(Rs_AD(i,1))],...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial');
end
save([o_path,'ADmodel_output.mat'],'Ead','K_AD','B_AD','RMSE_AD','Rs_AD');







