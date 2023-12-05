clear,clc
close all
%%
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
[data,~,data_text]=xlsread([in_path,'Ta_Ts_QHH_RS_NTs.xlsx']);
[~,~,ICEP]=xlsread([in_path,'2002_2018Qinghailake_ICEP.xlsx'],'ICEP');
ICEP=ICEP(3:end-1,2:end);
Date=data_text(2:end,1);
Datemat=datevec(Date);
Datemat=Datemat(:,1:3);
DateN=datenum(Datemat);
[m,n]=size(ICEP);
ICEPR=reshape(ICEP,m*n,1);
DateNR=datenum(ICEPR);
DateNRP=reshape(DateNR,m,n);
year=2003:2017;
Period={'IF';'FZ';'CF';'TW';'IC'}; 
%% get data period
DirPS=nan(m,n);
DirPE=nan(m,n);
for i = 1:m
    for j = 1:n
        [mp,~]=find(DateN==DateNRP(i,j));
        if isempty(mp)
            DirPS(i,j)=nan;
            DirPE(i,j)=nan;
        else
            DirPS(i,j)=mp(1);
            DirPE(i,j)=mp(end);
        end
    end
end
%% get data for each period of each year
TdataPH=cell(length(year),length(Period));
TdatePH=cell(length(year),length(Period));
for ii = 1:length(year)
        TdataPH{ii,1}=data(DirPS(ii,1):DirPE(ii,2),:);
        TdataPH{ii,2}=data(DirPS(ii,2):DirPE(ii,3),:);
        TdataPH{ii,3}=data(DirPS(ii,3):DirPE(ii,4),:);
        TdataPH{ii,4}=data(DirPS(ii,4):DirPE(ii,5),:);
        TdataPH{ii,5}=data(DirPS(ii,2):DirPE(ii,5),:);
        
        
        TdatePH{ii,1}=Date(DirPS(ii,1):DirPE(ii,2),:);
        TdatePH{ii,2}=Date(DirPS(ii,2):DirPE(ii,3),:);
        TdatePH{ii,3}=Date(DirPS(ii,3):DirPE(ii,4),:);
        TdatePH{ii,4}=Date(DirPS(ii,4):DirPE(ii,5),:);
        TdatePH{ii,5}=Date(DirPS(ii,2):DirPE(ii,5),:);     
end
%%
T_IFym=nan(15,9);
T_ICym=nan(15,9);
T_IFystd=nan(15,9);
T_ICystd=nan(15,9);
LIF=nan(15,1);
LIC=nan(15,1);
for i = 1:15
    TdataPHIFi=TdataPH{i,1};
    TdataPHICi=TdataPH{i,5};
    T_IFym(i,:)=nanmean(TdataPHIFi,1);
    T_ICym(i,:)=nanmean(TdataPHICi,1);
    T_IFystd(i,:)=nanstd(TdataPHIFi,0,1);
    T_ICystd(i,:)=nanstd(TdataPHICi,0,1);
    LIF(i,1)=size(TdataPHIFi,1);
    LIC(i,1)=size(TdataPHICi,1);
end
%%
save([o_path,'NTs_RS_data_ICE2003_2017'],'TdatePH','TdataPH');
save([o_path,'NTs_RS_dataym_ICE2003_2017'],'T_IFym','T_ICym','LIF','LIC','T_IFystd','T_ICystd');