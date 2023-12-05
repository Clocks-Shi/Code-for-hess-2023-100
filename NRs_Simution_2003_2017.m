clear,clc
close all
%%
%%%% MT for IF
%%%% JH for JH
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
in_path1='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
in_path2='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Models\';
load([in_path,'NRs_RS_data_ICE2003_2017.mat']);
[data,~,data_text]=xlsread([in_path1,'Ta_Ts_QHH_RS.xlsx']);
%%
Qws=0.97;
E_Simu=cell(15,3);
for i = 1:15
    Rdata_IF=TdataPH{i,1};
    Rdata_IC=TdataPH{i,5};
%%
OTa_IF=1.013.*Rdata_IF(:,1)+0.7067;
OTs_IF=0.7053.*Rdata_IF(:,8)+3.303;
q_IF=Rdata_IF(:,7);
P_IF=Rdata_IF(:,5)./100;
P_IF=0.97.*P_IF+30.72;
ea_IF=6.105.*exp((17.27*OTa_IF)./(OTa_IF+237.7));
es_IF=6.105.*exp((17.27*OTs_IF)./(OTs_IF+237.7));
RH_IF=100.*(P_IF.*q_IF)./(0.622.*ea_IF);

RH_IF=0.68.*RH_IF+19.95;
RH_IF=RH_IF./100;
des_IF=Qws.*es_IF-RH_IF.*ea_IF;   
U_IF=Rdata_IF(:,9); 
U_IF=0.60*U_IF+0.96;
N=[0.412427708209845	0.172253807240185	0.275444505954430];    
E_Simu{i,2}=N(1).*(N(2).*(U_IF)+N(3)).*(des_IF);     
%%
OTa_IC=1.013.*Rdata_IC(:,1)+0.7067;
OTs_IC=0.7053.*Rdata_IC(:,8)+3.303;
ORs_IC=0.8565*Rdata_IC(:,4) + 34.63;
U_IC=Rdata_IC(:,9);     
U_IC=0.60*U_IC+0.96;
x=[0.0214575905411050	0.00740322390780035	0.180227898627055];
E_Simu{i,3}=x(1).*(x(2).*(OTa_IC-OTs_IC)+x(3)).*(ORs_IC).*(U_IC);
E_Simu{i,1}=[E_Simu{i,2};E_Simu{i,3}];
end
%%
for i=1:15
    for j = 1:3
       E_Simuij=E_Simu{i,j};
       L=length(E_Simuij);
       [xsum,xs05,xs95]=Monte_Carlo_sum(E_Simuij,2000);
       [xmean,xm05,xm95]=Monte_Carlo_mean(E_Simuij,2000);

       NRs_E_Simu_sum(i,j)=xsum;
       NRs_E_Simu_sum_d(i,j)=xsum-abs(xs05);
       NRs_E_Simu_sum_u(i,j)=xsum+abs(xs95);
       
       NRs_E_Simu_ym(i,j)=xmean;
       NRs_E_Simu_ym_d(i,j)=xmean-abs(xm05);
       NRs_E_Simu_ym_u(i,j)=xmean+abs(xm95);      
    end
end
%%
save([o_path,'NRs_Models_E_2003_2017'],'NRs_E_Simu_sum','NRs_E_Simu_sum_d','NRs_E_Simu_sum_u','NRs_E_Simu_ym','NRs_E_Simu_ym_d','NRs_E_Simu_ym_u');
