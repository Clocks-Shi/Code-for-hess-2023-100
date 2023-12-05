clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
[data,~,data_text]=xlsread([in_path,'20130601-2019629Qinghailake_HalfhourDataICEP.xlsx'],'DataH_Inter');
[~,~,Season]=xlsread([in_path,'2002_2018Qinghailake_ICEP.xlsx'],'Seasons');
G=data(:,5)-data(:,4)-data(:,3);
Rs=data(:,6);
Gi=nan(length(G)/48,1);
Rsi=nan(length(G)/48,1);
for i = 1:length(G)/48
Gi(i)=nanmean(G(48*(i-1)+1:48*i));
Rsi(i)=nanmean(Rs(48*(i-1)+1:48*i));
end
Season=Season(13:end,2:end);
Date=data_text(4:end,1);
Datemat=datevec(Date);
Datemat=Datemat(:,1:3);
DateN=datenum(Datemat);
[m,n]=size(Season);
SeasonS=Season(:,[1 3 5 7]);
SeasonE=Season(:,[2 4 6 8]);

SEAS=reshape(SeasonS,m*4,1);
DateNRS=datenum(SEAS);
DateNRPS=reshape(DateNRS,m,4);

SEAE=reshape(SeasonE,m*4,1);
DateNRE=datenum(SEAE);
DateNRPE=reshape(DateNRE,m,4);

year=2013:2018;
Period={'SP';'SU';'AT';'WT'}; 
%% get data period
DirPS=nan(m,4);
DirPE=nan(m,4);
for i = 1:m
    for j = 1:4
        [mp,~]=find(DateN==DateNRPS(i,j));
        if isempty(mp)
            DirPS(i,j)=nan;
        else
            DirPS(i,j)=mp(1);
        end
         [mpe,~]=find(DateN==DateNRPE(i,j));      
        if isempty(mp)
            DirPE(i,j)=nan;
        else
            DirPE(i,j)=mpe(end);
        end     
    end
end
%% get data for each period of each year
SdataSea=cell(length(year),length(Period));
SdateSea=cell(length(year),length(Period));
for ii = 1:length(year)
    if ii==1
        SdataSea{ii,1}=nan;
        SdataSea{ii,2}=data(DirPS(ii,2):DirPE(ii,2),:);
        SdataSea{ii,3}=data(DirPS(ii,3):DirPE(ii,3),:);
        SdataSea{ii,4}=data(DirPS(ii,4):DirPE(ii,4),:);
        
        SdateSea{ii,1}=nan;
        SdateSea{ii,2}=Date(DirPS(ii,2):DirPE(ii,2),:);
        SdateSea{ii,3}=Date(DirPS(ii,3):DirPE(ii,3),:);
        SdateSea{ii,4}=Date(DirPS(ii,4):DirPE(ii,4),:);
    else
        SdataSea{ii,1}=data(DirPS(ii,1):DirPE(ii,1),:);
        SdataSea{ii,2}=data(DirPS(ii,2):DirPE(ii,2),:);
        SdataSea{ii,3}=data(DirPS(ii,3):DirPE(ii,3),:);
        SdataSea{ii,4}=data(DirPS(ii,4):DirPE(ii,4),:);

        
        
        SdateSea{ii,1}=Date(DirPS(ii,1):DirPE(ii,1),:);
        SdateSea{ii,2}=Date(DirPS(ii,2):DirPE(ii,2),:);
        SdateSea{ii,3}=Date(DirPS(ii,3):DirPE(ii,3),:);
        SdateSea{ii,4}=Date(DirPS(ii,4):DirPE(ii,4),:);  
    end   
end
%%
save([o_path,'Site_data_2013_2018_HHours_Seasons.mat'],'SdataSea','SdateSea');