clear,clc
close all
%% get daily data
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
[data,~,data_text]=xlsread([in_path,'20130601-2019629Qinghailake_HalfhourDataICEP.xlsx'],'DataH_Inter');
H=data(:,3);
LE=data(:,4);
Rn=data(:,5);
Ta=data(:,17);
Ts1=data(:,18);
Ts2=data(:,19);
Rs=data(:,6);
W=data(:,13);
Prs=data(:,15);
RH=(data(:,26)+data(:,27))/2;
datak=[H,LE,Rn,Ta,Ts1,Ts2,Rs,W,Prs,RH];
[m,n]=size(datak);
datad=nan(m/48,n);
%%
for i = 1:m/48
    datad(i,:)=nanmean(datak(1+48*(i-1):48*i,:),1); 
end