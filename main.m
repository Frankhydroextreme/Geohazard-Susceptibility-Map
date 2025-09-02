%% --------------- 5.加载数据
data = loadData(opt); %导入数据，案例数据为一列数据 ，A2:A145共 144个数据。
if ~data.isDataRead %表示如果数据已经被打开了，那么不会重复导入数据
return;
end

%% --------------- 6.数据样本处理
[opt,data] = PrepareData(opt,data);

%% --------------- 7.使用贝叶斯优化找到最佳 LSTM 参数

[opt,data] = OptimizeLSTM(opt,data); 