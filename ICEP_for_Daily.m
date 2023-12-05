clear,clc
close all
%% 
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
load([in_path,'Site_data_2013_2018_HHours_ICP.mat']);
year=2013:2018;
[m,n]=size(SdataPH);
Sdata_DICP=cell(m,n);
Sdata_NICP=cell(m,n);
Sdata_DDICP=cell(m,n);
Sdate_DDICP=cell(m,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sdata_DICP_YM=cell(m,n);
Sdata_NICP_YM=cell(m,n);
Sdata_DDICP_YM=cell(m,n);
Sdata_DICP_Ystd=cell(m,n);
Sdata_NICP_Ystd=cell(m,n);
Sdata_DDICP_Ystd=cell(m,n);
%%
for i = 1:m
    for j =1:n
        if i==1 && j==1
         Sdata_DICP{i,j}=nan;
         Sdata_NICP{i,j}=nan;
         Sdata_DDICP{i,j}=nan;
         Sdate_DDICP{i,j}=nan;
        else
        Dataij=SdataPH{i,j};
        Dateij=SdatePH{i,j};
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
          Sdate_DDICP{i,j}=DateDD;
         Sdata_DICP{i,j}=DataD;
         Sdata_NICP{i,j}=DataN;
         Sdata_DDICP{i,j}=DataDD;
         
         Sdata_DICP_YM{i,j}=nanmean(DataD,1);
         Sdata_NICP_YM{i,j}=nanmean(DataN,1);
         Sdata_DDICP_YM{i,j}=nanmean(DataDD,1);
         Sdata_DICP_Ystd{i,j}=nanstd(DataD,1,1);
         Sdata_NICP_Ystd{i,j}=nanstd(DataN,1,1);
         Sdata_DDICP_Ystd{i,j}=nanstd(DataDD,1,1);
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end     
    end
end
%%
aa1=Sdata_NICP{2,1}(:,2);
ab1=Sdata_NICP{2,1}(:,5);

aa2=Sdata_NICP{3,1}(:,2);
ab2=Sdata_NICP{3,1}(:,5);

aa3=Sdata_NICP{4,1}(:,2);
ab3=Sdata_NICP{4,1}(:,5);

aa4=Sdata_NICP{5,1}(:,2);
ab4=Sdata_NICP{5,1}(:,5);

aa5=Sdata_NICP{6,1}(:,2);
ab5=Sdata_NICP{6,1}(:,5);


save([o_path,'Sdata_ICP_Daily_2013_2018.mat'],'Sdate_DDICP','Sdata_DDICP','Sdata_DICP','Sdata_NICP',...
    'Sdata_DDICP_YM','Sdata_DICP_YM','Sdata_NICP_YM',...
     'Sdata_DDICP_Ystd','Sdata_DICP_Ystd','Sdata_NICP_Ystd');