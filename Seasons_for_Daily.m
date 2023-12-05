clear,clc
close all
%% 
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
load([in_path,'Site_data_2013_2018_HHours_Seasons.mat'],'SdataSea','SdateSea');
year=2013:2018;
[m,n]=size(SdateSea);
Sdata_DtSea=cell(m,n);
Sdata_NSea=cell(m,n);
Sdata_DySea=cell(m,n);
Sdate_DySea=cell(m,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sdata_DtSea_YM=cell(m,n);
Sdata_NSea_YM=cell(m,n);
Sdata_DySea_YM=cell(m,n);
Sdata_DtSea_Ystd=cell(m,n);
Sdata_NSea_Ystd=cell(m,n);
Sdata_DySea_Ystd=cell(m,n);
%%
for i = 1:m
    for j =1:n
        if i==1 && j==1
         Sdata_DtSea{i,j}=nan;
         Sdata_NSea{i,j}=nan;
         Sdata_DySea{i,j}=nan;
         Sdate_DySea{i,j}=nan;
        else
        Dataij=SdataSea{i,j};
        Dateij=SdateSea{i,j};
        PREij=Dataij(:,1);
%         Eij=Dataij(:,2);
        Hij=Dataij(:,3);
        LEij=Dataij(:,4);
        Rnij=Dataij(:,5);
        Taij=Dataij(:,18);
        Gij=Rnij-Hij-LEij;
%         Lamtij=(2500.78-2.3601*Taij)*1000;
        Lamtij=2.45*1000000;
        Eij=LEij*1800./Lamtij;
        ForSum=[PREij Eij];
        ForMean=[Gij Dataij(:,3:end)];
        [ms,ns]=size(ForSum);
        [mm,nm]=size(ForMean);
        ForSumN=nan(ms/48,ns);
        ForSumD=nan(ms/48,ns);
        FormeanN=nan(mm/48,nm);
        FormeanD=nan(mm/48,nm);
        DateDD=cell(mm/48,1);
        for kk = 1:mm/48
            DateDD(kk)=Dateij((kk-1)*48+1);
            ForSumN(kk,:)=nansum(ForSum((kk-1)*48+25:(kk-1)*48+48,:),1);
            ForSumD(kk,:)=nansum(ForSum((kk-1)*48+1:(kk-1)*48+24,:),1);
            FormeanN(kk,:)=nanmean(ForMean((kk-1)*48+25:(kk-1)*48+48,:),1);
            FormeanD(kk,:)=nanmean(ForMean((kk-1)*48+1:(kk-1)*48+24,:),1);
        end
          ForSumDD=ForSumN+ForSumD;
          FormeanDD=(FormeanN+FormeanD)/2;
          DataN=[ForSumN FormeanN];   
          DataD=[ForSumD FormeanD];
          DataDD=[ForSumDD FormeanDD];
          Sdate_DySea{i,j}=DateDD;
         Sdata_DtSea{i,j}=DataD;
         Sdata_NSea{i,j}=DataN;
         Sdata_DySea{i,j}=DataDD;
         
         Sdata_DtSea_YM{i,j}=nanmean(DataD,1);
         Sdata_NSea_YM{i,j}=nanmean(DataN,1);
         Sdata_DySea_YM{i,j}=nanmean(DataDD,1);
         Sdata_DtSea_Ystd{i,j}=nanstd(DataD,1,1);
         Sdata_NSea_Ystd{i,j}=nanstd(DataN,1,1);
         Sdata_DySea_Ystd{i,j}=nanstd(DataDD,1,1);
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end     
    end
end
%%
aa1=Sdata_NSea{2,1}(:,2);
ab1=Sdata_NSea{2,1}(:,5);

aa2=Sdata_NSea{3,1}(:,2);
ab2=Sdata_NSea{3,1}(:,5);

aa3=Sdata_NSea{4,1}(:,2);
ab3=Sdata_NSea{4,1}(:,5);

aa4=Sdata_NSea{5,1}(:,2);
ab4=Sdata_NSea{5,1}(:,5);

aa5=Sdata_NSea{6,1}(:,2);
ab5=Sdata_NSea{6,1}(:,5);


save([o_path,'Sdata_Seasons_Daily_2013_2018.mat'],'Sdate_DySea','Sdata_DySea','Sdata_DtSea','Sdata_NSea',...
    'Sdata_DySea_YM','Sdata_DtSea_YM','Sdata_NSea_YM',...
     'Sdata_DySea_Ystd','Sdata_DtSea_Ystd','Sdata_NSea_Ystd');