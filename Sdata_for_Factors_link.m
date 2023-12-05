clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site_ICP\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site_ICP\For_R\';
yearIC=2014:2017;
yearIF=2014:2018;
%%
LIC=length(yearIC);
LIF=length(yearIF);
ICdataDD=nan(1,14);
ICdataD=nan(1,14);
ICdataN=nan(1,14);
for i = 1:LIC
    [data1,~,data_test1]=xlsread([in_path,'IC',num2str(yearIC(i)),'_DD.xlsx']);
    [data2,~,data_test2]=xlsread([in_path,'IC',num2str(yearIC(i)),'_D.xlsx']);
    [data3,~,data_test3]=xlsread([in_path,'IC',num2str(yearIC(i)),'_N.xlsx']);
%     data2i=[data2,data1(:,end)];
%     data3i=[data3,data1(:,end)];
    ICdataDD=[ICdataDD;data1];
    ICdataD=[ICdataD;data2];
    ICdataN=[ICdataN;data3];
    VIC=data_test1(1,2:end);
    clear data1 data2 data3 data2i data3i 
end
%%
IFdataDD=nan(1,13);
IFdataD=nan(1,13);
IFdataN=nan(1,13);
for i = 1:LIF
    [data4,~,data_test4]=xlsread([in_path,'IF',num2str(yearIF(i)),'_DD.xlsx']);
    [data5,~,data_test5]=xlsread([in_path,'IF',num2str(yearIF(i)),'_D.xlsx']);
    [data6,~,data_test6]=xlsread([in_path,'IF',num2str(yearIF(i)),'_N.xlsx']);
    IFdataDD=[IFdataDD;data4];
    IFdataD=[IFdataD;data5];
    IFdataN=[IFdataN;data6];
    VIF=data_test4(1,2:end);
    clear data4 data5 data6
end
%%
E_OdataICDD=cell(358,14);
E_OdataICD=cell(358,14);
E_OdataICN=cell(358,14);
E_OdataICDD(1,:)=VIC;
E_OdataICD(1,:)=VIC;
E_OdataICN(1,:)=VIC;
E_OdataICDD(2:end,:)=num2cell(ICdataDD(2:end,:));
E_OdataICD(2:end,:)=num2cell(ICdataD(2:end,:));
E_OdataICN(2:end,:)=num2cell(ICdataN(2:end,:));      

E_OdataIFDD=cell(1390,13);
E_OdataIFD=cell(1390,13);
E_OdataIFN=cell(1390,13);
E_OdataIFDD(1,:)=VIF;
E_OdataIFD(1,:)=VIF;
E_OdataIFN(1,:)=VIF;
E_OdataIFDD(2:end,:)=num2cell(IFdataDD(2:end,:));
E_OdataIFD(2:end,:)=num2cell(IFdataD(2:end,:));
E_OdataIFN(2:end,:)=num2cell(IFdataN(2:end,:));  

xlswrite([o_path,'IC2014_2017DD.xlsx'],E_OdataICDD); 
xlswrite([o_path,'IC2014_2017D.xlsx'],E_OdataICD); 
xlswrite([o_path,'IC2014_2017N.xlsx'],E_OdataICN); 
xlswrite([o_path,'IF2014_2018DD.xlsx'],E_OdataIFDD); 
xlswrite([o_path,'IF2014_2018D.xlsx'],E_OdataIFD); 
xlswrite([o_path,'IF2014_2018N.xlsx'],E_OdataIFN); 
