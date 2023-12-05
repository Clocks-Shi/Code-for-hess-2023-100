clear,clc
close all
%%
in_path1='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
in_path2='G:\QHH_LY\Pre_analysis202210\QHHLake\Odata\';
[dd1,~,dt1]=xlsread([in_path1,'20130601-2019629Qinghailake_HalfhourDataICEP.xlsx'],'DataH_Inter');
[dd2,~,dt2]=xlsread([in_path2,'C11_20130511_20210317_EC_Climate_QHH_30min_interp.xlsx'],'Sheet6');
ddt1=dd1(:,3:4);
ddt2=dd2(:,9:10);
%%
x=1:size(ddt2,1);
H1=figure(1);
set(H1,'pos',[0.0010    0.0010    1.5360    0.7896]*1000);
ha = tight_subplot(1,2,[.07 .055],[.12 .05],[.06 .015]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
for j = 1:2
    axes(ha(j));
    h1=plot(x,ddt1(:,j),'b-','linewidth',1.5);
    hold on
    h2=plot(x,ddt2(:,j),'r-','linewidth',1.5);
    set(gca,'fontsize',14,'Fontname','Arail','FontWeight','bold');
    xlabel('Days','FontWeight','bold','FontSize',14,'FontName','Arial');
    if j <2
        ylabel('H (W m^-^2)','FontWeight','bold','FontSize',14,'FontName','Arial');
    else
        ylabel('LE (W m^-^2)','FontWeight','bold','FontSize',14,'FontName','Arial');
    end
end
%%
% print('-dpng','-r300', [o_path,'F_Com_MOD_OBS_8days']);