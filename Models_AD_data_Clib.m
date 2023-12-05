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
us(1)=0.39;
us(2)=0.40;
us(3)=0.35;
for i = 1:3
    Rdata=RS{i};
    OBSi=OBS{i};
    Eo=OBSi(:,2);
OTa=1.013.*Rdata(:,1)+0.7067;
OTs=0.7053.*Rdata(:,8)+3.303;
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
ra=(1.293.*(273.15./(273.15+OTa)).*(P/101.325));
% Ce=2.5*10^(-3);
rw=1.011*10^(3);
%% º¯ÊýÄâºÏ
%%% Model AD  Eaj=1.31.*0.622.*Ce.*ra.*U.*3.6*10^6.*des./(rw.*P);
xData(:,1)=ra;
xData(:,2)=U;
xData(:,3)=des;
xData(:,4)=rw;
xData(:,5)=P;
xData(:,6)=ones(length(P),1);
% v0=1.5*10^(-5);
% v=v0.*((OTa+273.15)/(20+273.15)).*1.5.*((20+273.15+110.4)./(OTa+273.15+110.4));     
% g=9.8;
x0=1;
% Zom=us(i).^2./(81*g);
% Zov=7.4.*Zom.*exp(-2.25.*(us(i)./v).^(0.25));
% Ce=0.41^2./(log(2.5./Zov).*log(2.5./Zom));
[x,resnorm,residual]=lsqcurvefit(@(x,xData) AD_curvefit_fun(x,xData),x0,xData,Eo);
clear xData
Eaa=x(1).*0.622.*ra.*U.*3.6*10^6.*des./(rw.*P);
Ea{i}=Eaa;
Eoa{i}=Eo;
Na{i}=x;
end
%%
save([o_path,'Model_AD_Calibration'],'Ea','Eoa','Na');
%%







