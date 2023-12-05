clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
year=2003:2018;
L=length(year);
ICRm=nan(L,1);
%%
for i = 1:L
    [data,~,data_test]=xlsread([in_path,'2002_2018Qinghailake_ICEP.xlsx'],num2str(year(i)));
    ICRm(i)=nanmean(data);  
end
