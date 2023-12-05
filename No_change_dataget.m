clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
[data,text,data_text]=xlsread([in_path,'Ta_Ts_QHH_RS.xlsx']);
%% CTa no change
year=2001:2018;
CTa=data(:,9);
NCTa=nan(length(CTa),1);
CTa2001=CTa(1:365,1);
for i=1:18
    if mod(i,4)==0
     da(i)=366;
    else
      da(i)=365;  
    end
end
da=[1 da];
dak=cumsum(da);
for i = 1:18
    if mod(i,4)==0
     NCTa(dak(i):dak(i+1)-2)=CTa2001;
     NCTa(dak(i+1)-1)=CTa2001(end);
    else
      NCTa(dak(i):dak(i+1)-1)=CTa2001;
    end  
end
