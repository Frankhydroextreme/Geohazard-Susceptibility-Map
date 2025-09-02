clc; clear; close all;
%TSO_LSTM
clear all;
close all;
clc;

% fobj = @(x)LSTM_MIN(x);
% data=xlsread('G:\projects\论文撰写\GPM的降尺度分析\青藏高原\青藏高原英文论文相关数据\几种修正结果\GAMA修正-LOCI.xlsx','合并','B2:D1461');
% input=data(:,1:2);
% output=data(:,3);
% train_x=input((1:600),:)';
% train_y=output((1:600),:)';
% test_x=input(601:end,:)';
% test_y=output(601:end,:)';
% 
% method=@mapminmax;
% [train_x,train_ps]=method(train_x);
% test_x=method('apply',test_x,train_ps);
% [train_y,output_ps]=method(train_y);
% test_y=method('apply',test_y,output_ps);
% XTrain = double(train_x) ;
% XTest = double(test_x) ;
% YTrain = double(train_y);
% YTest = double(test_y);
DATA=load('hazards2.txt');
matrix=DATA(:,1:23);
label=DATA(:,24);
step1=1:40000000;
step2=40000001:80000000;
step3=80000001:120000000;
step4=120000001:164042708;


impervious=imread('F:\DATA\YGAfactors\15083 10876\ygaimperviousarea.tif');impervious(impervious<0)=nan;impervious=impervious(:);
impervious1=double(impervious((step1),:));
impervious2=double(impervious((step2),:));
impervious3=double(impervious((step3),:));
impervious4=double(impervious((step4),:));

yga_slope=imread('F:\DATA\YGAfactors\15083 10876\yga_slope.tif');yga_slope(yga_slope<0)=nan;yga_slope=yga_slope(:);
yga_slope1=double(yga_slope((step1),:));
yga_slope2=double(yga_slope((step2),:));
yga_slope3=double(yga_slope((step3),:));
yga_slope4=double(yga_slope((step4),:));


[elevation,Ref]=geotiffread('F:\DATA\YGAfactors\15083 10876\yga_elevation.tif');elevation(elevation==-32768)=nan;elevation=elevation(:);
elevation1=double(elevation((step1),:));
elevation2=double(elevation((step2),:));
elevation3=double(elevation((step3),:));
elevation4=double(elevation((step4),:));


%factors1=[impervious1,yga_slope1,elevation1];
%factors2=[impervious2,yga_slope2,elevation2];
factors3=[impervious3,yga_slope3,elevation3];
%factors4=[impervious4,yga_slope4,elevation4];


clear impervious impervious1 impervious2 impervious3 impervious4
clear elevation elevation1 elevation2 elevation3 elevation4
clear yga_slope yga_slope1 yga_slope2 yga_slope3 yga_slope4 


aspect=imread('F:\DATA\YGAfactors\15083 10876\yga_aspect.tif');aspect(aspect<-100000)=nan;aspect=aspect(:);
aspect1=double(aspect((step1),:));
aspect2=double(aspect((step2),:));
aspect3=double(aspect((step3),:));
aspect4=double(aspect((step4),:));



%factors1=[factors1,aspect1];
%factors2=[factors2,aspect2];
factors3=[factors3,aspect3];
%factors4=[factors4,aspect4];

TWI=imread('F:\DATA\YGAfactors\15083 10876\Topographic Wetness Index.tif');TWI(TWI<-100000)=nan;TWI=TWI(:);

TWI1=double(TWI((step1),:));
TWI2=double(TWI((step2),:));
TWI3=double(TWI((step3),:));
TWI4=double(TWI((step4),:));

%factors1=[factors1,TWI1];
%factors2=[factors2,TWI2];
factors3=[factors3,TWI3];
%factors4=[factors4,TWI4];

clear aspect aspect1 aspect2 aspect3 aspect4
clear TWI TWI1 TWI2 TWI3 TWI4


TPI=imread('F:\DATA\YGAfactors\15083 10876\Topographic Position Index.tif');TPI(TPI<-100000)=nan;TPI=TPI(:);
TPI1=double(TPI((step1),:));
TPI2=double(TPI((step2),:));
TPI3=double(TPI((step3),:));
TPI4=double(TPI((step4),:));



%factors1=[factors1,TPI1];
%factors2=[factors2,TPI2];
factors3=[factors3,TPI3];
%factors4=[factors4,TPI4];

clear TPI TPI1 TPI2 TPI3 TPI4

SPI=imread('F:\DATA\YGAfactors\15083 10876\Stream Power Index.tif');SPI(SPI<-100000)=nan;SPI=SPI(:);
SPI1=double(SPI((step1),:));
SPI2=double(SPI((step2),:));
SPI3=double(SPI((step3),:));
SPI4=double(SPI((step4),:));

%factors1=[factors1,SPI1];
%factors2=[factors2,SPI2];
factors3=[factors3,SPI3];
%factors4=[factors4,SPI4];

clear SPI SPI1 SPI2 SPI3 SPI4

STI=imread('F:\DATA\YGAfactors\15083 10876\STI.tif');STI(STI<-100000)=nan;STI=STI(:);
STI1=double(STI((step1),:));
STI2=double(STI((step2),:));
STI3=double(STI((step3),:));
STI4=double(STI((step4),:));

Slopelength=imread('F:\DATA\YGAfactors\15083 10876\Slope Length.tif');Slopelength(Slopelength<-100000)=nan;Slopelength=Slopelength(:);
Slopelength1=double(Slopelength((step1),:));
Slopelength2=double(Slopelength((step2),:));
Slopelength3=double(Slopelength((step3),:));
Slopelength4=double(Slopelength((step4),:));

%factors1=[factors1,STI1,Slopelength1];
%factors2=[factors2,STI2,Slopelength2];
factors3=[factors3,STI3,Slopelength3];
%factors4=[factors4,STI4,Slopelength4];

clear STI STI1 STI2 STI3
clear Slopelength Slopelength1 Slopelength2 Slopelength3 Slopelength4

ProfileCurvature=imread('F:\DATA\YGAfactors\15083 10876\Profile Curvature.tif');ProfileCurvature(ProfileCurvature<-100000)=nan;ProfileCurvature=ProfileCurvature(:);
ProfileCurvature1=double(ProfileCurvature((step1),:));
ProfileCurvature2=double(ProfileCurvature((step2),:));
ProfileCurvature3=double(ProfileCurvature((step3),:));
ProfileCurvature4=double(ProfileCurvature((step4),:));

Populationdensity=imread('F:\DATA\YGAfactors\15083 10876\populationdensity.tif');Populationdensity(Populationdensity<-100000)=nan;Populationdensity=Populationdensity(:);

Populationdensity1=double(Populationdensity((step1),:));
Populationdensity2=double(Populationdensity((step2),:));
Populationdensity3=double(Populationdensity((step3),:));
Populationdensity4=double(Populationdensity((step4),:));

%factors1=[factors1,ProfileCurvature1,Populationdensity1];
%factors2=[factors2,ProfileCurvature2,Populationdensity2];
factors3=[factors3,ProfileCurvature3,Populationdensity3];
%factors4=[factors4,ProfileCurvature4,Populationdensity4];

clear ProfileCurvature ProfileCurvature1 ProfileCurvature2 ProfileCurvature3 ProfileCurvature4
clear Populationdensity Populationdensity1 Populationdensity2 Populationdensity3 Populationdensity4


POI=imread('F:\DATA\YGAfactors\15083 10876\Poi.tif');POI(POI<-100000)=nan;POI=POI(:);
POI1=double(POI((step1),:));
POI2=double(POI((step2),:));
POI3=double(POI((step3),:));
POI4=double(POI((step4),:));

Plancurvature=imread('F:\DATA\YGAfactors\15083 10876\Plan Curvature.tif');Plancurvature(Plancurvature<-100000)=nan;Plancurvature=Plancurvature(:);
Plancurvature1=double(Plancurvature((step1),:));
Plancurvature2=double(Plancurvature((step2),:));
Plancurvature3=double(Plancurvature((step3),:));
Plancurvature4=double(Plancurvature((step4),:));

%factors1=[factors1,POI1,Plancurvature1];
%factors2=[factors2,POI2,Plancurvature2];
factors3=[factors3,POI3,Plancurvature3];
%factors4=[factors4,POI4,Plancurvature4];

clear  Plancurvature Plancurvature1 Plancurvature2 Plancurvature3 Plancurvature4
clear  POI POI1 POI2 POI3 POI4

meanpre=imread('F:\DATA\YGAfactors\15083 10876\meanpre.tif');meanpre(meanpre<-100000)=nan;meanpre=meanpre(:);
meanpre1=double(meanpre((step1),:));
meanpre2=double(meanpre((step2),:));
meanpre3=double(meanpre((step3),:));
meanpre4=double(meanpre((step4),:));

%factors1=[factors1,meanpre1];
%factors2=[factors2,meanpre2];
factors3=[factors3,meanpre3];
%factors4=[factors4,meanpre4];

clear meanpre meanpre1 meanpre2 meanpre3

ndvi=imread('F:\DATA\YGAfactors\15083 10876\NDVI.tif');ndvi(ndvi<-100000)=nan;ndvi(:,15084)=[];ndvi(10877,:)=[];ndvi=ndvi(:);
ndvi1=double(ndvi((step1),:));
ndvi2=double(ndvi((step2),:));
ndvi3=double(ndvi((step3),:));
ndvi4=double(ndvi((step4),:));

%factors1=[factors1,ndvi1];
%factors2=[factors2,ndvi2];
factors3=[factors3,ndvi3];
%factors4=[factors4,ndvi4];

clear ndvi ndvi1 ndvi2 ndvi3 ndvi4
Distance2roads=imread('F:\DATA\YGAfactors\15083 10876\ygadis2road.tif');Distance2roads(Distance2roads<-100000)=nan;Distance2roads(:,15084)=[];Distance2roads(10877,:)=[];Distance2roads=Distance2roads(:);
Distance2roads1=double(Distance2roads((step1),:));
Distance2roads2=double(Distance2roads((step2),:));
Distance2roads3=double(Distance2roads((step3),:));
Distance2roads4=double(Distance2roads((step4),:));
 
%factors1=[factors1,Distance2roads1];
%factors2=[factors2,Distance2roads2];
factors3=[factors3,Distance2roads3];
%factors4=[factors4,Distance2roads4];


clear Distance2roads Distance2roads1 Distance2roads2 Distance2roads3 Distance2roads4


ygadcdis=imread('F:\DATA\YGAfactors\15083 10876\ygadis2dc.tif');ygadcdis(ygadcdis<-100000)=nan;ygadcdis(:,15084)=[];ygadcdis=ygadcdis(:);
ygadcdis1=double(ygadcdis((step1),:));
ygadcdis2=double(ygadcdis((step2),:));
ygadcdis3=double(ygadcdis((step3),:));
ygadcdis4=double(ygadcdis((step4),:));


%factors1=[factors1,ygadcdis1];
%factors2=[factors2,ygadcdis2];
factors3=[factors3,ygadcdis3];
%factors4=[factors4,ygadcdis4];
clear ygadcdis ygadcdis1 ygadcdis2 ygadcdis3 ygadcdis4


ygadis2water=imread('F:\DATA\YGAfactors\15083 10876\ygadis2water.tif');ygadis2water(ygadis2water<-100000)=nan;ygadis2water(:,15084)=[];ygadis2water(10877,:)=[];ygadis2water=ygadis2water(:);
ygadis2water1=double(ygadis2water((step1),:));
ygadis2water2=double(ygadis2water((step2),:));
ygadis2water3=double(ygadis2water((step3),:));
ygadis2water4=double(ygadis2water((step4),:));

SSM=imread('F:\DATA\YGAfactors\15083 10876\2015-2021mean_SSM.tif.tif');SSM(SSM<-100000)=nan;SSM(10877:10880,:)=[];SSM(:,15084:15087)=[];SSM=SSM(:);
SSM1=double(SSM((step1),:));
SSM2=double(SSM((step2),:));
SSM3=double(SSM((step3),:));
SSM4=double(SSM((step4),:));

%factors1=[factors1,ygadis2water1,SSM1];
%factors2=[factors2,ygadis2water2,SSM2];
factors3=[factors3,ygadis2water3,SSM3];
%factors4=[factors4,ygadis2water4,SSM4];

clear ygadis2water ygadis2water1 ygadis2water2 ygadis2water3 ygadis2water4
clear SSM SSM1 SSM2 SSM3 SSM4


ygalandcover=imread('F:\DATA\YGAfactors\15083 10876\ygalandcover.tif.tif');ygalandcover(ygalandcover<-100000)=nan;ygalandcover=ygalandcover(:);

ygalandcover1=double(ygalandcover((step1),:));ygalandcover1(ygalandcover1==-128)=nan;
ygalandcover2=double(ygalandcover((step2),:));ygalandcover2(ygalandcover2==-128)=nan;
ygalandcover3=double(ygalandcover((step3),:));ygalandcover3(ygalandcover3==-128)=nan;
ygalandcover4=double(ygalandcover((step4),:));ygalandcover4(ygalandcover4==-128)=nan;

Morphometricfeatures=imread('F:\DATA\YGAfactors\15083 10876\Morphometric Features.tif');Morphometricfeatures(Morphometricfeatures<-100000)=nan;Morphometricfeatures=Morphometricfeatures(:);
Morphometricfeatures1=double(Morphometricfeatures((step1),:));
Morphometricfeatures2=double(Morphometricfeatures((step2),:));
Morphometricfeatures3=double(Morphometricfeatures((step3),:));
Morphometricfeatures4=double(Morphometricfeatures((step4),:));

%factors1=[factors1,ygalandcover1,Morphometricfeatures1];
%factors2=[factors2,ygalandcover2,Morphometricfeatures2];
factors3=[factors3,ygalandcover3,Morphometricfeatures3];
%factors4=[factors4,ygalandcover4,Morphometricfeatures4];


clear ygalandcover ygalandcover1 ygalandcover2 ygalandcover3 ygalandcover4
clear Morphometricfeatures Morphometricfeatures1 Morphometricfeatures2 Morphometricfeatures3 Morphometricfeatures4

ygayx=imread('F:\DATA\YGAfactors\15083 10876\yx.tif');ygayx(ygayx<-100000)=nan;ygayx(:,15084)=[];ygayx(10877,:)=[];ygayx=ygayx(:);
ygayx1=double(ygayx((step1),:));ygayx1(ygayx1==255)=nan;
ygayx2=double(ygayx((step2),:));ygayx2(ygayx2==255)=nan;
ygayx3=double(ygayx((step3),:));ygayx3(ygayx3==255)=nan;
ygayx4=double(ygayx((step4),:));ygayx4(ygayx4==255)=nan;


ygasoiltypes=imread('F:\DATA\YGAfactors\15083 10876\ygahwsd.tif');ygasoiltypes(ygasoiltypes<-100000)=nan;ygasoiltypes(:,15084)=[];ygasoiltypes(10877,:)=[];ygasoiltypes=ygasoiltypes(:);
ygasoiltypes1=double(ygasoiltypes((step1),:));
ygasoiltypes2=double(ygasoiltypes((step2),:));
ygasoiltypes3=double(ygasoiltypes((step3),:));
ygasoiltypes4=double(ygasoiltypes((step4),:));

%factors1=[factors1,ygayx1,ygasoiltypes1];factors1=factors1';factors1(isnan(factors1))=0;
%factors2=[factors2,ygayx2,ygasoiltypes2];factors2=factors2';factors2(isnan(factors2))=0;
factors3=[factors3,ygayx3,ygasoiltypes3];factors3=factors3';factors3(isnan(factors3))=0;
%factors4=[factors4,ygayx4,ygasoiltypes4];factors4=factors4';factors4(isnan(factors4))=0;


clear ygayx ygayx1 ygayx2 ygayx3 ygayx4
clear ygasoiltypes ygasoiltypes1 ygasoiltypes2 ygasoiltypes3 ygasoiltypes4
clear step1 step2  step3 meanpre4

%%
% 1. 随机产生训练集和测试集

n1 = randperm(6440);num=length(n1);
%%
% 2. 70%训练集
P_train = matrix(n1(1:3220),:)';
T_train = label(n1(1:3220),:)';


%%
% 3. 30%测试集
P_test = matrix(n1(3221:end),:)';
T_test = label(n1(3221:end),:)';


%%  数据归一化
[p_train, ps_input] = mapminmax(P_train, 0, 1);
[t_train, ps_output] = mapminmax(T_train, 0, 1);

p_test = mapminmax('apply', P_test, ps_input);
t_test = mapminmax('apply', T_test, ps_output);

[p_train1, ps_input1] = mapminmax(factors3, 0, 1);


numFeatures = size(p_train,1); %输入特征维数
numResponses = size(t_train,1);%输出特征维数
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









