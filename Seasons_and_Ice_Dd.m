clear,clc
close all
%% load
in_path1='E:\Paper\Lake_ET\Winter_ET\in_data\';
in_path2='E:\Paper\Lake_ET\Winter_ET\in_data\';
o_path='E:\Paper\Lake_ET\Winter_ET\o_data\Seasons\';
o_path2='E:\Paper\Lake_ET\Winter_ET\o_data\All_Seasons\Daytime\';
[data,text,data_text]=xlsread([in_path1,'20130601-2019631Qinghailake_Daily.xlsx'],'Daytime');
[~,~,ICE_D]=xlsread([in_path2,'IC_Date.xlsx'],'ICE');
[~,~,Sea_D]=xlsread([in_path2,'IC_Date.xlsx'],'Seasons');
Title1={'QhC02_2013IC';'QhC02_2013SU';'QhC02_2013AU';'QhC02_2013FF';'QhC02_2013CF';'QhC02_2013TT';...
       'QhC02_2014AN';'QhC02_2014IF';'QhC02_2014IC';'QhC02_2014SU';'QhC02_2014AU';'QhC02_2014FF';'QhC02_2014CF';'QhC02_2014TT';...
       'QhC02_2015AN';'QhC02_2015IF';'QhC02_2015IC';'QhC02_2015SU';'QhC02_2015AU';'QhC02_2015FF';'QhC02_2015CF';'QhC02_2015TT';...
       'QhC02_2016AN';'QhC02_2016IF';'QhC02_2016IC';'QhC02_2016SU';'QhC02_2016AU';'QhC02_2016FF';'QhC02_2016CF';'QhC02_2016TT';...
       'QhC02_2017AN';'QhC02_2017IF';'QhC02_2017IC';'QhC02_2017SU';'QhC02_2017AU';'QhC02_2017FF';'QhC02_2017CF';'QhC02_2017TT';...
       'QhC02_2018AN';'QhC02_2018IF';'QhC02_2018IC';'QhC02_2018SU';'QhC02_2018AU';'QhC02_2018FF';'QhC02_2018CF';'QhC02_2018TT'};
Title2={'DdS1_AN2013_2018';'DdS2_IF2013_2018';'DdS3_IC2013_2018';'DdS4_SU2013_2018';'DdS5_AU2013_2018';'DdS6_FF2013_2018';'DdS7_CF2013_2018';'DdS8_TT2013_2018'};
%% 提取各阶段时间
Date=data_text(4:end,1);
ICE_D1318=reshape(ICE_D(14:19,2:5)',6*4,1);
Sea_D1318=reshape(Sea_D(14:19,4:7)',6*4,1);
Dn=datenum(Date);
In=datenum(ICE_D1318);
Sn=datenum(Sea_D1318);
DL=length(In);
for i = 1:DL
    [Im,~]=find(Dn==In(i));
    [Sm,~]=find(Dn==Sn(i));
    Id(i,1)=Im;
    Sd(i,1)=Sm;
end
Id_R=reshape(Id,4,6);
Sd_R=reshape(Sd,4,6);

ANSd=Id_R(4,1:end-1)+1;
ANEd=Id_R(4,2:end);
IFSd=Id_R(4,1:end-1)+1;
IFEd=Id_R(1,2:end)-1;
ICSd=Id_R(1,:);
ICEd=Id_R(4,:);
SUSd=Sd_R(1,:);
SUEd=Sd_R(2,:);
AUSd=Sd_R(3,:);
AUEd=Sd_R(4,:);
FFSd=Id_R(1,:);
FFEd=Id_R(2,:)-1;
CFSd=Id_R(2,:);
CFEd=Id_R(3,:)-1;
TTSd=Id_R(3,:);
TTEd=Id_R(4,:);
%% 提取各时段
DirL1=length(ICSd);
DirL2=length(ANSd);
DdSdata{1,1}=data_text(1:3,:);
DdSdata{1,2}=data_text(1:3,:);
DdSdata{1,3}=data_text(1:3,:);
DdSdata{1,4}=data_text(1:3,:);
DdSdata{1,5}=data_text(1:3,:);
DdSdata{1,6}=data_text(1:3,:);
DdSdata{1,7}=data_text(1:3,:);
DdSdata{1,8}=data_text(1:3,:);

for i = 1:DirL1
    ICi=data_text((ICSd(i)+3):(ICEd(i)+3),:);
    DdSeas{i,3}=ICi;
    DdSdata{1,3}=[DdSdata{1,3};ICi];
    
    SUi=data_text((SUSd(i)+3):(SUEd(i)+3),:);
    DdSeas{i,4}=SUi;
    DdSdata{1,4}=[DdSdata{1,4};SUi];  
    
    AUi=data_text((AUSd(i)+3):(AUEd(i)+3),:);
    DdSeas{i,5}=AUi;
    DdSdata{1,5}=[DdSdata{1,5};AUi];
    
    FFi=data_text((FFSd(i)+3):(FFEd(i)+3),:);
    DdSeas{i,6}=FFi;
    DdSdata{1,6}=[DdSdata{1,6};FFi];
    
    CFi=data_text((CFSd(i)+3):(CFEd(i)+3),:);
    DdSeas{i,7}=CFi;
    DdSdata{1,7}=[DdSdata{1,7};CFi];
    
    TTi=data_text((TTSd(i)+3):(TTEd(i)+3),:);
    DdSeas{i,8}=TTi;
    DdSdata{1,8}=[DdSdata{1,8};TTi];
  clear   ICi SUi AUi FFi CFi TTi
end
for i = 1:DirL2
    ANi=data_text((ANSd(i)+3):(ANEd(i)+3),:);
    DdSeas{i+1,1}=ANi;
    DdSdata{1,1}=[DdSdata{1,1};ANi];
    
    IFi=data_text((IFSd(i)+3):(IFEd(i)+3),:);
    DdSeas{i+1,2}=IFi;
    DdSdata{1,2}=[DdSdata{1,2};IFi];      
    clear   ANi IFi
end
%% 计算均值和方差
DdSeas_R=reshape(DdSeas,6*8,1);
m=length(DdSeas_R);
DdDataM=nan(m,36);
DdDataS=nan(m,36);
DdData_std=nan(m,36);
for i =1:m

    Qhi=DdSeas_R{i};
    Datai=cell2mat(Qhi(:,3:end));
    if length(Datai)==0
       L(i)=size(Datai,1);
       DdDataM(i,:)=nan(1,36);
       DdDataS(i,:)=nan(1,36);
       DdData_std(i,:)=nan(1,36); 
    else
       L(i)=size(Datai,1);
       DdDataM(i,:)=nanmean(Datai);
       DdDataS(i,:)=nansum(Datai);
       DdData_std(i,:)=nanstd(Datai);
    end
  
end
%  
%     xlswrite([o_path,'Daily_',Title1{i},'.xlsx'],Qhi);
%%
for i =1:8
  Si=DdSdata{1,i};
  xlswrite([o_path2,Title2{i},'.xlsx'],Si);  
end
save([o_path,'QhET_DdSeas.mat'],'DdSeas');
save([o_path,'DdSdata.mat'],'DdSdata');
save([o_path,'Ddmean.mat'],'DdDataM','DdDataS','DdData_std');


