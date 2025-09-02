function data = loadData(opt)
[chosenfile,chosendirectory] = uigetfile({'*.xlsx';'*.csv'},...%uigetfile函数如果打开了文件，则返回1，如果取消，则返回0
    'Select Excel time series Data sets','data.xlsx');% 选择数据，chosenfile为文件名，chosendirectory为文件所在文件夹路径
filePath = [chosendirectory chosenfile];%filePath为该文件的路径
if filePath ~= 0 % 表示如果数据被打开
    data.DataFileName = chosenfile;%创建data结构数据，包含文件名
    data.CompleteData = readtable(filePath);%创建data结构数据，包含文件路径
    if size(data.CompleteData,2)>1  %判断是否是一列数据
        warning('输入数据应该是一个excel文件且只有一列!');
        disp('Operation Failed... '); pause(.9);
        disp('Reloading data. ');     pause(.9);
        data.x = [];% x数据空白
        data.isDataRead = false;%数据不可阅读
        return;
    end
    data.seriesdataHeder = data.CompleteData.Properties.VariableNames(1,:);%创建data结构数据，包含数据表头标题
    data.seriesdata = table2array(data.CompleteData(:,:));%%创建data结构数据，包含mat格式的序列数据
    disp('Input data successfully read.');%输出 输入数据成功读取
    data.isDataRead = true;%数据读取成功
    data.seriesdata = PreInput(data.seriesdata);%PreInput调用函数，表示如果数据是cell形式，会将cell转化为数值形式
    
    figure('Name','InputData','NumberTitle','off');%绘图 ，时间序列数据绘图， 且标题包含均值和标准值结果
    plot(data.seriesdata); grid minor;
    title({['Mean = ' num2str(mean(data.seriesdata)) ', STD = ' num2str(std(data.seriesdata)) ];});
    if strcmpi(opt.dataPreprocessMode,'None') %判断数据处理形式，此处为无预处理
        data.x = data.seriesdata;
    elseif strcmpi(opt.dataPreprocessMode,'Data Normalization') %判断数据处理形式，此处为归一化预处理
        data.x = DataNormalization(data.seriesdata);
        figure('Name','NormilizedInputData','NumberTitle','off');
        plot(data.x); grid minor;
        title({['Mean = ' num2str(mean(data.x)) ', STD = ' num2str(std(data.x)) ];});
    elseif strcmpi(opt.dataPreprocessMode,'Data Standardization') %判断数据处理形式，此处为标准化预处理
        data.x = DataStandardization(data.seriesdata);
        figure('Name','NormilizedInputData','NumberTitle','off');
        plot(data.x); grid minor;
        title({['Mean = ' num2str(mean(data.x)) ', STD = ' num2str(std(data.x)) ];});
    end
    
else
    warning(['为了训练网络,请加载数据。' ... %此处表示数据没有读取，会进行相关提示。
        '输入数据应该是一个excel文件且只有一个列!']);
    disp('操作取消.');
    data.isDataRead = false;
end
end

