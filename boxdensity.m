clear all
clc
close all
data=xlsread('E:\机器学习多灾害敏感性分析\水文灾害链\灾害空间概率文章\投稿准备\all.xls',...
    'all1','N2:R20');

CF=[[145,204,192]/255;[127,171,209]/255;[247,172,83]/255;[236,110,102]/255;[181,206,78]/255;[189,119,149]/255];

subplot(1,2,1)
hb = boxplot(data,...              
                    'Color','k',...                                   %箱体边框及异常点颜色
                    'symbol','.',...                                  %异常点形状
                    'Notch','on',...                                  %异常点形状
                    'OutlierSize',4,...                               %是否是凹口的形式展现箱线图，默认非凹口
                    'labels',{'RA-LA-DF','RA-CO-DF','RA-CO-LA-DF','RA-LA-CO-DF','RA-DF'});
set(hb,'LineWidth',2)                                               %箱型图线宽

%CF = colorplus([107,84,261,201,52]);


h = findobj(gca,'Tag','Box');
for j = 1:min(size(data))
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
hYLabel = ylabel('Probability of cascading geohazards','FontName','Times New Roman','FontSize',28);
hXLabel = xlabel('Types of cascading geohazards','FontName','Times New Roman','FontSize',28);
ylim([0 1]);
set(gca,'YTick',[0:0.2:1]);
set(gca,'FontName','Times New Roman')
set([hYLabel], 'FontName','Times New Roman')
set(gca, 'FontSize', 26)
set([hYLabel], 'FontSize', 26)
set(gcf,'Color',[1 1 1])
text(5,0.9,'(a)','FontSize',30,'fontname','Times New Roman','FontWeight','bold','FontWeight','bold')
set(gca,'LineWidth',2); 
set(gca, 'Box', 'off');
set(gca, 'TickDir', 'out');


subplot(1,2,2)
x1=data(:,1);
x2=data(:,2);
x3=data(:,3);
x4=data(:,4);
x5=data(:,5);
density_x1 = ksdensity(x1);
density_x1(density_x1 < 0) = 0;

density_x2 = ksdensity(x2);
density_x2(density_x2 < 0) = 0;

density_x3 = ksdensity(x3);
density_x3(density_x3 < 0) = 0;

density_x4 = ksdensity(x4);
density_x4(density_x4 < 0) = 0;
density_x5 = ksdensity(x5);
density_x5(density_x5 < 0) = 0;

plot(linspace(min(x1), max(x1), numel(density_x1)), density_x1, 'LineWidth', 2.0,'Color', CF(5, :));
hold on
plot(linspace(min(x2), max(x2), numel(density_x2)), density_x2, 'LineWidth', 2.0,'Color', CF(4, :));
hold on
plot(linspace(min(x3), max(x3), numel(density_x3)), density_x3, 'LineWidth', 2.0,'Color', CF(3, :));
hold on
plot(linspace(min(x4), max(x4), numel(density_x4)), density_x4, 'LineWidth', 2.0,'Color', CF(2, :));
hold on
plot(linspace(min(x5), max(x5), numel(density_x5)), density_x5, 'LineWidth', 2.0,'Color', CF(1, :));

xlabel('Probability of cascading geohazards','FontName','Times New Roman');
ylabel('Probability density','FontName','Times New Roman');
h=legend({'RA-LA-DF','RA-CO-DF','RA-CO-LA-DF','RA-LA-CO-DF','RA-DF'},'FontSize',26,'FontName','Times New Roman','location','northwest');   %右上角标注
set(h,'Box','off');
set(gca, 'FontName','Times New Roman', 'FontSize', 26)
xlim([0, 1]);
text(0.8,3.2,'(b)','FontSize',30,'fontname','Times New Roman','FontWeight','bold')

set(gca,'LineWidth',2); 
set(gca, 'Box', 'off');
set(gca, 'TickDir', 'out');
destination_folder = 'E:\机器学习多灾害敏感性分析\水文灾害链\灾害空间概率文章\投稿准备\Figs';
filename = 'Figure9.tif';
full_path = fullfile(destination_folder, filename);

%saveas(fig, full_path, 'tif',);  % Save the figure
fig = gcf;  % Get current figure handle
%fig.Position = [100, 100, 4250, 850];  % Set position and size
%print(fig, full_path,'-dpng','-r700')%