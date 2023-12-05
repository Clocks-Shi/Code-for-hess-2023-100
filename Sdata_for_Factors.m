clear,clc
close all
%% 
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site_ICP\';
load([in_path,'Sdata_ICP_Daily_2013_2018.mat'],'Sdate_DDICP','Sdata_DDICP','Sdata_DICP','Sdata_NICP',...
    'Sdata_DDICP_YM','Sdata_DICP_YM','Sdata_NICP_YM',...
     'Sdata_DDICP_Ystd','Sdata_DICP_Ystd','Sdata_NICP_Ystd');
Vname={'Date','E0','LE','G','Rn','desa','Albdo','WS','WD','P','dTas','Ta','Ts','Tl'};
Fname={'IF2014_DD','IF2015_DD','IF2016_DD','IF2017_DD','IF2018_DD';...
       'IC2014_DD','IC2015_DD','IC2016_DD','IC2017_DD','IC2018_DD';...
       'IF2014_D','IF2015_D','IF2016_D','IF2017_D','IF2018_D';...
       'IC2014_D','IC2015_D','IC2016_D','IC2017_D','IC2018_D';...
       'IF2014_N','IF2015_N','IF2016_N','IF2017_N','IF2018_N';...
       'IC2014_N','IC2015_N','IC2016_N','IC2017_N','IC2018_N'};
   Fname=Fname';
%%
Sdata_DDICP=Sdata_DDICP(2:end,[1 5]);
Sdata_DICP=Sdata_DICP(2:end,[1 5]);
Sdata_NICP=Sdata_NICP(2:end,[1 5]);
Sdata=[Sdata_DDICP Sdata_DICP Sdata_NICP];
Sdate=[Sdate_DDICP(2:end,[1 5]) Sdate_DDICP(2:end,[1 5]) Sdate_DDICP(2:end,[1 5])];
%%
for i = 1:5
    for j = 1:6
        Sdateij=Sdate{i,j};
        Sdataij=Sdata{i,j};
        E0=Sdataij(:,2);
        LE=Sdataij(:,5);
        Rn=Sdataij(:,6);
        G=Sdataij(:,3);
        Ta=Sdataij(:,18);
        Ts=Sdataij(:,19);
        Tl=nanmean(Sdataij(:,20:24),2);
        RH=(Sdataij(:,27)+Sdataij(:,28))/200;
        A=Sdataij(:,13);
        WS=Sdataij(:,14);
        WD=Sdataij(:,15);
        P=Sdataij(:,16);
        Ta_Ts=Ta-Ts;
        es=0.6105.*exp((17.27*Ts)./(Ts+237.7));
        ea=RH*0.6105.*exp((17.27*Ta)./(Ta+237.7));
        es_ea=es-ea;
        Odata=[E0 LE G Rn es_ea A WS WD P Ta_Ts Ta Ts Tl];
        [m,n]=size(Odata);
        E_Odata=cell(m+1,n+1);
        E_Odata(2:end,1)=Sdateij;
        E_Odata(1,:)=Vname;
        E_Odata(2:end,2:end)=num2cell(Odata);
        xlswrite([o_path,Fname{i,j},'.xlsx'],E_Odata); 
    end
end
 