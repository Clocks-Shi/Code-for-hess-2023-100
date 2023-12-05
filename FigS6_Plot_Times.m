clear,clc
close all
%% load
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\indata\';
o_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\';
[da,~,dt]=xlsread([in_path,'20131220-20190403Qinghailake_daily.xlsx']);
[~,~,ICEP]=xlsread([in_path,'2002_2018Qinghailake_ICEP.xlsx'],'ICEP');
date=dt(4:end,1);
date_vec=datevec(date);        %% 将日期数据转化为年月日分开向量
[m1,n1]=find(date_vec(:,3)==1);
date_L=date(m1);
ICs=[1 370 745 1122 1480 1847];
ICe=[96 467 828 1205 1574 1931];
mycolor=[220 220 220]./255;
%%
H1=figure(1);
set(H1,'pos',[ 1          41        1600         783]);
ha = tight_subplot(3,1,[.04 .03],[.03 .02],[0.05 0.01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
 axes(ha(1));
h1=plot(da(:,2));
set(h1,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[0;0;8;8],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=0:0.1:8;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
hold on

xlim([97 1931]);
ylim([0 8]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('E (mm day^-^1)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 axes(ha(2));
h2=plot(da(:,5));
set(h2,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[0;0;250;250],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=0:0.1:250;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
hold on

xlim([97 1931]);
ylim([0 250]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('LE (W m^-^2)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 axes(ha(3));
 h3=plot(da(:,4));
set(h3,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[-40;-40;60;60],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=-40:0.1:60;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
hold on

xlim([97 1931]);
ylim([-40 60]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('H (W m^-^2)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.007875 0.971902938257537 0.0240624994691461 0.0408684538242005],...
    'String',{'a'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.007875 0.647509579381416 0.0246874994505197 0.0408684538242005],...
    'String',{'b'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.007875 0.311621967631739 0.0240624994691461 0.0408684538242005],...
    'String',{'c'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.0545343035343056 0.918518517690332 0.0943347214289366 0.0475095793722843],...
    'String',{'2014/2015'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.243333679833684 0.918518517690332 0.0943347214289366 0.0475095793722843],...
    'String',{'2015/2016'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.42797505197506 0.918518517690332 0.0943347214289366 0.0475095793722843],...
    'String',{'2016/2017'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.621971933471943 0.918518517690332 0.0943347214289366 0.0475095793722843],...
    'String',{'2017/2018'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.811031185031198 0.918518517690332 0.0943347214289366 0.0475095793722843],...
    'String','2018/2019',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial',...
    'FitBoxToText','off');
print('-dpng','-r600',[o_path, 'FSY_Diily_Timeserise1']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% figure part(2)
H2=figure(2);
set(H2,'pos',[ 1          41        1600         783]);
ha1 = tight_subplot(3,1,[.04 .03],[.03 .02],[0.05 0.01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
 axes(ha1(1));
  h21=plot(da(:,3));
set(h21,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[-300;-300;300;300],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=-300:0.1:300;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
hold on
xx=1:1931;
yz=zeros(1931);
hx=plot(xx,yz,'k--','LineWidth',1.2);
xlim([97 1931]);
ylim([-300 300]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('G (W m^-^2)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 axes(ha1(2));
   h22=plot(da(:,6));
set(h22,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[-50;-50;300;300],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=-50:0.1:300;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
hold on
xx=1:1931;
yz=zeros(1931);
hx=plot(xx,yz,'k--','LineWidth',1.2);
xlim([97 1931]);
ylim([-50 300]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('Rn (W m^-^2)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
 box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 axes(ha1(3));
 h23=plot(da(:,7:10),'-');
set(h23(1),'color',[30 144 255]/255);
set(h23(2),'color',[255 106 106]/255);
set(h23(3),'color',[67 205 128]/255);
set(h23(4),'color',[255 165 0]/255);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[0;0;500;500],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=0:0.1:500;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
xlim([97 1931]);
ylim([0 500]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('Radiation (W m^-^2)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
 HL2=legend(h23(1:4),{'dRs','uRs','dRl','uRl'});
  set(HL2, 'fontsize',16,'Fontname','Arial','FontWeight','bold','Box','off','Color','none');
  set(HL2,  'Position',[0.279647433369507 0.262555659480326 0.230249482579142 0.036772217302449],...
    'NumColumns',4,...
    'FontSize',16,...
    'FontName','Arial',...
    'Color','none');
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 创建 textbox
annotation(H2,'textbox',...
    [0.007875 0.971902938257537 0.0240624994691461 0.0408684538242005],...
    'String',{'d'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
% 创建 textbox
annotation(H2,'textbox',...
    [0.007875 0.647509579381416 0.0246874994505197 0.0408684538242005],...
    'String',{'e'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
% 创建 textbox
annotation(H2,'textbox',...
    [0.007875 0.311621967631739 0.0240624994691461 0.0408684538242005],...
    'String',{'f'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
print('-dpng','-r600',[o_path, 'FSY_Diily_Timeserise2']);
%% figure part(3)
Ta=da(:,18);
Ts=da(:,19);
Tl=nanmean(da(:,20:24),2);
RH=(da(:,27)+da(:,28))/200;
A=da(:,13);
WS=da(:,14);
WD=da(:,15);
P=da(:,16);
Ta_Ts=Ta-Ts;
es=0.6105.*exp((17.27*Ts)./(Ts+237.7));
ea=RH*0.6105.*exp((17.27*Ta)./(Ta+237.7));
es_ea=es-ea;
H3=figure(3);
set(H3,'pos',[ 1          41        1600         783]);
ha1 = tight_subplot(3,1,[.04 .03],[.08 .02],[0.05 0.01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
 axes(ha1(1));
  h31=plot(es_ea);
set(h31,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[0;0;1.5;1.5],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=0:0.1:1.5;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
xlim([97 1931]);
ylim([0 1.5]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('Δe (hPa)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 axes(ha1(2));
   h32=plot(WS);
set(h32,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[0;0;10;10],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=0:0.1:10;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
xlim([97 1931]);
ylim([0 10]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel','');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('WS (m s^-^1)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
 box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 axes(ha1(3));
   h32=plot(Ta_Ts);
set(h32,'color',[30 144 255]/255,'LineStyle','-','LineWidth',1.5);
hold on
  for i=1:6
fill([ICs(i);ICe(i);ICe(i);ICs(i)],[-15;-15;10;10],mycolor,'FaceAlpha',0.5,'EdgeAlpha',0,'EdgeColor',[100 149 237]./255,'LineStyle','none')
hold on
yy=-15:0.1:10;
ny=length(yy);
hy=plot(ones(ny,1)*ICe(i),yy,'k--','LineWidth',1.2);
  end
  hold on
xx=1:1931;
yz=zeros(1931);
hx=plot(xx,yz,'k--','LineWidth',1.2);
xlim([97 1931]);
ylim([-15 10]);
set(gca ,'XTick',m1(1:2:end));
set(gca ,'XTickLabel',date_L(1:2:end),'Fontname','Arial','fontsize',10,'FontWeigh','bold');
set(gca,'fontsize',10,'Fontname','Arail','FontWeight','bold');
ylabel('Ta-Ts (°C)','FontWeight','bold','FontSize',14,'FontName','Arial');
set(gca,'linewidth',1.2);
xtickangle(45)
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 创建 textbox
annotation(H3,'textbox',...
    [0.007875 0.96934865984119 0.0240624994691461 0.0408684538242005],...
    'String',{'g'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
% 创建 textbox
annotation(H3,'textbox',...
    [0.007875 0.661558110671327 0.0246874994505197 0.0408684538242003],...
    'String',{'h'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
% 创建 textbox
annotation(H3,'textbox',...
    [0.007875 0.346104726252429 0.0240624994691461 0.0408684538242006],...
    'String',{'i'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FontName','Arial');
print('-dpng','-r600',[o_path, 'FSY_Diily_Timeserise3']);





