clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
load([in_path,'Sdata_ICP_Daily_2013_2018.mat'],'Sdate_DDICP','Sdata_DDICP','Sdata_DICP','Sdata_NICP');
load([in_path,'Sdata_Seasons_Daily_2013_2018.mat'],'Sdate_DySea','Sdata_DySea','Sdata_DtSea','Sdata_NSea');

Title1={'QhC02_2014AN';'QhC02_2014IF';'QhC02_2014IC';'QhC02_2014SU';'QhC02_2014AU';'QhC02_2014FF';'QhC02_2014CF';'QhC02_2014TT';...
       'QhC02_2015AN';'QhC02_2015IF';'QhC02_2015IC';'QhC02_2015SU';'QhC02_2015AU';'QhC02_2015FF';'QhC02_2015CF';'QhC02_2015TT';...
       'QhC02_2016AN';'QhC02_2016IF';'QhC02_2016IC';'QhC02_2016SU';'QhC02_2016AU';'QhC02_2016FF';'QhC02_2016CF';'QhC02_2016TT';...
       'QhC02_2017AN';'QhC02_2017IF';'QhC02_2017IC';'QhC02_2017SU';'QhC02_2017AU';'QhC02_2017FF';'QhC02_2017CF';'QhC02_2017TT';...
       'QhC02_2018AN';'QhC02_2018IF';'QhC02_2018IC';'QhC02_2018SU';'QhC02_2018AU';'QhC02_2018FF';'QhC02_2018CF';'QhC02_2018TT'};
%%
DyG_Seasonbox=nan(5,5,400);
Period={'SU';'AT';'FF';'CF';'TT'}; 
PdataDy=[Sdata_DySea(2:end,2:3) Sdata_DDICP(2:end,2:4)];
% PdataDt=[Sdate_DtSea(2:end,2:3) Sdata_DICP(2:end,3:5)];
% PdataN=[Sdate_NSea(2:end,2:3) Sdata_NICP(2:end,3:5)];

for i =1:5
    for j = 1:5
        Dyi=PdataDy{i,j};

     DyG_Seasonbox(i,j,1:length(Dyi(:,3)))=Dyi(:,3)';
    end
end
%%
H1=figure(1);
set(H1,'pos',[0.0026    0.1762    1.5288    0.4632]*10^3);
ha = tight_subplot(1,1,[.1 .055],[.12 .05],[.05 .01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
% set(ha,'pos',[0.0895348837209302 0.0914076782449726 0.88953488372093 0.877513711151737])
xset=[1 2 3 4 5];
axes(ha(1));
x1=0:0.01:5.5;
y0=0.*x1;
 h = boxplot2(DyG_Seasonbox,xset);
 cmap = get(0, 'defaultaxescolororder');
for ii = 1:5
    structfun(@(x) set(x(ii,:), 'color', cmap(ii,:), ...
        'markeredgecolor', cmap(ii,:)), h);
end
set([h.lwhis h.uwhis], 'linestyle', '-');
set([h.ladj h.uadj], 'linestyle', 'none');
set(h.out, 'marker', 'none');
set(h.box, 'linewidth', 1.5);
hold on
plot(x1,y0,'k--','linewidth', 1.5);
ylim([-300 500])
xlim([0.5 5.5])
 set(gca, 'FontSize',16,'XTick',[1 2 3 4 5 6],'XTickLabel',{'2014/2015';'2015/2016';'2016/2017';'2017/2018';'2018/2019'});
 set(gca, 'FontSize',16,'YTick',-200:100:400,'YTickLabel',{'-200';'-100';'0';'100';'200';'300';'400'});
 set(gca,'fontsize',16,'Fontname','Arial','FontWeight','bold');
 ylabel('\fontname{Arial}G (W m^-^2 d^-^1)', 'fontsize',16,'FontWeigh','bold');
 xlabel('\fontname{Arial}Year','FontSize',14,'FontWeight','bold'); 
 set(gca,'linewidth',1.2);
box on
  HL=legend(h.box(1:5),{'Summer','Autumn','Freeze','Complete Freeze','Thaw'});
 set(HL,'Position',[0.0547470075600145 0.701099103321225 0.131214026404201 0.246113995196288],...
 'fontsize',12,'Fontname','Arial','FontWeight','bold','Box','off','Color','none');
box on
%%
print('-djpeg','-r600', [o_path,'FS2_seasonal_G_box1']);
