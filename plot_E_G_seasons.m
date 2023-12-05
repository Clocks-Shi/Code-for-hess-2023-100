clear,clc
close all
%% 
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
load([in_path,'Sdata_ICP_Daily_2013_2018.mat'],'Sdata_DDICP','Sdata_DICP','Sdata_NICP',...
    'Sdata_DDICP_YM','Sdata_DICP_YM','Sdata_NICP_YM',...
     'Sdata_DDICP_Ystd','Sdata_DICP_Ystd','Sdata_NICP_Ystd');
year=2014:2018;
%% 
DDET_Seasonbox=nan(5,3,400);
DET_Seasonbox=nan(5,3,400);
NET_Seasonbox=nan(5,3,400);

DDG_Seasonbox=nan(5,3,400);
DG_Seasonbox=nan(5,3,400);
NG_Seasonbox=nan(5,3,400);
for i =1:5
DDETi_IF=Sdata_DDICP{i+1,1}(:,2);
DETi_IF=Sdata_DICP{i+1,1}(:,2);
NETi_IF=Sdata_NICP{i+1,1}(:,2);

DDETi_IC=Sdata_DDICP{i+1,5}(:,2);
DETi_IC=Sdata_DICP{i+1,5}(:,2);
NETi_IC=Sdata_NICP{i+1,5}(:,2);

DDETi_AN=[DDETi_IF;DDETi_IC];
DETi_AN=[DETi_IF;DETi_IC];
NETi_AN=[NETi_IF;NETi_IC];
DDET_Seasonbox(i,1,1:length(DDETi_AN))=DDETi_AN;
DDET_Seasonbox(i,2,1:length(DDETi_IF))=DDETi_IF;
DDET_Seasonbox(i,3,1:length(DDETi_IC))=DDETi_IC;

DET_Seasonbox(i,1,1:length(DETi_AN))=DETi_AN;
DET_Seasonbox(i,2,1:length(DETi_IF))=DETi_IF;
DET_Seasonbox(i,3,1:length(DETi_IC))=DETi_IC;

NET_Seasonbox(i,1,1:length(NETi_AN))=NETi_AN;
NET_Seasonbox(i,2,1:length(NETi_IF))=NETi_IF;
NET_Seasonbox(i,3,1:length(NETi_IC))=NETi_IC;



DDGi_IF=Sdata_DDICP{i+1,1}(:,3);
DGi_IF=Sdata_DICP{i+1,1}(:,3);
NGi_IF=Sdata_NICP{i+1,1}(:,3);

DDGi_IC=Sdata_DDICP{i+1,5}(:,3);
DGi_IC=Sdata_DICP{i+1,5}(:,3);
NGi_IC=Sdata_NICP{i+1,5}(:,3);
DDGi_AN=[DDGi_IF;DDGi_IC];
DGi_AN=[DGi_IF;DGi_IC];
NGi_AN=[NGi_IF;NGi_IC];

DDG_Seasonbox(i,1,1:length(DDGi_AN))=DDGi_AN;
DDG_Seasonbox(i,2,1:length(DDGi_IF))=DDGi_IF;
DDG_Seasonbox(i,3,1:length(DDGi_IC))=DDGi_IC;

DG_Seasonbox(i,1,1:length(DGi_AN))=DGi_AN;
DG_Seasonbox(i,2,1:length(DGi_IF))=DGi_IF;
DG_Seasonbox(i,3,1:length(DGi_IC))=DGi_IC;

NG_Seasonbox(i,1,1:length(NGi_AN))=NGi_AN;
NG_Seasonbox(i,2,1:length(NGi_IF))=NGi_IF;
NG_Seasonbox(i,3,1:length(NGi_IC))=NGi_IC;
end
ET{1}=DDET_Seasonbox;
ET{2}=DET_Seasonbox;
ET{3}=NET_Seasonbox;

G{1}=DDG_Seasonbox;
G{2}=DG_Seasonbox;
G{3}=NG_Seasonbox;
%%  单因子方差分析
for i=1:5
    DCO2_Seasonboxi=squeeze(DDET_Seasonbox(i,:,:));
    DTCO2_Seasonboxi=squeeze(DET_Seasonbox(i,:,:));
    DNCO2_Seasonboxi=squeeze(NET_Seasonbox(i,:,:));
    [~,~,sd]=anova1(DCO2_Seasonboxi');
    [~,~,sdt]=anova1(DTCO2_Seasonboxi');
    [~,~,sdn]=anova1(DNCO2_Seasonboxi');
[cd,~,~,gnamesd] = multcompare(sd);
[cdt,~,~,gnamesdt] = multcompare(sdt);
[cdn,~,~,gnamesdn] = multcompare(sdn);
   AC{1,i}=cd;
   AC{2,i}=cdt;
   AC{3,i}=cdn;
   close all
end
%%
H1=figure(1);
set(H1,'pos',[ 0.0010    0.0010    1.5360    0.7896]*10^3);
ha = tight_subplot(3,2,[.08 .06],[.12 .05],[.04 .01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
% set(ha,'pos',[0.0895348837209302 0.0914076782449726 0.88953488372093 0.877513711151737])
xset=[1 2 3 4 5];
sp1=[1 3 5];
sp2=[2 4 6];
for i = 1:3
axes(ha(sp1(i)));
ET_Seasonboxi=ET{i};
 h = boxplot2(ET_Seasonboxi,xset);
 cmap = get(0, 'defaultaxescolororder');
for ii = 1:3
    structfun(@(x) set(x(ii,:), 'color', cmap(ii,:), ...
        'markeredgecolor', cmap(ii,:)), h);
end
set([h.lwhis h.uwhis], 'linestyle', '-');
set([h.ladj h.uadj], 'linestyle', 'none');
set(h.out, 'marker', 'none');
set(h.box, 'linewidth', 1.5);
ylim([-2 8])
xlim([0.5 5.5])
 set(gca, 'FontSize',14,'XTick',[1 2 3 4 5],'XTickLabel',{'2014/2015';'2015/2016';'2016/2017';'2017/2018';'2018/2019'});
 set(gca, 'FontSize',14,'YTick',0:2:8,'YTickLabel',{'0';'2';'4';'6';'8'});
 set(gca,'fontsize',14,'Fontname','Arial','FontWeight','bold');
 ylabel('\fontname{Arial}ET (mm d^-^1)', 'fontsize',16,'FontWeigh','bold');
 xlabel('\fontname{Arial}Year','FontSize',16,'FontWeight','bold'); 
 set(gca,'linewidth',1.2);
%  HL=legend(h.box(1:3),{'AN','IF','IC'});
%  set(HL,'Position',[0.0547470075600145 0.701099103321225 0.131214026404201 0.246113995196288],...
%  'fontsize',12,'Fontname','Arial','FontWeight','bold','Box','off','Color','none');
box on

axes(ha(sp2(i)));
G_Seasonboxi=G{i};
 hg = boxplot2(G_Seasonboxi,xset);
 cmap = get(0, 'defaultaxescolororder');
for ii = 1:3
    structfun(@(x) set(x(ii,:), 'color', cmap(ii,:), ...
        'markeredgecolor', cmap(ii,:)), hg);
end
set([hg.lwhis hg.uwhis], 'linestyle', '-');
set([hg.ladj hg.uadj], 'linestyle', 'none');
set(hg.out, 'marker', 'none');
set(hg.box, 'linewidth', 1.5);
ylim([-400 600])
xlim([0.5 5.5])
hold on
plot(0.5:0.01:5.5,zeros(length(0.5:0.01:5.5),1),'k--','linewidth',1.5)
 set(gca, 'FontSize',14,'XTick',[1 2 3 4 5],'XTickLabel',{'2014/2015';'2015/2016';'2016/2017';'2017/2018';'2018/2019'});
 set(gca, 'FontSize',14,'YTick',-300:100:400,'YTickLabel',{'-300';'-200';'-100';'0';'100';'200';'300';'400'});
 set(gca,'fontsize',14,'Fontname','Arial','FontWeight','bold');
 ylabel('\fontname{Arial}G (W m^-^2)', 'fontsize',16,'FontWeigh','bold');
 xlabel('\fontname{Arial}Year','FontSize',16,'FontWeight','bold'); 
 set(gca,'linewidth',1.2);
%  HL=legend(h.box(1:3),{'AN','IF','IC'});
%  set(HL,'Position',[0.0547470075600145 0.701099103321225 0.131214026404201 0.246113995196288],...
%  'fontsize',12,'Fontname','Arial','FontWeight','bold','Box','off','Color','none');
box on





end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.00152328623757179 0.934369601363345 0.0295656729717644 0.0803108822290556],...
    'String',{'a'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');

% 创建 textbox
annotation(H1,'textbox',...
    [0.330539508110936 0.934369601363345 0.0306122454718605 0.0803108822290556],...
    'String',{'b'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.661779696493981 0.934369601363345 0.0295656729717644 0.0803108822290556],...
    'String',{'c'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
%%
print('-djpeg','-r600', [mo_path,'F1_seasonal_box1']);

