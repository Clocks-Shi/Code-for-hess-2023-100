clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\Winter_ET\o_data\Tables\';
o_path='E:\Paper\Lake_ET\Winter_ET\o_image\';
[data,text,data_text]=xlsread([in_path,'Means.xlsx'],'G_sum');
Qh_ET_mean{1}=data(1:6,7:9);
Qh_ET_mean{2}=data(9:14,7:9);
Qh_ET_mean{3}=data(17:22,7:9);
%%
x(1:6,1)=[1;2;3;4;5;6]-0.2;
x(1:6,2)=[1;2;3;4;5;6];
x(1:6,3)=[1;2;3;4;5;6]+0.2;
for i =1:3
H1=figure(i);
ET_mean=Qh_ET_mean{i};
h=bar(ET_mean);
 cmap = get(0, 'defaultaxescolororder');
for ii = 1:3
    h(ii).FaceColor=cmap(ii,:);
    h(ii).EdgeColor=cmap(ii,:); 
    hold on 
    H=plot(x(:,ii),ET_mean(:,ii),'Color',cmap(ii,:),'linewidth',1.2);
end

ylim([-200 400])
xlim([0.5 6.5])
 set(gca, 'FontSize',16,'XTick',[1 2 3 4 5 6],'XTickLabel',{'2013';'2014';'2015';'2016';'2017';'2018'});
 set(gca, 'FontSize',16,'YTick',-150:50:150,'YTickLabel',{'-150';'-100';'-50';'0';'50';'100';'150'});
 set(gca,'fontsize',16,'Fontname','Arial','FontWeight','bold');
 ylabel('\fontname{Arial}G (W m^-^2)', 'fontsize',16,'FontWeigh','bold');
 xlabel('\fontname{Arial}Year','FontSize',14,'FontWeight','bold'); 
 set(gca,'linewidth',1.2);
 box on

%   if i ==1
 HL=legend(h,{'Annual','Ice Free','Ice Cover'});
 set(HL,'Position',[0.175532590640965 0.672527674749798 0.22107143167087 0.246113995196288],...
 'fontsize',12,'Fontname','Arial','FontWeight','bold','Box','off','Color','none');
 print('-djpeg','-r600', [o_path,'Mean_G_Season',num2str(i)]);
%   else
%  print('-djpeg','-r600', [o_path,'Mean_CO2_Season',num2str(i)]);  
%   end
end

