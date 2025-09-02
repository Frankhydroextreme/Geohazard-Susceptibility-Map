% --------------- 数据准备 ---
function [opt,data] = PrepareData(opt,data)
% 数据滞后构建时间序列数据
data = CreateTimeSeriesData(opt,data); %根据滑动窗口数值即滞后数，将一列数据，转化为样本输入和样本输出

%将数据划分为测试和训练数据
data = dataPartitioning(opt,data); %建立训练集、测试集样本

% LSTM数据形式
data = LSTMInput(data);%数据类型处理， 如输入数据为cell形式，每个cell单元格包含训练样本数量的30*1个数据
end