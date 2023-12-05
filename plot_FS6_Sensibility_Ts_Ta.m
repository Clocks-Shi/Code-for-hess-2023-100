clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Models\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
load([in_path,'Models_E_2003_2017'],'E_Simu_sum','E_Simu_ym');
load([in_path,'Ta10_Models_E_2003_2017']);
load([in_path,'Ts10_Models_E_2003_2017']);
load([in_path,'Rs10_Models_E_2003_2017']);
load([in_path,'U10_Models_E_2003_2017']);
%%
Eadd=[Eadd_Ta; Eadd_Ts; Eadd_Rs; Eadd_U];
EeachS=nan(15,3);
 Eplot=cell(4,1);
for ii = 1:4
    for jj = 1:20
       Eiijj= Eadd{ii,jj};
    
  for i =1:15
      for j=1:3
         Eeach=Eiijj{i,j}; 
          EeachS(i,j)=nansum(Eeach);
      end
  end
  PE=100.*(EeachS-E_Simu_sum)./E_Simu_sum;
  for aa=1:3
  [xmean,xm05,xm95]=Monte_Carlo_mean(PE(:,aa),1000);
  Pmean(1,aa)=xmean;
  Prd(1,aa)=xm05;
  Pru(1,aa)=xm95;
  end
  EPmean(jj,:)=Pmean;
  EPrd(jj,:)=Prd;
  EPru(jj,:)=Pru;
  clear Pmean Prd Pru
   end
    Eplot{ii,1}=EPmean;
    Eplot{ii,2}=EPrd;
    Eplot{ii,3}=EPru;
    clear EPmean EPru EPrd
    
end
xlb={'Ta';'Ts';'Rs';'WS'};
%%
%% plot
H1=figure(1);
set(H1,'position',[ 108    38   1200    745]);
ha = tight_subplot(2,2,[.11 .08],[.08 .05],[.07 .06]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
x=10:10:200;
for j = 1: 4
 axes(ha(j));
    pdataj=Eplot{j,1};
    hp1=plot(x,pdataj(:,1),'k-','LineWidth',1.2);
    hold on
    hp2=plot(x,pdataj(:,2),'b-','LineWidth',1.2);
    hold on
    hp3=plot(x,pdataj(:,3),'LineStyle','-','color',[0 197 205]./255,'LineWidth',1.2);
    xlim([10,200]);
    hold on 
 xlabel(xlb{j}); 
 ylabel('\fontname{Arial}Change Percentage (%)','fontsize',16,'FontWeigh','bold');
set(gca, 'FontSize',16,'XTick',[10 40 70 100 130 160 190],'XTickLabel',{'+10%';'+40%';'+70%';'+100%';'+130%';'+160%';'+190%'});
% % set(get(gca,'YLabel'),'Fontname','Times New Roman','FontSize',14,'FontWeight','bold');
set(gca,'fontsize',16,'Fontname','Arial','FontWeight','bold');
set(get(gca,'XLabel'),'FontSize',16,'FontWeight','bold');
set(get(gca,'Title'),'Fontname','Arial','FontSize',16,'FontWeight','bold');
set(gca,'linewidth',1.2);
end
axes(ha(1));
legend2 = legend('show',{'Annual','Ice-free','Ice-covered'});
set(legend2,...
    'Position',[0.0797978981404874 0.588195560089573 0.131833335463206 0.0969387776613492],...
    'NumColumns',1,...
    'EdgeColor','none',...
   'Color','none');

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

% 创建 textbox
annotation(H1,'textbox',...
    [0.508000000000002 0.47368420986048 0.0303333338578542 0.0413533841244773],...
    'String',{'d'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail');
%% 保持图片
set(gcf,'PaperPositionMode','auto');
print('-djpeg', '-r600', [mo_path 'FS6_Sensibility_Ts_Ta']);


