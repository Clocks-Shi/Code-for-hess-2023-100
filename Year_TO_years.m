clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
load([in_path,'Sdata_ICP_Daily_2013_2018.mat'],'Sdate_DDICP','Sdata_DDICP','Sdata_DICP','Sdata_NICP',...
    'Sdata_DDICP_YM','Sdata_DICP_YM','Sdata_NICP_YM',...
     'Sdata_DDICP_Ystd','Sdata_DICP_Ystd','Sdata_NICP_Ystd');