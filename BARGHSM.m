clc
clear all
inda=[0.73	0.09	0.07	0.06	0.05
0.24	0.08	0.09	0.1	0.48
0.01	0.01	0.01	0.01	0.98
0.18	0.09	0.1	0.13	0.5
0.81	0.08	0.06	0.03	0.02
0.6	0.1	0.08	0.06	0.17
0.19	0.1	0.06	0.09	0.54
0.56	0.1	0.09	0.08	0.18
0.79	0.08	0.06	0.04	0.03
0.65	0.1	0.08	0.05	0.11
0.26	0.14	0.08	0.12	0.4
0.64	0.09	0.08	0.07	0.12
]*100;
C1=[84,179,69]./255;
C2=[50,184,151]./255;
C3=[5,185,226]./255;
C4=[137,131,191]./255;
C5=[239 122 109]/255;

all=imread('F:\Workprojects\RFmodel\randomforest-matlab\RF_Reg_C\Results\two\7-3-1\Clip\low\all.tif.tif');
bengta=imread('F:\Workprojects\RFmodel\randomforest-matlab\RF_Reg_C\Results\two\7-3-1\Clip\low\bengta.tif.tif');
landbengta=imread('F:\Workprojects\RFmodel\randomforest-matlab\RF_Reg_C\Results\two\7-3-1\Clip\low\landbengta.tif.tif');
dimiantaxian=imread('F:\Workprojects\RFmodel\randomforest-matlab\RF_Reg_C\Results\two\7-3-1\Clip\low\dimiantaxian.tif.tif');
landcover=imread('F:\Workprojects\RFmodel\randomforest-matlab\RF_Reg_C\Results\two\7-3-1\Clip\low\ygalandcover.tif.tif.tif');
all(all<0)=0;
bengta(bengta<0)=0;
landbengta(landbengta<0)=0;
dimiantaxian(dimiantaxian<0)=0;

index1=find(landcover==50);
index2=find(landcover==10);
index3=find(landcover~=50);
% 找到最大序列长度
max_length = max([length(index1), length(index2), length(index3)]);
all1=all(index1);
all2=all(index2);
all3=all(index3);
% 补充 nan
all1(end+1:max_length) = nan;
all2(end+1:max_length) = nan;
all3(end+1:max_length) = nan;

% 构成矩阵
allsum = [all1, all2,all3];
clear all1 all2 all3

landbengta1=landbengta(index1);
landbengta2=landbengta(index2);
landbengta3=landbengta(index3);
landbengta1(end+1:max_length) = nan;
landbengta2(end+1:max_length) = nan;
landbengta3(end+1:max_length) = nan;
landsum = [landbengta1, landbengta2,landbengta3];
clear landbengta1 landbengta2 landbengta3

bengta1=bengta(index1);
bengta2=bengta(index2);
bengta3=bengta(index3);
bengta1(end+1:max_length) = nan;
bengta2(end+1:max_length) = nan;
bengta3(end+1:max_length) = nan;
bengtasum = [bengta1,bengta2,bengta3];
clear bengta1 bengta2 bengta3

dimiantaxian1=dimiantaxian(index1);
dimiantaxian2=dimiantaxian(index2);
dimiantaxian3=dimiantaxian(index3);
dimiantaxian1(end+1:max_length) = nan;
dimiantaxian2(end+1:max_length) = nan;
dimiantaxian3(end+1:max_length) = nan;
dimiantaxiansum = [dimiantaxian1,dimiantaxian2,dimiantaxian3];
clear dimiantaxian1 dimiantaxian2 dimiantaxian3
clear all bengta dimiantaxian landbengta landcover
combinedData = [allsum, landsum, dimiantaxiansum, bengtasum];
%clear allsum landsum bengtasum dimiantaxiansum
clear index1 index2 index3 

subplot(2,2,1)
hb=boxplot(combinedData,...              
                    'Color','k',...                                   
                    'symbol','.',...                                  
                    'Notch','on',...                                  
                    'OutlierSize',4,...                               
                    'labels',{'1', '2', '3','4', '5', '6','7', '8', '9','10', '11', '12'}); 
set(hb,'LineWidth',1.5)  

tickLabels = {'Multi-geohazards', 'Landslide', 'Surface subsidence','Collapse', 'B', 'B', 'C', 'C', 'C', 'D', 'D', 'D'};
set(gca, 'XTickLabel', tickLabels,'FontSize',18,'FontWeight','bold');
h=legend({'Built-up','Vegetation-covered','Non-built'},'FontSize',16,'location','best');   %右上角标注
set(h,'Box','off','Orientation','horizon');
% Adding parallel lines at every third position
% xPositions = [3.5, 6.5, 9.5];
% for i = 1:numel(xPositions)
%     hold on;
%     plot([xPositions(i), xPositions(i)], get(gca, 'YLim'), 'r-','LineWidth',1.5);
% end
% Set the x-axis limits appropriately
xlim([0.5, 12.5]);
xPositions = [2, 5, 8, 11];
xticks(xPositions);

CF = colorplus([53,68,69,53,68,69,53,68,69,53,68,69,53,68,69]);
h = findobj(gca,'Tag','Box');
for j = 1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),CF(j,:),'FaceAlpha',.5);%赋颜色填充箱型图内部
end
% 坐标轴美化
set(gca, 'Box', 'on', ...                                        % 边框
         'LineWidth', 1,...                                      % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
         'TickDir', 'in', 'TickLength', [.015 .015], ...         % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            % 坐标轴颜色

% 背景颜色
hYLabel = ylabel('Susceptibility of geohazards','FontName','Times New Roman','FontSize',18,'FontWeight','bold');
%hXLabel = xlabel('Types of geohazards','FontName','Times New Roman','FontSize',18);
ylim([0 1.0]);
set(gca,'YTick',[0:0.2:1]);
set(gca,'FontName','Times New Roman')
set([hYLabel], 'FontName','Times New Roman')
set(gca, 'FontSize', 18)
set([hYLabel], 'FontSize', 18)
set(gcf,'Color',[1 1 1])
set(gca,'LineWidth',1.5); 
text(1,0.8,'(a)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')

subplot(2,2,2);
h=bar(inda(1:4,:),0.5)
set(gca, 'XTickLabel',{'Multi-geohazard','Landslide','Surface subsidence','Collapse'},'FontSize',18,'fontname','Times New Roman','FontWeight','bold');
ylabel(' Proportion of susceptibility','fontname','Times New Roman','FontSize',18,'FontWeight','bold');
set(gca,'LineWidth',1.5); 
% 设置每个 bar 的颜色
set(h(1), 'FaceColor', C1);
set(h(2), 'FaceColor', C2);
set(h(3), 'FaceColor', C3);
set(h(4), 'FaceColor', C4);
set(h(5), 'FaceColor', C5);

text(1,0.9,'(b)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')

subplot(2,2,3);
h=bar(inda(5:8,:),0.5)
set(gca, 'XTickLabel',{'Multi-geohazard','Landslide','Surface subsidence','Collapse'},'FontSize',18,'fontname','Times New Roman','FontWeight','bold');
ylabel(' Proportion of susceptibility','fontname','Times New Roman','FontSize',18,'FontWeight','bold');

set(gca,'LineWidth',1.5); 
% 设置每个 bar 的颜色
set(h(1), 'FaceColor', C1);
set(h(2), 'FaceColor', C2);
set(h(3), 'FaceColor', C3);
set(h(4), 'FaceColor', C4);
set(h(5), 'FaceColor', C5);

text(1,0.9,'(c)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')

subplot(2,2,4);
h=bar(inda(9:12,:),0.5)
ylim([0 100]);
%set(gca,'YTick',[0:0.2:1],'fontname','Times New Roman','FontWeight','bold','FontSize',18)
set(gca, 'XTickLabel',{'Multi-geohazard','Landslide','Surface subsidence','Collapse'},'FontSize',18,'fontname','Times New Roman','FontWeight','bold');
ylabel(' Proportion of susceptibility','fontname','Times New Roman','FontSize',18,'FontWeight','bold');

set(gca,'LineWidth',1.5); 
% 设置每个 bar 的颜色
set(h(1), 'FaceColor', C1);
set(h(2), 'FaceColor', C2);
set(h(3), 'FaceColor', C3);
set(h(4), 'FaceColor', C4);
set(h(5), 'FaceColor', C5);
h=legend({'Very low', 'Low', 'Moderate','High', 'Very high'},'FontSize',16,'location','best');   
set(h,'Box','off','Orientation','vertical');
text(1,0.9,'(d)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')


