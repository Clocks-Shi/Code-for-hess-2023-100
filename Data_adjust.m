clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\tables\';
[data,text,data_text]=xlsread([in_path,'data_compare.xlsx']);
%%% OTa=1.013*CTa+0.7067 (1, 1.027)  (0.5861, 0.8272) R2=0.92; RMSE=2.62;
OTa=data(:,1);
CTa=data(:,2);
YTa=1.013*CTa + 0.7067;
%%% OTs=0.7053*ETs+ 3.303 (0.6951, 0.7155)  (3.186, 3.42) R2=0.90; RMSE=2.57;
OTs=data(:,3);
MTs=data(:,5);
ETs=data(:,6);
YTs=0.7053*ETs + 3.303;
%%% ORs=0.8565*CRs + 34.63 (0.8343, 0.8787) (29.78, 39.47) R2=0.73; RMSE=39.57;
%%% ORn=0.8943*CRs - 90.74 (0.8726, 0.916)  (-95.48, -86) R2=0.75; RMSE=38.73;
%%% OG= 0.8667*CRs - 151.5 (0.8384, 0.8951) (-157.7, -145.4) R2=0.63; RMSE=50.56;
ORs=data(:,7);
CRs=data(:,8);
CRl=data(:,9);
ORn=data(:,19);
ORg=data(:,20);
YRs=0.8565*CRs + 34.63;
YRn=0.8943*CRs - 90.74;
YG= 0.8667*CRs - 151.5;
%%%
OW=data(:,10);
CW=data(:,11);
EW=data(:,12);
CEW=(data(:,11)+data(:,12))/2;
% YW=0.5907*CW+1.952;  (0.5429, 0.6385) (1.811, 2.092) R2=0.39; RMSE=1.083;
% YW=0.5893*CW+1.887;  (0.5429, 0.6385) (1.811, 2.092) R2=0.39; RMSE=1.083;
% YW=0.4751*CW+0.3598*EW+1.1802;
% x=data(:,11:12);
% fun=inline('c(1)+c(2).*x(:,1)+c(3).*x(:,2)','c','x');
% c=lsqcurvefit(fun,rand(1,3),x,OW);
%%% OPrs= 0.1534*CRs + 583 (0.1458, 0.161) (577.8, 588.3) R2=0.84; RMSE=1.31;
OPrs=data(:,13);
CPrs=data(:,14);
%%
ORH=data(:,15);
q=data(:,16);
ea=6.105.*exp((17.27*CTa)./(CTa+237.7));
CRH=(CPrs.*q)./(0.622.*ea);
