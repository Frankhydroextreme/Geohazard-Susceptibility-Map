function [opt,data] = OptimizeLSTM(opt,data)
if opt.isDispOptimizationLog %如果展示过程运行日志，则isLog为2，不展示则为0
    isLog = 2;
else
    isLog = 0;
end
if opt.isUseOptimizer%如果运用贝叶斯优化
    opt.ObjFcn  = ObjFcn(opt,data);%目标函数构建（目标函数较为复杂，包含预设几层LSTM结构，是否是Bilstm结构等，不过多介绍）
    BayesObject = bayesopt(opt.ObjFcn,opt.optimVars, ...
        'MaxTime',opt.MaxOptimizationTime, ... %运行最长时间
        'IsObjectiveDeterministic',false, ...%目标动态变化
        'MaxObjectiveEvaluations',opt.MaxItrationNumber,...%最大迭代次数
        'Verbose',isLog,...%运行日志
        'UseParallel',false);%并行运算
end
end
ObjFcn.m部分关键代码
% --------------- 训练网络
try
    data.BiLSTM.Net = trainNetwork(data.XTr,data.YTr,opt.layers,opt.opts); %如果网络建立没问题，则运行成功
    disp('LSTM Netwwork successfully trained.');
    data.IsNetTrainSuccess =true;
catch me
    disp('Error on Training LSTM Network');
    data.IsNetTrainSuccess = false;
    return;
end
close(findall(groot,'Tag','NNET_CNN_TRAININGPLOT_UIFIGURE'))


predict(data.BiLSTM.Net,data.XVl,'MiniBatchSize',opt.miniBatchSize);%将建立好的网络结构，输入验证数据，进行预测
valError = mse(predict(data.BiLSTM.Net,data.XVl,'MiniBatchSize',opt.miniBatchSize)-data.YVl);
%误差为预测测试集输出数据与实际测试集输出数据的均方根误差

Net  = data.BiLSTM.Net;
Opts = opt.opts;

fieldName = ['ValidationError' strrep(num2str(valError),'.','_')];%每次迭代会将对应的结构和参数进行保存为mat格式，并以误差数值进行命名
if ismember('OptimizedParams',evalin('base','who'))
    OptimizedParams =  evalin('base', 'OptimizedParams');
    OptimizedParams.(fieldName).Net  = Net;
    OptimizedParams.(fieldName).Opts = Opts;
    assignin('base','OptimizedParams',OptimizedParams);
else
    OptimizedParams.(fieldName).Net  = Net;
    OptimizedParams.(fieldName).Opts = Opts;
    assignin('base','OptimizedParams',OptimizedParams);
end

fileName = num2str(valError) + ".mat";
if opt.isSaveOptimizedValue
    save(fileName,'Net','valError','Opts')
end
cons = [];

end