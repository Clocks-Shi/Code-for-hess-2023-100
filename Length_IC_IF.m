clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
[~,~,ICEP]=xlsread([in_path,'2002_2018Qinghailake_ICEP.xlsx'],'ICEP');
ICEP=ICEP(2:end,2:6);
[m,n]=size(ICEP);
ICEPR=reshape(ICEP,m*n,1);
DateNR=datenum(ICEPR);
DateNRP=reshape(DateNR,m,n);
IF=DateNRP(:,2)-DateNRP(:,1)+1;
IC=DateNRP(:,5)-DateNRP(:,2)+1;

