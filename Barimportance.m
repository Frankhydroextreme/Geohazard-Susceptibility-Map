clear all
clc
close all

data=xlsread('E:\机器学习多灾害敏感性分析\DATA\数据汇总灾害敏感性比例.xlsx',...
 'Sheet1','B3:I25')';
x = [2:4:92];
figure(1)
subplot(2,3,1)
y=(data(1:2,:)); 
b=barh(x,y);
xlim([0,0.5]);
colors=[[0 161 78]/255;[236 231 15]/255];
%COLOR=[0	0.807843137254902	0.819607843137255
%0.486274509803922	0.988235294117647	0
%0.933333333333333	0.866666666666667	0.509803921568627
%0	0.980392156862745	0.603921568627451]
% b(1).FaceColor = [177 206 70]/255;
% b(2).FaceColor = [99 227 152]/255;
yticklabels({});
b(1).FaceColor = colors(1,:);
%b(2).FaceColor = [50 184 151]/255;
b(2).FaceColor = colors(2,:);
set(gca,'YTick',[2:4:92],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %x轴范围
set(gca,'XTick',[0:0.1:0.6],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %y轴范围
%set(gca,'YTickLabel',{'Impervious' 'Slope' 'Elevation' 'Aspect'  'TWI' 'TPI' 'SPI' 'STI' 'Slope length' 'Profile curvature' 'Population density' 'POI' 'Plan curvature' 'Precipitation' 'NDVI' 'Dis2roads' 'Dis2faults' 'Dis2water' 'SSM' 'Landcovertypes' 'Morphometric features' 'Lithology' 'Soiltypes'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);
labels = {'Impervious' 'Slope' 'Elevation' 'Aspect' 'TWI' 'TPI' 'SPI' 'STI' 'Slope length' 'Profile curvature' 'Population density' 'POI' 'Plan curvature' 'Precipitation' 'NDVI' 'Dis2roads' 'Dis2faults' 'Dis2water' 'SSM' 'Landcovertypes' 'Morphometric features' 'Lithology' 'Soiltypes'};
labels = flip(labels);

%在图形中心添加文本标注
text(0.5, 0.5, strjoin(labels, ' '), ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'fontname', 'Times New Roman', 'FontWeight', 'bold', 'FontSize', 18);


%ylabel('Influencing factors')
xlabel('Importance values of multi-geohazards')
h=legend({'RF','XGBoost',},'FontSize',18,'location','best');   %右上角标注
set(h,'Box','off');
set(gca,'LineWidth',2,'fontname','Times New Roman','FontSize',20,'FontWeight','bold');
text(0.45,90,'(a)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
set(gca, 'Box', 'off');

subplot(2,3,2)
y=(data(3:4,:)); 
b=barh(x,y);
b(1).FaceColor = colors(1,:);
%b(2).FaceColor = [50 184 151]/255;
b(2).FaceColor = colors(2,:);
set(gca,'YTick',[2:4:92],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %x轴范围
set(gca,'XTick',[0:0.1:0.6],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %y轴范围
%set(gca,'YTickLabel',{'Impervious' 'Slope' 'Elevation' 'Aspect'  'TWI' 'TPI' 'SPI' 'STI' 'Slope length' 'Profile curvature' 'Population density' 'POI' 'Plan curvature' 'Precipitation' 'NDVI' 'Dis2roads' 'Dis2faults' 'Dis2water' 'SSM' 'Landcovertypes' 'Morphometric features' 'Lithology' 'Soiltypes'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);

%ylabel('Influencing factors')
yticklabels({});
xlabel('Importance values of landslide')
% h=legend({'RF','XGBoost',},'FontSize',16,'location','best');   %右上角标注
% set(h,'Box','off');
xlim([0,0.5]);
set(gca,'LineWidth',2,'fontname','Times New Roman','FontSize',18,'FontWeight','bold');
text(0.27,90,'(b)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
set(gca, 'Box', 'off');

subplot(2,3,3)
y=(data(5:6,:)); 
b=barh(x,y);
%b(1).FaceColor = [0.933333333333333	0.866666666666667	0.509803921568627];
%b(2).FaceColor = [0	0.980392156862745	0.603921568627451];
b(1).FaceColor = colors(1,:);
%b(2).FaceColor = [50 184 151]/255;
b(2).FaceColor = colors(2,:);
set(gca,'YTick',[2:4:92],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %x轴范围
set(gca,'XTick',[0:0.1:0.6],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %y轴范围
%set(gca,'YTickLabel',{'Impervious' 'Slope' 'Elevation' 'Aspect'  'TWI' 'TPI' 'SPI' 'STI' 'Slope length' 'Profile curvature' 'Population density' 'POI' 'Plan curvature' 'Precipitation' 'NDVI' 'Dis2roads' 'Dis2faults' 'Dis2water' 'SSM' 'Landcovertypes' 'Morphometric features' 'Lithology' 'Soiltypes'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);
%xticks([]);
yticklabels({});
xlim([0,0.5]);
%ylabel('Influencing factors')
xlabel('Importance values of collapse')
% h=legend({'RF','XGBoost',},'FontSize',16,'location','best');   %右上角标注
% set(h,'Box','off');
text(0.32,90,'(c)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',2,'fontname','Times New Roman','FontSize',20,'FontWeight','bold');
set(gca, 'Box', 'off');


subplot(2,3,4)
y=(data(7:8,:)); 
b=barh(x,y);
b(1).FaceColor = colors(1,:);
%b(2).FaceColor = [50 184 151]/255;
b(2).FaceColor = colors(2,:);
set(gca,'YTick',[2:4:92],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %x轴范围
set(gca,'XTick',[0:0.1:0.6],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %y轴范围
set(gca,'YTickLabel',{'Impervious' 'Slope' 'Elevation' 'Aspect'  'TWI' 'TPI' 'SPI' 'STI' 'Slope length' 'Profile curvature' 'Population density' 'POI' 'Plan curvature' 'Precipitation' 'NDVI' 'Dis2roads' 'Dis2faults' 'Dis2water' 'SSM' 'Landcovertypes' 'Morphometric features' 'Lithology' 'Soiltypes'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);
%ylabel('Influencing factors')
xlabel('Importance values of surface subsidence')
yticklabels({});
xlim([0,0.6]);
% h=legend({'RF','XGBoost',},'FontSize',16,'location','best');   %右上角标注
% set(h,'Box','off');
text(0.55,90,'(d)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',2,'fontname','Times New Roman','FontSize',20,'FontWeight','bold');
set(gca, 'Box', 'off');

data=xlsread('E:\机器学习多灾害敏感性分析\DATA\数据汇总灾害敏感性比例.xlsx',...
 'Sheet1','B33:E54')';
x = [2:4:88];

subplot(2,3,5)
y=(data(1:2,:)); 
b=barh(x,y);
b(1).FaceColor = colors(1,:);
%b(2).FaceColor = [50 184 151]/255;
b(2).FaceColor = colors(2,:);

set(gca,'YTick',[2:4:92],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %x轴范围
set(gca,'XTick',[0:0.1:0.6],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %y轴范围
set(gca,'YTickLabel',{'Impervious' 'Slope' 'Elevation' 'Aspect'  'TWI' 'TPI' 'SPI' 'STI' 'Slope length' 'Profile curvature' 'Population density' 'POI' 'Plan curvature' 'Precipitation' 'NDVI' 'Dis2roads' 'Dis2faults' 'Dis2water' 'SSM' 'Morphometric features' 'Lithology' 'Soiltypes'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);
%ylabel('Influencing factors')
xlabel('Urban importance values for multi-geohazards')
yticklabels({});
set(gca, 'Box', 'off');
% h=legend({'RF','XGBoost',},'FontSize',16,'location','best');   %右上角标注
% set(h,'Box','off');
text(0.55,90,'(e)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',2,'fontname','Times New Roman','FontSize',20,'FontWeight','bold');
xlim([0,0.6]);

subplot(2,3,6)
y=(data(3:4,:)); 
b=barh(x,y);

b(1).FaceColor = colors(1,:);
%b(2).FaceColor = [50 184 151]/255;
b(2).FaceColor = colors(2,:);
set(gca,'YTick',[2:4:92],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %x轴范围
set(gca,'XTick',[0:0.1:0.6],'fontname','Times New Roman','FontWeight','bold','FontSize',18) %y轴范围

set(gca,'YTickLabel',{'Impervious' 'Slope' 'Elevation' 'Aspect'  'TWI' 'TPI' 'SPI' 'STI' 'Slope length' 'Profile curvature' 'Population density' 'POI' 'Plan curvature' 'Precipitation' 'NDVI' 'Dis2roads' 'Dis2faults' 'Dis2water' 'SSM' 'Morphometric features' 'Lithology' 'Soiltypes'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);
%ylabel('Influencing factors')
xlim([0,0.6]);
xlabel('non-urban importance values for multi-geohazards')
% h=legend({'RF','XGBoost',},'FontSize',16,'location','best');   %右上角标注
% set(h,'Box','off');
yticklabels({});
set(gca, 'Box', 'off');
text(0.55,90,'(f)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',2,'fontname','Times New Roman','FontSize',20,'FontWeight','bold');