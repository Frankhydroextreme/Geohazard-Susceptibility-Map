%%%% 基于粒子群算法优化lstm预测单序列
clc
clear all
close all
data=xlsread('G:\projects\论文撰写\GPM的降尺度分析\青藏高原\青藏高原英文论文相关数据\几种修正结果\GAMA修正-LOCI.xlsx','合并','B2:D1461');
input=data(:,1:2);
output=data(:,3);
train_x=input((1:600),:)';
train_y=output((1:600),:)';
test_x=input(601:end,:)';
test_y=output(601:end,:)';

method=@mapminmax;
[train_x,train_ps]=method(train_x);
test_x=method('apply',test_x,train_ps);
[train_y,output_ps]=method(train_y);
test_y=method('apply',test_y,output_ps);
XTrain = double(train_x) ;
XTest = double(test_x) ;
YTrain = double(train_y);
YTest = double(test_y);

numFeatures = size(XTrain,1); %输入特征维数
numResponses = size(YTrain,1);%输出特征维数
%%
%创建LSTM回归网络，指定LSTM层的隐含单元个数96*3
%序列预测，因此，输入一维，输出一维
numHiddenUnits = 20*3;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
%% 初始化种群
N = 5;                         % 初始种群个数
d = 1;                          % 空间维数
ger =100;                      % 最大迭代次数
limit = [0.001, 0.01;];                % 设置位置参数限制(矩阵的形式可以多维)
vlimit = [-0.005, 0.005;];               % 设置速度限制
c_1 = 0.8;                        % 惯性权重
c_2 = 0.5;                       % 自我学习因子
c_3 = 0.5;                       % 群体学习因子
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);%初始种群的位置
end
v = 0.005*rand(N, d);                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置
fxm = 1000*ones(N, 1);               % 每个个体的历史最佳适应度
fym = 1000;                      % 种群历史最佳适应度
%% 粒子群工作
iter = 1;
times = 1;
record = zeros(ger, 1);          % 记录器
while iter <= ger
    iter=iter+1;
    for i=1:N
                %指定训练选项，求解器设置为adam， 250 轮训练。
        %梯度阈值设置为 1。指定初始学习率 0.005，在 125 轮训练后通过乘以因子 0.2 来降低学习

options = trainingOptions('adam',...%求解器设置为.adam.
'MaxEpochs',200, ...%这个参数是最大迭代次数，即进行200次训练，每次训练后更新神经网络参数
'MiniBatchSize',10, ...%用于每次训练迭代的最小批次的大小。
'InitialLearnRate',0.005, ...%学习率
'GradientThreshold',1, ...%设置梯度阀值为1 ，防止梯度爆炸
'Verbose',false, ...%如果将其设置为true，则有关训练进度的信息将被打印到命令窗口中。
'Plots','training-progress');%构建曲线图 
    end



disp(['最小值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);
figure
plot(record)
title(['粒子群优化后Error-Cost曲线图，最佳学习率=',num2str(ym)]);
xlabel('迭代次数')
ylabel('误差适应度值')
figure(2)
% subplot(2,1,1)
plot(YTest,'gs-','LineWidth',2)
hold on
plot(YPred_best,'ro-','LineWidth',2)
hold off
legend('观测值','预测值')
xlabel('时间')
ylabel('数据值')
title('粒子群算法优化预测效果图')
