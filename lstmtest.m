clear
close all
%% 数据读取
geshu=200;%训练集的个数
%读取数据

data=xlsread('G:\projects\论文撰写\GPM的降尺度分析\青藏高原\青藏高原英文论文相关数据\几种修正结果\GAMA修正-LOCI.xlsx','合并','B2:D1461');
shuru=data(:,1);
shuchu=data(:,2);
nn = randperm(size(shuru,1));%随机排序
% nn=1:size(shuru,1);%正常排序
input_train=shuru(nn(1:geshu));
input_train=input_train';
output_train=shuchu(nn(1:geshu));
output_train=output_train';
input_test =shuru(nn((geshu+1):end));
input_test=input_test';
output_test=shuchu(nn((geshu+1):end));
output_test=output_test';
%样本输入输出数据归一化
[aa,bb]=mapminmax([input_train input_test]);
[cc,dd]=mapminmax([output_train output_test]);
global inputn outputn shuru_num shuchu_num
[inputn,inputps]=mapminmax('apply',input_train,bb);
[outputn,outputps]=mapminmax('apply',output_train,dd);

%TSO_LSTM
clear all;
close all;
clc;
Particles_no = 10; % 种群数量 50
Function_name=‘LSTM_MIN’;
Max_iter = 3; % 迭代次数 10
Low = [10 0.001 10 ];%三个参数的下限
Up = [200 0.02 200 ];%三个参数的上限
Dim = 3;%待优化参数数量
fobj = @(x)LSTM_MIN(x);
train_x=input(:,1:n);
train_y=output(:,1:n);
test_x=input(:,n+1:end);
test_y=output(:,n+1:end);
method=@mapminmax;
% method=@mapstd;
[train_x,train_ps]=method(train_x);
test_x=method(‘apply’,test_x,train_ps);
[train_y,output_ps]=method(train_y);
test_y=method(‘apply’,test_y,output_ps);
XTrain = double(train_x) ;
XTest = double(test_x) ;
YTrain = double(train_y);
YTest = double(test_y);
numFeatures = size(XTrain,1); %输入特征维数
numResponses = size(YTrain,1);%输出特征维数
layers = [ …
sequenceInputLayer(numFeatures)%输入层，参数是输入特征维数
lstmLayer(Tuna1(1,1))%lstm层，如果想要构建多层lstm，改几个参数就行了
fullyConnectedLayer(numResponses)%全连接层，也就是输出的维数
regressionLayer];%该参数说明是在进行回归问题，而不是分类问题
options = trainingOptions(‘adam’, …%求解器设置为’adam’
‘MaxEpochs’,Tuna1(1,3), …%这个参数是最大迭代次数，即进行200次训练，每次训练后更新神经网络参数
‘MiniBatchSize’,16, …%用于每次训练迭代的最小批次的大小。
‘InitialLearnRate’,Tuna1(1,2), …%学习率
‘GradientThreshold’,1, …%设置梯度阀值为1 ，防止梯度爆炸
‘Verbose’,false, …%如果将其设置为true，则有关训练进度的信息将被打印到命令窗口中。
‘Plots’,‘training-progress’);%构建曲线图
%对每个时间步进行预测，对于每次预测，使用前一时间步的观测值预测下一个时间步。
net = trainNetwork(XTrain,YTrain,layers,options);
numTimeStepsTest = size(XTest,2);
for i = 1:numTimeStepsTest
[net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),‘ExecutionEnvironment’,‘cpu’);
end
% 结果
% 反归一化
predict_value=method(‘reverse’,YPred,output_ps);
predict_value=double(predict_value);
true_value=method(‘reverse’,YTest,output_ps);
true_value=double(true_value);
for i=1
figure
plot(true_value(i,:),’-’,‘linewidth’,2)
hold on
plot(predict_value(i,:),’-s’,‘linewidth’,2)
legend(‘实际值’,‘预测值’)
grid on
title(‘TSO-LSTM预测结果’)
ylim([-500 500])
rmse=sqrt(mean((true_value(i,:)-predict_value(i,:)).^2));
disp([’-----------’,num2str(i),’------------’])
disp([‘均方根误差(RMSE)：’,num2str(rmse)])
mae=mean(abs(true_value(i,:)-predict_value(i,:)));
disp([‘平均绝对误差（MAE）：’,num2str(mae)])
mape=mean(abs((true_value(i,:)-predict_value(i,:))./true_value(i,:)));
disp([‘平均相对百分误差（MAPE）：’,num2str(mape100),’%’])
r2=R2(true_value(i,:),predict_value(i,:));
disp([‘R-square决定系数（R2）：’,num2str(r2)])
end




