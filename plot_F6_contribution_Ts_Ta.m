clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Models\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
load([in_path,'Models_E_2003_2017'],'E_Simu_sum','E_Simu_ym');
load([in_path,'NTa_Models_E_2003_2017'],'NTa_E_Simu_sum','NTa_E_Simu_ym');
load([in_path,'NTs_Models_E_2003_2017'],'NTs_E_Simu_sum','NTs_E_Simu_ym');
load([in_path,'NRs_Models_E_2003_2017'],'NRs_E_Simu_sum','NRs_E_Simu_ym');
load([in_path,'NU_Models_E_2003_2017'],'NU_E_Simu_sum','NU_E_Simu_ym');
%%
E_S=[E_Simu_ym, E_Simu_sum];
NTa_E_S=[NTa_E_Simu_ym, NTa_E_Simu_sum];
NTs_E_S=[NTs_E_Simu_ym, NTs_E_Simu_sum];
NRs_E_S=[NRs_E_Simu_ym, NRs_E_Simu_sum];
NU_E_S=[NU_E_Simu_ym, NU_E_Simu_sum];
%%
N_dE{1}=E_S-NTa_E_S;
N_dE{2}=E_S-NTs_E_S;
N_dE{3}=E_S-NRs_E_S;
N_dE{4}=E_S-NU_E_S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_dEp{1}=abs(100*(E_S-NTa_E_S)./NTa_E_S);
N_dEp{2}=abs(100*(E_S-NTs_E_S)./NTs_E_S);
N_dEp{3}=abs(100*(E_S-NRs_E_S)./NRs_E_S);
N_dEp{4}=abs(100*(E_S-NU_E_S)./NU_E_S);
%%
for i =1:4
    N_dEi=N_dE{i};
    N_dEpi=N_dEp{i};
    N_dEym(i,:)=nanmean(N_dEi,1);
    N_dEstd(i,:)=nanstd(N_dEi,0,1);
    
    N_dEpym(i,:)=nanmean(N_dEpi,1);
    N_dEpstd(i,:)=nanstd(N_dEpi,0,1);
end
%%
pdata{1}=N_dEym(:,1:3);
pdata{2}=N_dEym(:,4:6);
pdata{3}=N_dEpym(:,1:3);
pdata{4}=N_dEpym(:,4:6);
%%
pdatas{1}=N_dEstd(:,1:3);
pdatas{2}=N_dEstd(:,4:6);
pdatas{3}=N_dEpstd(:,1:3);
pdatas{4}=N_dEpstd(:,4:6);
%%
%% plot
H1=figure(1);
set(H1,'position',[ 108    38   1200    745]);
ha = tight_subplot(2,2,[.11 .08],[.08 .05],[.07 .06]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
for j = 1: 3
 axes(ha(j));
    pdataj=pdata{j};
    pdatajstd=pdatas{j};
    h=bar(pdata{j});
    h(1).FaceColor=[187 255 255]./255;
    h(2).FaceColor=[174 238 238]./255;
    h(3).FaceColor=[0 197 205]./255;
    xlim([0.5,4.5]);
    hold on 
numgroups = size(pdataj, 1);
numbars = size(pdataj, 2);
groupwidth = min(0.8, numbars/(numbars+1.5));
for jj = 1:numbars
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
x = (1:numgroups) - groupwidth/2 + (2*jj-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
errorbar(x, pdataj(:,jj), pdatajstd(:,jj), 'k', 'linestyle', 'none', 'lineWidth', 1);
end
%     ylim([0 80]);
% ylabel('\fontname{Arial}CB (%) ','fontsize',15,'FontWeigh','bold');
 xlabel('\fontname{Arial}Variables'); 
set(gca, 'FontSize',16,'XTick',[1 2 3 4],'XTickLabel',{'Ta';'Ts';'Rs';'WS'});
% % set(get(gca,'YLabel'),'Fontname','Times New Roman','FontSize',14,'FontWeight','bold');
set(gca,'fontsize',16,'Fontname','Arial','FontWeight','bold');
set(get(gca,'XLabel'),'FontSize',16,'FontWeight','bold');
set(get(gca,'Title'),'Fontname','Arial','FontSize',16,'FontWeight','bold');
set(gca,'linewidth',1.2);
end
axes(ha(1));
ylabel('\fontname{Arial}Simulate E (mm d^-^1)','fontsize',16,'FontWeigh','bold');
axes(ha(2))
legend2 = legend('show',{'Annual','Ice-free','Ice-covered'});
set(legend2,...
    'Position',[0.0797978981404874 0.588195560089573 0.131833335463206 0.0969387776613492],...
    'NumColumns',1,...
    'EdgeColor','none',...
   'Color','none');
axes(ha(2));
ylabel('\fontname{Arial}Simulate E (mm yr^-^1)','fontsize',16,'FontWeigh','bold');
axes(ha(3));
ylabel('\fontname{Arial}Change Percentage (%)','fontsize',16,'FontWeigh','bold');
axes(ha(4));
axis off
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.0186666666666667 0.972341567540395 0.029666667175293 0.0413533841244773],...
    'String',{'a'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail');

% 创建 textbox
annotation(H1,'textbox',...
    [0.508000000000002 0.972341567540395 0.0303333338578542 0.0413533841244773],...
    'String',{'b'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail');

% 创建 textbox
annotation(H1,'textbox',...
    [0.0186666666666667 0.47368420986048 0.0303333338578542 0.0413533841244773],...
    'String',{'c'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail');

% % 创建 textbox
% annotation(H1,'textbox',...
%     [0.508000000000002 0.47368420986048 0.0303333338578542 0.0413533841244773],...
%     'String',{'d'},...
%     'LineStyle','none',...
%     'FontWeight','bold',...
%     'FontSize',18,...
%     'FontName','Arail');
%% 保持图片
set(gcf,'PaperPositionMode','auto');
print('-djpeg', '-r600', [mo_path 'F6_Contribution_Ts_Ta']);


