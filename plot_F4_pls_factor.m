clear,clc
close all
%%
in_path='E:\Paper\Lake_ET\ET_ICE_Cover\odata\Site_ICP\For_R\';
mo_path='E:\Paper\Lake_ET\ET_ICE_Cover\images\imges_v1\';
[data1,~,data_text1]=xlsread([in_path,'R_result.xlsx'],'IF');
[data2,~,data_text2]=xlsread([in_path,'R_result.xlsx'],'IC');
plsdata=nan(9,4);
plsdata(1:end-1,1)=data1(44:51,5);
plsdata(1:end-1,2)=data1(44:51,9);
plsdata(:,3)=data2(47:55,6);
plsdata(:,4)=data2(47:55,10);
Yna={'Rn';'¦¤e';'albedo';'WS';'WD';'Pres';'Ta-Ts';'Tl';'ICR'};
Xna={'Ice-free Daytime';'Ice-free Night';'Ice-covered Daytime';'Ice-covered Night'};
%%
%%
Ucolor=[255 69 0]./255;
Bcolor=[240 255 255]./255;
Mcolor = [linspace(Ucolor(1), Bcolor(1), 64); linspace(Ucolor(2), Bcolor(2), 64); linspace(Ucolor(3), Bcolor(3), 64)]';
%%
H1=figure(1);
set(H1,'pos',[ 0.0010    0.0010    1.5360    0.7896]*1000);
h1=axes(H1,'pos',[-0.17,0.13,1.5,0.74]);
matrixplot(plsdata','XVarNames',Yna,'YVarNames',Xna,...
    'ColorBar','off');
caxis([-0.2,0.6]);
% colormap('jet');
colormap(flipud(Mcolor));
bar=colorbar;
set(bar,'location','southoutside');
set(bar, 'fontsize',16,'FontWeigh','bold' )
set(bar,'Position',[0.172395833333333 0.0959979736575482 0.815625 0.0371496269624349]);
% ´´½¨ textbox
annotation(H1,'textbox',...
    [0.568708333333331 0 0.0393229174489776 0.0562310040782167],...
    'String',{'Sensitivity Coefficient'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',18,...
    'FontName','Arial');
%%
print('-djpeg','-r600', [mo_path,'F4_PLS_ Factor']);