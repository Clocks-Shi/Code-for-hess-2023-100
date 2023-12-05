clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
data=xlsread([in_path,'2002_2018Qinghailake_ICEP.xlsx'],'ICE_Coverage_O');
%%
Datenum=data(:,1);
ICR=data(:,2);
DateNstr=num2str(Datenum);
Allyear=str2num(DateNstr(:,1:4));
Alldays=str2num(DateNstr(:,5:end));
years=union(Allyear,[]);
aa=nan(length(years),2);
for yi = 1:length(years)
     [my,~]=find(Allyear==years(yi));
     aa(yi,1)=length(my);
     aa(yi,2)=Alldays(my(end))-Alldays(my(1))+1;
end


