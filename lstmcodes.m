clc; clear; close all;
%TSO_LSTM
clear all;
close all;
clc;

fobj = @(x)LSTM_MIN(x);
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
%搭建LSTM网络
layers = [ ...
sequenceInputLayer(numFeatures)%输入层，参数是输入特征维数
lstmLayer(128)%lstm层，如果想要构建多层lstm，改几个参数就行了
fullyConnectedLayer(numResponses)%全连接层，也就是输出的维数
regressionLayer];%该参数说明是在进行回归问题，而不是分类问题

options = trainingOptions('adam',...%求解器设置为.adam.
'MaxEpochs',200, ...%这个参数是最大迭代次数，即进行200次训练，每次训练后更新神经网络参数
'MiniBatchSize',100, ...%用于每次训练迭代的最小批次的大小。
'InitialLearnRate',0.005, ...%学习率 %指定初始学习率 0.005，在 125 轮训练后通过乘以因子 0.2 来降低学习率。
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',125, ...
    'LearnRateDropFactor',0.2, ...
'GradientThreshold',1, ...%设置梯度阀值为1 ，防止梯度爆炸
'Verbose',false, ...%如果将其设置为true，则有关训练进度的信息将被打印到命令窗口中。
'Plots','training-progress');%构建曲线图 
%  隐藏层节点个数                
%对每个时间步进行预测，对于每次预测，使用前一时间步的观测值预测下一个时间步。
%对于大型数据集合、长序列或大型网络，在 GPU 上进行预测计算通常比在 CPU 上快。
%其他情况下，在 CPU 上进行预测计算通常更快。
%对于单时间步预测，请使用 CPU。
%使用 CPU 进行预测，请将 predictAndUpdateState 的 'ExecutionEnvironment' 选项设置为 'cpu'。

net = trainNetwork(p_train,t_train,layers,options);
numTimeStepsTest = size(p_test,2);
for i = 1:numTimeStepsTest
[net,YPred(:,i)] = predictAndUpdateState(net,p_test(:,i),'ExecutionEnvironment','gpu');
end

numTimeStepsTest1 = size(p_train1,2);
for i = 1:numTimeStepsTest1
[net,YPred1(:,i)] = predictAndUpdateState(net,p_train1(:,i),'ExecutionEnvironment','gpu');
end

% 结果
% 反归一化
predict_value=method('reverse',YPred,ps_output);
predict_value=double(predict_value);
true_value=method('reverse',t_test,ps_output);
true_value=double(true_value);
for i=1
figure
plot(true_value(i,:),'-','linewidth',2)
hold on
plot(predict_value(i,:),'-s','linewidth',2)
legend('实际值','预测值')
grid on
title('LSTM预测结果')
ylim([0 12])
rmse=sqrt(mean((true_value(i,:)-predict_value(i,:)).^2));
disp(['-----------',num2str(i),'------------'])
disp(['均方根误差(RMSE)：',num2str(rmse)])
mae=mean(abs(true_value(i,:)-predict_value(i,:)));
disp(['平均绝对误差（MAE）：',num2str(mae)])
mape=mean(abs((true_value(i,:)-predict_value(i,:))./true_value(i,:)));
disp(['平均相对百分误差（MAPE）：',num2str(mape*100),'%'])
r2=corr2(true_value(i,:),predict_value(i,:));
disp(['R-square决定系数（R2）：',num2str(r2)])
end









