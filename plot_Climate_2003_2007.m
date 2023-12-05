clear,clc
close all
%%
%%%% MT for IF
%%%% JH for JH
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
load([in_path,'RS_data_ICE2003_2017.mat']);
year=2003:2017;
%%
Qws=0.97;
for i = 1:15
    Rdata_IF=TdataPH{i,1};
    Rdata_IC=TdataPH{i,5};
%%
OTa_IF=1.013.*Rdata_IF(:,1)+0.7067;
OTs_IF=0.7053.*Rdata_IF(:,8)+3.303;
dTas_IF=OTa_IF-OTs_IF;
ORs_IF=0.8565*Rdata_IF(:,4) + 34.63; 
q_IF=Rdata_IF(:,7);
P_IF=Rdata_IF(:,5)./100;
P_IF=0.97.*P_IF+30.72;
ea_IF=6.105.*exp((17.27*OTa_IF)./(OTa_IF+237.7));
es_IF=6.105.*exp((17.27*OTs_IF)./(OTs_IF+237.7));
RH_IF=100*(P_IF.*q_IF)./(0.622.*ea_IF);
RH_IF=0.68.*RH_IF+19.95;
RH_IF=RH_IF./100;
des_IF=Qws.*es_IF-RH_IF.*ea_IF;   
U_IF=Rdata_IF(:,9); 
U_IF=0.60*U_IF+0.96;
%%
OTa_IC=1.013.*Rdata_IC(:,1)+0.7067;
OTs_IC=0.7053.*Rdata_IC(:,8)+3.303;
dTas_IC=OTa_IC-OTs_IC;
ORs_IC=0.8565*Rdata_IC(:,4) + 34.63;
q_IC=Rdata_IC(:,7);
P_IC=Rdata_IC(:,5)./100;
P_IC=0.97.*P_IC+30.72;
ea_IC=6.105.*exp((17.27*OTa_IC)./(OTa_IC+237.7));
es_IC=6.105.*exp((17.27*OTs_IC)./(OTs_IC+237.7));
RH_IC=(P_IC.*q_IC)./(0.622.*ea_IC);
RH_IC=0.68.*RH_IC+19.95;
RH_IC=RH_IC./100;
des_IC=Qws.*es_IC-RH_IC.*ea_IC;   
U_IC=Rdata_IC(:,9); 
U_IC=0.60*U_IC+0.96;
%%
OTa_AN=[OTa_IF;OTa_IC];
OTs_AN=[OTs_IF;OTs_IC];
DTas_AN=[dTas_IF;dTas_IC];
des_AN=[des_IF;des_IC];
P_AN=[P_IF;P_IC];
ORs_AN=[ORs_IF;ORs_IC];
U_AN=[U_IF;U_IC];
%%
OTa_ym(i,1)=nanmean(OTa_AN,1);
OTa_ym(i,2)=nanmean(OTa_IF,1);
OTa_ym(i,3)=nanmean(OTa_IC,1);
%%% Ta = 0.0363 * year -  69.78 (-0.008029, 0.08063) (-158.9, 19.33) R2=0.42 n=15
%%% Ta = -0.01455 * year -  35.58  (-0.08369, 0.05459)  (-103.4, 174.5) R2=-0.32 n=15 
%%% [b,stats]=robustfit(x,y,’wfun’,tune,’const’)

OTs_ym(i,1)=nanmean(OTs_AN,1);
OTs_ym(i,2)=nanmean(OTs_IF,1);
OTs_ym(i,3)=nanmean(OTs_IC,1);

DTas_ym(i,1)=nanmean(DTas_AN,1);
DTas_ym(i,2)=nanmean(dTas_IF,1);
DTas_ym(i,3)=nanmean(dTas_IC,1);

des_ym(i,1)=nanmean(des_AN,1);
des_ym(i,2)=nanmean(des_IF,1);
des_ym(i,3)=nanmean(des_IC,1);

P_ym(i,1)=nanmean(P_AN,1);
P_ym(i,2)=nanmean(P_IF,1);
P_ym(i,3)=nanmean(P_IC,1);

ORs_ym(i,1)=nanmean(ORs_AN,1);
ORs_ym(i,2)=nanmean(ORs_IF,1);
ORs_ym(i,3)=nanmean(ORs_IC,1);

U_ym(i,1)=nanmean(U_AN,1);
U_ym(i,2)=nanmean(U_IF,1);
U_ym(i,3)=nanmean(U_IC,1);

end
Cdata{1}=OTa_ym;
Cdata{2}=OTs_ym;
Cdata{3}=DTas_ym;
Cdata{4}=des_ym;
Cdata{5}=P_ym;
Cdata{6}=ORs_ym;
Cdata{7}=U_ym;
%%
for i = 1: 7
    Cdatai=Cdata{i};
    for j = 1:3
        Cdataij=Cdatai(:,j);
[x1,yfit1,fx1,fy1,p1,r1,Pv1]=SigLine(year',Cdataij,1);
Yfit1(:,j)=yfit1; Fy1(:,j)=fy1; K1(:,j)=p1(1); B1(:,j)=p1(2);
R1(:,j)=r1; P1(:,j)=Pv1;
    end
    PYfit1{i}=Yfit1;
    PFy1{i}=Fy1;
    PK1{i}=K1;
    PB1{i}=B1;
    PR1{i}=R1;
    PP1{i}=P1;    
end
%%
% for i = 1: 4
%     Cdatai=Cdata{i};
%     for j = 1:3
%         Cdataij=Cdatai(:,j);
% allmode=eemd(Cdataij,0.5,10);
% Yfit1(:,j)=allmode(:,4);
%     end
%     PYfit1{i}=Yfit1;
% end
%%
H1=figure(1);
ybl={'Ta (℃)';'Ts (℃)';'Ta-Ts (℃)';'Δe (hPa)'; 'Pres (hPa)';'Rs (W m^-^2)'; 'WS (m s^-^1)'};
set(H1,'position',[ 0.0010    0.0010    1.5360    0.7896].*1000);
ha = tight_subplot(2,4,[.11 .06],[.08 .05],[.05 .04]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
for k = 1: 7
 axes(ha(k));
    Cdatak=Cdata{k};
    PFy1k=PFy1{k};
    PYfit1k=PYfit1{k};
    h1=plot(year,Cdatak(:,1),'LineStyle','-','color',[245 244 145]./255,'LineWidth',0.8);
    hold on
    h2=plot(year,PYfit1k(:,1),'LineStyle','-','color',[250 225 125]./255,'LineWidth',1.2);
    hold on
    fill(fx1,PFy1k(:,1),[250 225 125]./255,'FaceAlpha',0.2,'EdgeAlpha',1,'EdgeColor',[250 225 125]./255,'LineStyle','--'); 
    hold on
    h3=plot(year,Cdatak(:,2),'LineStyle','-','color',[234 203 199]./255,'LineWidth',0.8);
    hold on
    h4=plot(year,PYfit1k(:,2),'LineStyle','-','color',[240 135 165]./255,'LineWidth',1.2);
    hold on
    fill(fx1,PFy1k(:,2),[240 135 165]./255,'FaceAlpha',0.2,'EdgeAlpha',1,'EdgeColor',[240 135 165]./255,'LineStyle','--'); 
    hold on
    h5=plot(year,Cdatak(:,3),'LineStyle','-','color',[165 220 200]./255,'LineWidth',0.8);
    hold on
    h6=plot(year,PYfit1k(:,3),'LineStyle','-','color',[66 131 91]./255,'LineWidth',0.8);
    hold on
    fill(fx1,PFy1k(:,3),[66 131 91]./255,'FaceAlpha',0.2,'EdgeAlpha',1,'EdgeColor',[66 131 91]./255,'LineStyle','--');
    xlabel('\fontname{Arail}Year ');
    xlim([2003,2017]);
    ylabel(ybl{k})
set(gca,'fontsize',16,'Fontname','Arail','FontWeight','bold');
set(get(gca,'XLabel'),'Fontname','Arail','FontSize',16,'FontWeight','bold');
set(gca,'linewidth',1.2);
end
axes(ha(8));
axis off
legend2 = legend([h2,h4,h6],{'Annual','Ice-free','Ice-covered'});
set(legend2,...
    'Position',[0.784922898140488 0.214924847238514 0.131833335463206 0.106605802596448],...
    'NumColumns',1,...
    'EdgeColor','none',...
   'Color','none');
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.023875 0.966262540184772 0.029666667175293 0.0413533841244774],...
    'String',{'a'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail',...
    'FitBoxToText','off');

% 创建 textbox
annotation(H1,'textbox',...
    [0.252791666666668 0.966262540184772 0.0303333338578542 0.0413533841244774],...
    'String',{'b'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail',...
    'FitBoxToText','off');

% 创建 textbox
annotation(H1,'textbox',...
    [0.481687499999999 0.966262540184772 0.0303333338578542 0.0413533841244773],...
    'String',{'c'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail',...
    'FitBoxToText','off');

% 创建 textbox
annotation(H1,'textbox',...
    [0.715812500000001 0.966262540184772 0.0303333338578541 0.0413533841244775],...
    'String',{'d'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.023875 0.474367909992271 0.029666667175293 0.0413533841244776],...
    'String',{'e'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.252791666666668 0.474367909992271 0.029666667175293 0.0413533841244776],...
    'String',{'f'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail',...
    'FitBoxToText','off');
% 创建 textbox
annotation(H1,'textbox',...
    [0.481687499999999 0.474367909992271 0.029666667175293 0.0413533841244776],...
    'String',{'g'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arail',...
    'FitBoxToText','off');
%% 保持图片
set(gcf,'PaperPositionMode','auto');
print('-djpeg', '-r600', [mo_path 'FigS7_Climate_Ts_Ta']);

