clear,clc
close all
%% 
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
load([in_path,'Site_data_2013_2018_HHours_ICP.mat']);
year=2014:2018;
LT={'8:00';...
    '12:00';'16:00';'20:00';'24:00';'4:00';'8:00';...
    '12:00';'16:00';'20:00';'24:00';'4:00';'8:00';...
    '12:00';'16:00';'20:00';'24:00';'4:00';'8:00';...
    '12:00';'16:00';'20:00';'24:00';'4:00';'8:00';...
    '12:00';'16:00';'20:00';'24:00';'4:00'};
%%
Data=SdataPH(:,[1 5]);
[m,n]=size(Data);
ttmemICP=cell(m,n);
ttmesICP=cell(m,n);
for i =1:m
    for j =1:n
        Dataij=Data{i,j};
        if isnan(Dataij)
            ttmemICP{i,j}=nan(48,5);
            ttmesICP{i,j}=nan(48,5);
        else
            H=Dataij(:,3);
            LE=Dataij(:,4);
            Rn=Dataij(:,5);
            G=Rn-H-LE;
            Ta=Dataij(:,17);
%             Lamt=(2500.78-2.3601*Ta)*1000;
            Lamt=2.45*1000000;
            E=LE*3600./Lamt;
            ttme=[E,LE,G,H,Rn];
            ttmem=nan(48,5);
            ttmes=nan(48,5);
            for ii =1:5
                ttmeii=ttme(:,ii);
                ttmeiiR=reshape(ttmeii,48,length(ttmeii)/48);
                ttmem(:,ii)=nanmean(ttmeiiR,2);
                ttmes(:,ii)=nanstd(ttmeiiR,1,2);
            end
            ttmemICP{i,j}=ttmem;
            ttmesICP{i,j}=ttmes;
        end
    end
end
ttemplot{1}=[ttmemICP{2,1};ttmemICP{3,1};ttmemICP{4,1};ttmemICP{5,1};ttmemICP{6,1}];
ttemplot{2}=[ttmemICP{2,2};ttmemICP{3,2};ttmemICP{4,2};ttmemICP{5,2};ttmemICP{6,2}];
ttesplot{1}=[ttmesICP{2,1};ttmesICP{3,1};ttmesICP{4,1};ttmesICP{5,1};ttmesICP{6,1}];
ttesplot{2}=[ttmesICP{2,2};ttmesICP{3,2};ttmesICP{4,2};ttmesICP{5,2};ttmesICP{6,2}];
%%
x1=1:240;
x1=x1';
x2=1:240;
x2=x2';
yu=[0.2 150 600 40 700];
yl=[-0.05 -20 -250 -40 -200];
ylab={'E (mm h^-^1)';'LE (W m^-^2)';'G (W m^-^2)';'H (W m^-^2)';'Rn (W m^-^2)'};
plable={'a';'b';'c';'d';'e'};
H1=figure(1);
set(H1,'pos',[ 1          41        1600         783]);
ha = tight_subplot(5,1,[.02 .03],[.03 .02],[0.05 0.01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
for hi = 1:5
    axes(ha(hi));
    ttemif=ttemplot{1}(:,hi);
    ttemic=ttemplot{2}(:,hi);
    ttesif=ttesplot{1}(:,hi);
    ttesic=ttesplot{2}(:,hi);
    ifu=ttemif+0.5*ttesif;
    ifl=ttemif-0.5*ttesif;
    icu=ttemic+0.5*ttesic;
    icl=ttemic-0.5*ttesic;
    xif=[x1;flipud(x1)];
    xic=[x2;flipud(x2)];
    ifforfill=[ifu;flipud(ifl)];
    icforfill=[icu;flipud(icl)];
    h1=plot(x1,ttemif,'LineStyle','-','Color',[255 0 0]./255,'Linewidth',1.2);
    hold on
    fill(xif,ifforfill,[255 0 0]./255,'FaceAlpha',0.5,'EdgeAlpha',0.5,'EdgeColor',[255 0 0]./255,'LineStyle','--');
    h2=plot(x2,ttemic,'LineStyle','-','Color',[0 100 0]./255,'Linewidth',1.2);
    hold on
    fill(xic,icforfill,[0 100 0]./255,'FaceAlpha',0.5,'EdgeAlpha',0.5,'EdgeColor',[0 100 0]./255,'LineStyle','--');
    hold on
    xlim([0 240])  
    h3=plot(0:289,zeros(1,length(0:289)),'LineStyle','--','Color',[1 1 1]./255,'Linewidth',1.2);
    for jj = 1:5
    fill([25+(jj-1)*48 48*jj+1 48*jj+1 25+(jj-1)*48],[yl(hi) yl(hi) yu(hi) yu(hi)],[105 105 105]./255,'FaceAlpha',0.15,'EdgeAlpha',0.4,'EdgeColor',[105 105 105]./255,'LineStyle','--');
    end
ylim([yl(hi) yu(hi)]); 
set(gca ,'XTick',x2(1:8:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel(ylab{hi},'FontWeight','bold','FontSize',10,'FontName','Arial');
set(gca,'linewidth',1.2);

% 创建 textbox
annotation(H1,'textbox',...
    [0.00723700623700626 0.952490420627719-(hi-1)*0.194 0.0293659049111444 0.0475095793722843],...
    'String',plable{hi},...
    'LineStyle','none',...
    'Interpreter','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
end
axes(ha(5));
set(gca ,'XTickLabel',LT,'Fontname','Arial','fontsize',10,'FontWeigh','bold');
legend = legend([h1 h2],{'Ice-free';'Ice-covered'});
set(legend,...
    'Position',[0.895486831772451 0.135341734478332 0.0913461552340383 0.0527323810998218],...
    'FontSize',10,...
    'EdgeColor','none',...
   'Color','none');
%%
% 创建 line
annotation(H1,'line',[0.24188440748441 0.24188440748441],...
    [0.0294 0.9778],...
    'LineStyle','-','LineWidth',1.0);
% 创建 line
annotation(H1,'line',[0.429904158004163 0.429904158004163],...
    [0.0293742017879949 0.977777777777778],'LineWidth',1);
% 创建 line
annotation(H1,'line',[0.61779397089398 0.61779397089398],...
    [0.0293742017879949 0.977777777777778],'LineWidth',1);
% 创建 line
annotation(H1,'line',[0.805943659043673 0.805943659043673],...
    [0.0293742017879949 0.977777777777778],'LineWidth',1);
 %%
 % 创建 textbox
annotation(H1,'textbox',...
    [0.0502463617463619 0.933333332675629 0.0751039517396701 0.0403575996359951],...
    'String',{'2014/2015'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
      [0.241514553014555 0.933333332675629 0.0751039517396704 0.0403575996359951],...
    'String',{'2015/2016'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.43005405405406 0.933333332675629 0.0751039517396701 0.0403575996359951],...
    'String',{'2016/2017'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.617554054054061 0.933333332675629 0.07510395173967 0.0403575996359951],...
    'String',{'2017/2018'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.806093555093565 0.933333332675629 0.0751039517396701 0.0403575996359951],...
    'String',{'2018/2019'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Arial');
%% 保持图片
set(gcf,'PaperPositionMode','auto');
print('-djpeg', '-r600', [mo_path, 'ICP_ Diurnal_Hhours']);

