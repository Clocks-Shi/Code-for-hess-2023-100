clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Models\Calibration\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
flies=dir([in_path,'*.mat']);
%% AD JH MD
for i = 1:length(flies)
    fname=flies(i).name;
    load([in_path,fname])
    Ea_AN(:,i)=Ea{1};
    Ea_IF(:,i)=Ea{2};
    Ea_IC(:,i)=Ea{3};
    
    Eo_AN(:,i)=Eoa{1};
    Eo_IF(:,i)=Eoa{2};
    Eo_IC(:,i)=Eoa{3};    
end
%%
for i =1:3
    Ea_ANi=Ea_AN(:,i);
    Eo_ANi=Eo_AN(:,i);
    
    Ea_IFi=Ea_IF(:,i);
    Eo_IFi=Eo_IF(:,i);
    
    Ea_ICi=Ea_IC(:,i);
    Eo_ICi=Eo_IC(:,i);
    
    Roo_AN=Eo_ANi-Ea_ANi;
    RMSE_AN(i,1)=(sum((Roo_AN).^2,1)/length(Eo_ANi)).^(0.5);

    Roo_IF=Eo_IFi-Ea_IFi;
    RMSE_IF(i,1)=(sum((Roo_IF).^2,1)/length(Eo_IFi)).^(0.5);
    
    Roo_IC=Eo_ICi-Ea_ICi;
    RMSE_IC(i,1)=(sum((Roo_IC).^2,1)/length(Eo_ICi)).^(0.5);

SenX_AN=[Eo_ANi,Ea_ANi];
[mA,bA] = TheilSen(SenX_AN);
K_AN(i)=mA; B_AN(i)=bA;
yaAN=mA.*Eo_ANi+bA;
Rs_AN(i,1)=abs(1-(nansum((yaAN-Eo_ANi).^2,1)/nansum((nanmean(Eo_ANi,1)-Eo_ANi).^2,1)));
EAN{i,1}=Ea_ANi;
EAN{i,2}=Eo_ANi;
EAN{i,3}=yaAN;

SenX_IF=[Eo_IFi,Ea_IFi];
[mF,bF] = TheilSen(SenX_IF);
K_IF(i)=mF; B_AN(i)=bF;
yaIF=mF.*Eo_IFi+bF;
Rs_IF(i,1)=abs(1-(nansum((yaIF-Eo_IFi).^2,1)/nansum((nanmean(Eo_IFi,1)-Eo_IFi).^2,1)));
EIF{i,1}=Ea_IFi;
EIF{i,2}=Eo_IFi;
EIF{i,3}=yaIF;

SenX_IC=[Eo_ICi,Ea_ICi];
[mC,bC] = TheilSen(SenX_IC);
K_IC(i)=mC; B_IC(i)=bC;
yaIC=mC.*Eo_ICi+bC;
Rs_IC(i,1)=abs(1-(nansum((yaIC-Eo_ICi).^2,1)/nansum((nanmean(Eo_ICi,1)-Eo_ICi).^2,1)));
EIC{i,1}=Ea_ICi;
EIC{i,2}=Eo_ICi;
EIC{i,3}=yaIC;   
end
%%
H1=figure(1);
set(H1,'pos',[ 0.0010    0.0010    1.5360    0.7896]*10^3);
ha = tight_subplot(3,3,[.08 .06],[.12 .05],[.06 .01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
for i = 1:3
   axes(ha(i));
   h1=plot(EAN{i,2},EAN{i,1},'ro');
   hold on
   h3=plot(EAN{i,2},EAN{i,2},'k-','LineWidth',1.5);
   xlim([min(EAN{i,2}),max(EAN{i,2})])
   ylim([min(EAN{i,2}),max(EAN{i,2})])
 set(gca,'fontsize',14,'Fontname','Arial','FontWeight','bold');
 xlabel('\fontname{Arial}Observed E (mm d^-^1)', 'fontsize',16,'FontWeigh','bold');
 set(gca,'linewidth',1.2);
box on
   axes(ha(i+3));
   h1=plot(EIF{i,2},EIF{i,1},'ro');
   hold on
   h3=plot(EIF{i,2},EIF{i,2},'k-','LineWidth',1.5);
   xlim([min(EIF{i,2}),max(EIF{i,2})])
   ylim([min(EIF{i,2}),max(EIF{i,2})])
 set(gca,'fontsize',14,'Fontname','Arial','FontWeight','bold');
 xlabel('\fontname{Arial}Observed E (mm d^-^1)', 'fontsize',16,'FontWeigh','bold');
 set(gca,'linewidth',1.2);
   
   axes(ha(i+6));
   h1=plot(EIC{i,2},EIC{i,1},'ro');
   hold on
   h3=plot(EIC{i,2},EIC{i,2},'k-','LineWidth',1.5);
   xlim([min(EIC{i,2}),max(EIC{i,2})])
   ylim([min(EIC{i,2}),max(EIC{i,2})])
 set(gca,'fontsize',14,'Fontname','Arial','FontWeight','bold');
 xlabel('\fontname{Arial}Observed E (mm d^-^1)', 'fontsize',16,'FontWeigh','bold');
 set(gca,'linewidth',1.2);   
end
YM1=[1 4 7];
YM2=[2 5 8];
YM3=[3 6 9];
%%
for i = 1:3
  axes(ha(YM1(i)));  
  ylabel('\fontname{Arial}E_A_D (mm d^-^1)', 'fontsize',16,'FontWeigh','bold');  
    axes(ha(YM2(i)));  
  ylabel('\fontname{Arial}E_J_H (mm d^-^1)', 'fontsize',16,'FontWeigh','bold'); 
    axes(ha(YM3(i)));  
  ylabel('\fontname{Arial}E_M_T (mm d^-^1)', 'fontsize',16,'FontWeigh','bold'); 
    
end
%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.0629791666666666 0.898176290972013 0.0695312515025338 0.0471124628273791],...
    'String','R^2 = 0.55',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.393447916666666 0.898176290972013 0.0695312515025338 0.0471124628273791],...
    'String','R^2 = 0.54',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.722874999999999 0.898176290972013 0.0695312515025338 0.0471124628273791],...
    'String','R^2 = 0.50',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.0629791666666666 0.86727456875002 0.0903645853325725 0.0400202640767277],...
    'String','RMSE = 1.12',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.393447916666666 0.86727456875002 0.0903645853325725 0.0400202640767277],...
    'String','RMSE = 0.89',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.722874999999999 0.86727456875002 0.0903645853325725 0.0400202640767277],...
    'String','RMSE = 1.07',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.0640208333333332 0.596504558449219 0.0695312515025336 0.0471124628273791],...
    'String','R^2 = 0.76',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.393447916666666 0.596504558449219 0.0695312515025338 0.0471124628273791],...
    'String','R^2 = 0.61',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.722874999999999 0.596504558449219 0.0695312515025338 0.0471124628273791],...
    'String','R^2 = 0.79',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.0640208333333332 0.564589665001289 0.0903645853325723 0.0400202640767277],...
    'String','RMSE = 0.91',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.393447916666666 0.564589665001289 0.0903645853325725 0.0400202640767277],...
    'String','RMSE = 0.77',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.722874999999999 0.564589665001289 0.0903645853325724 0.0400202640767277],...
    'String','RMSE = 0.85',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.0640208333333332 0.291286726635645 0.0695312515025334 0.0471124628273792],...
    'String','R^2 = 0.38',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.393447916666666 0.291286726635645 0.0695312515025338 0.0471124628273792],...
    'String','R^2 = 0.65',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.722874999999999 0.291286726635645 0.0695312515025338 0.0471124628273792],...
    'String','R^2 = 0.36',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.0640208333333332 0.259371833187714 0.0903645853325722 0.0400202640767277],...
    'String','RMSE = 1.17',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');

% 创建 textbox
annotation(H1,'textbox',...
    [0.393447916666666 0.259371833187714 0.0903645853325725 0.0400202640767277],...
    'String','RMSE = 1.02',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.722874999999999 0.259371833187714 0.0903645853325724 0.0400202640767277],...
    'String','RMSE = 1.10',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial',...
    'FitBoxToText','off');
%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.270010416666665 0.733535966926314 0.0585937512417635 0.0400202640767277],...
    'String','Annual',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.266624999999998 0.431104355984065 0.0606770846247673 0.0400202640767277],...
    'String','Ice-free',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.243968749999998 0.12056737523432 0.0851562518750628 0.0400202640767276],...
    'String','Ice-covered',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.0288645833333332 0.955420465237464 0.0294270838797093 0.0471124628273791],...
    'String','a',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.358291666666666 0.955420465237464 0.0304687505712112 0.0471124628273791],...
    'String','b',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.687718749999998 0.955420465237464 0.0294270838797093 0.0471124628273791],...
    'String','c',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');

% 创建 textbox
annotation(H1,'textbox',...
    [0.0288645833333332 0.650962511843342 0.0304687505712112 0.0471124628273791],...
    'String','d',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');

% 创建 textbox
annotation(H1,'textbox',...
    [0.358291666666666 0.650962511843342 0.0304687505712112 0.0471124628273791],...
    'String','e',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.68771874999999 0.650962511843342 0.0304687505712112 0.0471124628273791],...
    'String','f',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.0288645833333332 0.348024315288126 0.0294270838797093 0.0471124628273791],...
    'String','h',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.358291666666666 0.348024315288126 0.0294270838797093 0.0471124628273791],...
    'String','i',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.68771874999999 0.348024315288126 0.0294270838797093 0.0471124628273791],...
    'String','g',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
%% 保持图片
set(gcf,'PaperPositionMode','auto');
print('-djpeg', '-r600', [mo_path, 'FS5_Models_ Calibartion_point']);
