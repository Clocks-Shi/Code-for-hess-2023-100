clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
[data,~,data_text]=xlsread([in_path,'20130601-2019629Qinghailake_HalfhourDataICEP.xlsx'],'DataH_Inter');
[~,~,ICEP]=xlsread([in_path,'2002_2018Qinghailake_ICEP.xlsx'],'ICEP');
G=data(:,5)-data(:,4)-data(:,3);
Rs=data(:,6);
Gi=nan(length(G)/48,1);
Rsi=nan(length(G)/48,1);
for i = 1:length(G)/48
Gi(i)=nanmean(G(48*(i-1)+1:48*i));
Rsi(i)=nanmean(Rs(48*(i-1)+1:48*i));
end
ICEP=ICEP(13:end,2:end);
Date=data_text(4:end,1);
Datemat=datevec(Date);
Datemat=Datemat(:,1:3);
DateN=datenum(Datemat);
[m,n]=size(ICEP);
ICEPR=reshape(ICEP,m*n,1);
DateNR=datenum(ICEPR);
DateNRP=reshape(DateNR,m,n);
year=2013:2018;
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
SdataPH=cell(length(year),length(Period));
SdatePH=cell(length(year),length(Period));
for ii = 1:length(year)
    if ii==1
        SdataPH{ii,1}=nan;
        SdataPH{ii,2}=data(DirPS(ii,2):DirPE(ii,3),:);
        SdataPH{ii,3}=data(DirPS(ii,3):DirPE(ii,4),:);
        SdataPH{ii,4}=data(DirPS(ii,4):DirPE(ii,5),:);
        SdataPH{ii,5}=data(DirPS(ii,2):DirPE(ii,5),:);
        
        SdatePH{ii,1}=nan;
        SdatePH{ii,2}=Date(DirPS(ii,2):DirPE(ii,3),:);
        SdatePH{ii,3}=Date(DirPS(ii,3):DirPE(ii,4),:);
        SdatePH{ii,4}=Date(DirPS(ii,4):DirPE(ii,5),:);
        SdatePH{ii,5}=Date(DirPS(ii,2):DirPE(ii,5),:);
    else
        SdataPH{ii,1}=data(DirPS(ii,1):DirPE(ii,2),:);
        SdataPH{ii,2}=data(DirPS(ii,2):DirPE(ii,3),:);
        SdataPH{ii,3}=data(DirPS(ii,3):DirPE(ii,4),:);
        SdataPH{ii,4}=data(DirPS(ii,4):DirPE(ii,5),:);
        SdataPH{ii,5}=data(DirPS(ii,2):DirPE(ii,5),:);
        
        
        SdatePH{ii,1}=Date(DirPS(ii,1):DirPE(ii,2),:);
        SdatePH{ii,2}=Date(DirPS(ii,2):DirPE(ii,3),:);
        SdatePH{ii,3}=Date(DirPS(ii,3):DirPE(ii,4),:);
        SdatePH{ii,4}=Date(DirPS(ii,4):DirPE(ii,5),:);
        SdatePH{ii,5}=Date(DirPS(ii,2):DirPE(ii,5),:);     
    end   
end
%%
save([o_path,'Site_data_2013_2018_HHours_ICP.mat'],'SdataPH','SdatePH');