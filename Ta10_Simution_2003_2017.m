clear,clc
close all
%%
%%%% MT for IF
%%%% JH for JH
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
in_path1='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
in_path2='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Models\';
load([in_path,'Sdata_ICP_Daily_2013_2018.mat']);
load([in_path,'RS_data_ICE2003_2017.mat']);
[data,~,data_text]=xlsread([in_path1,'Ta_Ts_QHH_RS.xlsx']);
%%
Qws=0.97;
E_Simu=cell(15,3);
add=0.1:0.1:2;
for ii=1:length(add)
for i = 1:15
    Rdata_IF=TdataPH{i,1};
    Rdata_IC=TdataPH{i,5};
%%
OTa_IF=1.013.*Rdata_IF(:,1)+0.7067;
OTa_IF=(1+add(ii)).*OTa_IF;
OTs_IF=0.7053.*Rdata_IF(:,8)+3.303;

q_IF=Rdata_IF(:,7);
P_IF=Rdata_IF(:,5)./100;
ea_IF=6.105.*exp((17.27*OTa_IF)./(OTa_IF+237.7));
es_IF=6.105.*exp((17.27*OTs_IF)./(OTs_IF+237.7));
RH_IF=(P_IF.*q_IF)./(0.622.*ea_IF);
des_IF=Qws.*es_IF-RH_IF.*ea_IF;   
U_IF=Rdata_IF(:,9); 
N=[0.178407815842651,0.401864864430798,0.258269598797744];    
E_Simu{i,2}=N(1).*(N(2).*(U_IF)+N(3)).*(des_IF);  
%%
OTa_IC=1.013.*Rdata_IC(:,1)+0.7067;
OTa_IC=(1+add(ii)).*OTa_IC;
OTs_IC=0.7053.*Rdata_IC(:,8)+3.303;
ORs_IC=0.8565*Rdata_IC(:,4) + 34.63;
U_IC=Rdata_IC(:,9);     
x=[0.00687492754094517,0.0229253827244826,0.493897105553400];
E_Simu{i,3}=x(1).*(x(2).*(OTa_IC-OTs_IC)+x(3)).*(ORs_IC).*(U_IC);
E_Simu{i,1}=[E_Simu{i,2};E_Simu{i,3}];
end
Eadd_Ta{ii}=E_Simu;
end
%%
%%
save([o_path,'Ta10_Models_E_2003_2017'],'Eadd_Ta');
