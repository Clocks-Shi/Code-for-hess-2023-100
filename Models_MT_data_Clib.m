clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
in_path1='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Models\Calibration\';
load([in_path,'Sdata_ICP_Daily_2013_2018.mat']);
load([in_path,'RS_data_ICE2003_2017.mat']);
[data,~,data_text]=xlsread([in_path1,'Ta_Ts_QHH_RS.xlsx']);
%%
RS{1}=[TdataPH{12,1};TdataPH{12,5};TdataPH{13,1};TdataPH{13,5};TdataPH{14,1};TdataPH{14,5};TdataPH{15,1};TdataPH{15,5}];
RS{2}=[TdataPH{12,1};TdataPH{13,1};TdataPH{14,1};TdataPH{15,1}];
RS{3}=[TdataPH{12,5};TdataPH{13,5};TdataPH{14,5};TdataPH{15,5}];

OBS{1}=[Sdata_DDICP{2,1};Sdata_DDICP{2,5};Sdata_DDICP{3,1};Sdata_DDICP{3,5};Sdata_DDICP{4,1};Sdata_DDICP{4,5};Sdata_DDICP{5,1};Sdata_DDICP{5,5}];
OBS{2}=[Sdata_DDICP{2,1};Sdata_DDICP{3,1};Sdata_DDICP{4,1};Sdata_DDICP{5,1}];
OBS{3}=[Sdata_DDICP{2,5};Sdata_DDICP{3,5};Sdata_DDICP{4,5};Sdata_DDICP{5,5}];
%%
Qws=0.97;
for i = 1:3
    Rdata=RS{i};
    OBSi=OBS{i};
    Eo=OBSi(:,2);
OTa=1.013.*Rdata(:,1)+0.7067;
OTs=0.7053.*Rdata(:,8)+3.303;
ORs=0.8565*Rdata(:,4) + 34.63;
% OTa=Rdata(:,1);
% OTs=Rdata(:,8);
% ORs=Rdata(:,4);
q=Rdata(:,7);
P=Rdata(:,5)./100;
P=0.97.*P+30.72;
ea=6.105.*exp((17.27*OTa)./(OTa+237.7));
es=6.105.*exp((17.27*OTs)./(OTs+237.7));
RH=100*(P.*q)./(0.622.*ea);
RH=0.68.*RH+19.95;
RH=RH./100;
if i==3
des=es-RH.*ea; 
else
des=Qws.*es-RH.*ea; 
end
% U=0.5907*Rdata(:,6)+1.952;
U=Rdata(:,9);
U=0.60*U+0.96;
%% 函数拟合
%%% MT Ea=N.*(f(U)).*des
xData(:,1)=U;
xData(:,2)=des;
x0=[0.0045 0.2 0.03523];
[x,resnorm,residual]=lsqcurvefit(@(x,xData) MT_curvefit_fun(x,xData),x0,xData,Eo);
clear xData
Eaa=x(1).*(x(2).*(U)+x(3)).*(des);
Ea{i}=Eaa;
Eoa{i}=Eo;
Na{i}=x;
% Roo=Eo-Ea;
% RMSE_AD(i,1)=(sum((Roo).^2,1)/length(Eo)).^(0.5);
% % Roo(Roo>mean(Roo)+2*std(Roo) | Roo<mean(Roo)-2*std(Roo))=nan;
% Eo(Ea<0)=nan;
% Ea(Ea<0)=nan;
% % Eo(isnan(Roo))=nan;
% % Ea(isnan(Roo))=nan;
% SenX=[Eo,Ea];
% [m,b] = TheilSen(SenX);
% K_AD(i)=m; B_AD(i)=b;
% ya=m.*Eo+b;
% Rs_AD(i,1)=abs(1-(nansum((ya-Eo).^2,1)/nansum((nanmean(Eo,1)-Eo).^2,1)));
% Ead{i,1}=Eo;
% Ead{i,2}=Ea;
% Ead{i,3}=ya;
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
end
%%
save([o_path,'Model_MT_Calibration'],'Ea','Eoa','Na');
%%







