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
U=Rdata(:,9);
U=0.60*U+0.96;
% U=0.5907*Rdata(:,6)+1.952;
%% º¯ÊýÄâºÏ
%%% JH Ea=(0.014.*Ta-0.37).*(Rs.*3.523*0.01)

xData(:,1)=OTa-OTs;
% xData(:,1)=OTa;
xData(:,2)=ORs;
xData(:,3)=U;
% xData(:,4)=OTa;
x0=[0.03523 0.0045 0.2];
[x,resnorm,residual]=lsqcurvefit(@(x,xData) JH_curvefit_fun(x,xData),x0,xData,Eo);
clear xData
Eaa=x(1).*(x(2).*(OTa-OTs)+x(3)).*(ORs).*(U);
Ea{i}=Eaa;
Eoa{i}=Eo;
Na{i}=x;
end
%%
save([o_path,'Model_JH_Calibration'],'Ea','Eoa','Na');
%%







