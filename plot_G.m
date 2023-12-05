clear,clc
close all
%% 
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\';
load([in_path,'Site_data_2013_2018_HHours_ICP.mat']);
year=2014:2018;
%%
Data=SdataPH(:,[1 5]);
[m,n]=size(Data);
GmemICP=cell(m,n);
HourRGm=nan(m,n);
HourSGm=nan(m,n);
HourRGstd=nan(m,n);
HourSGstd=nan(m,n);
RGm=nan(m,n);
RGstd=nan(m,n);
SGm=nan(m,n);
SGstd=nan(m,n);
for i =1:m
    for j =1:n
        Dataij=Data{i,j};
        if isnan(Dataij)

        else
            H=Dataij(:,3);
            LE=Dataij(:,4);
            Rn=Dataij(:,5);
            G=Rn-H-LE;
            Gd=reshape(G,48,length(G)/48);
            HourRG=nan(size(Gd,2),1);
            HourSG=nan(size(Gd,2),1);
            RG=nan(size(Gd,2),1);
            SG=nan(size(Gd,2),1);
            for ii = 1:size(Gd,2)
                Gdii=Gd(:,ii);
                [mgR,~]=find(Gdii<0);
                [mgS,~]=find(Gdii>=0);
                HourRG(ii)=length(mgR)*0.5;
                HourSG(ii)=length(mgS)*0.5;
                RG(ii)=nanmean(Gdii(mgR));
                SG(ii)=nanmean(Gdii(mgS));
            end
            HourRGm(i,j)=nanmean(HourRG);
            HourSGm(i,j)=nanmean(HourSG);
            HourRGstd(i,j)=nanstd(HourRG,1);
            HourSGstd(i,j)=nanstd(HourSG,1);
            RGm(i,j)=nanmean(RG.*HourRG*3600/1000000);
            RGstd(i,j)=nanstd(RG.*HourRG*3600/1000000,1);
            SGm(i,j)=nanmean(SG.*HourSG*3600/1000000);
            SGstd(i,j)=nanstd(SG.*HourSG*3600/1000000,1);
          TT=[HourRG HourSG RG SG];
          GmemICP{i,j}=TT;
        end

    end
end
%% anova2
% for ii = 2:6
%     Hoursii=[HourSGm(ii,:)',HourRGm(ii,:)'];
%     Gii=[SGm(ii,:)',RGm(ii,:)'];
%     Gii=abs(Gii);
%     ph=anova2(Hoursii);
%     pg=anova2(Gii);
%     
% end
%%
H1=figure(1);
set(H1,'pos',[491.4000   25.0000  729.6000  758.4000]);
ha = tight_subplot(2,1,[.01 .03],[.08 .02],[0.1 0.01]); % 行间隔，列间隔，距下边界，上边界，左边界，右边界
xy=1:5;
axes(ha(1));
h1=bar(xy,HourSGm(2:end,:));
h1(1).FaceColor=[255 0 0]./255; h1(2).FaceColor=[0 100 0]./255;
hold on
numgroups = size(HourSGm(2:end,:), 1);
numbars = size(HourSGm(2:end,:), 2);
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
errorbar(x, HourSGm(2:end,i), HourSGstd(2:end,i), 'k', 'linestyle', 'none', 'lineWidth', 1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
h2=bar(xy,-HourRGm(2:end,:));
h2(1).FaceColor=[238 130 98]./255; h2(2).FaceColor=[154 205 50]./255;
hold on
numgroups = size(HourRGm(2:end,:), 1);
numbars = size(HourRGm(2:end,:), 2);
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
errorbar(x, -HourRGm(2:end,i), HourRGstd(2:end,i), 'k', 'linestyle', 'none', 'lineWidth', 1);
end
set(gca,'fontsize',14,'Fontname','Arail','FontWeight','bold');
ylim([-20 15])
set(gca ,'YTick',-15:5:10);
set(gca ,'YTickLabel',{'15','10','5','0','5','10'});
ylabel('Time (h)','FontWeight','bold','FontSize',16,'FontName','Arial');
set(gca ,'XTickLabel','');
%%
axes(ha(2));
h3=bar(xy,SGm(2:end,:));
h3(1).FaceColor=[255 0 0]./255; h3(2).FaceColor=[0 100 0]./255;
hold on
numgroups = size(SGm(2:end,:), 1);
numbars = size(SGm(2:end,:), 2);
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
errorbar(x, SGm(2:end,i), SGstd(2:end,i), 'k', 'linestyle', 'none', 'lineWidth', 1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
h4=bar(xy,RGm(2:end,:));
h4(1).FaceColor=[238 130 98]./255; h4(2).FaceColor=[154 205 50]./255;
hold on
numgroups = size(RGm(2:end,:), 1);
numbars = size(RGm(2:end,:), 2);
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
errorbar(x, RGm(2:end,i), RGstd(2:end,i), 'k', 'linestyle', 'none', 'lineWidth', 1);
end
hold on
h5=plot(xy-0.25,SGm(2:end,1)+RGm(2:end,1),'color',[255 0 0]./255, 'lineWidth', 1.5);
hold on
h6=plot(xy+0.25,SGm(2:end,2)+RGm(2:end,2),'color',[154 205 50]./255, 'lineWidth', 1.5);

set(gca,'fontsize',14,'Fontname','Arail','FontWeight','bold');
ylim([-15 20])
set(gca ,'YTick',-10:5:15);
% set(gca ,'YTickLabel',{'15','10','5','0','5','10'});
ylabel('G (MJ m^2)','FontWeight','bold','FontSize',16,'FontName','Arial');
set(gca ,'XTickLabel',{'2014/15';'2015/16';'2016/17';'2017/18';'2018/19';},'Fontname','Arial','fontsize',14,'FontWeigh','bold');
xlabel('Year','FontWeight','bold','FontSize',16,'FontName','Arial');
legend = legend([h3 h4],{'Ice-free G>0';'Ice-covered G>0';'Ice-free G<0';'Ice-covered G<0'});
set(legend,...
    'Position',[0.451937152898449 0.0833772842055789 0.536732465603894 0.0628955709783336],...
    'NumColumns',2,...
    'FontSize',14,...
    'EdgeColor','none',...
   'Color','none');
%%
% 创建 textbox
annotation(H1,'textbox',...
    [0.0382807017543859 0.954113923195544 0.06195175553623 0.0490506337664801],...
    'String','a',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
% 创建 textbox
annotation(H1,'textbox',...
    [0.0382807017543859 0.498945146824235 0.0641447380446551 0.0490506337664802],...
    'String','b',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
%% 保持图片
set(gcf,'PaperPositionMode','auto');
print('-djpeg', '-r600', [mo_path, 'G_ Diurnal_Hhours']);
