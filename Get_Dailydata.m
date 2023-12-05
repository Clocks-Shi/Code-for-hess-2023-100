clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
load([in_path,'Sdata_ICP_Daily_2013_2018.mat']);
Sdata_DDICP_I=Sdata_NICP(:,[1 5]);
[m,n]=size(Sdata_DDICP_I);
Sdata_DDICP_R=reshape(Sdata_DDICP_I',m*n,1);
Sdata_DDICP_R=Sdata_DDICP_R(2:end);
L=length(Sdata_DDICP_R);
%%
bb=nan(1,28);
for i=1:L
    aa=Sdata_DDICP_R{i};
    bb=[bb;aa];  
end
bb=bb(2:end,:);