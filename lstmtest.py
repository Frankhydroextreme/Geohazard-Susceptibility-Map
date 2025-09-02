# -*- encoding: utf-8 -*-
'''
@Project :   LSTM多变量时间序列预测
@Desc    :   利用LSTM模型进行多变量时间啊序列预测
@Time    :   2021/03/21 12:16:13
@Author  :   帅帅de三叔,zengbowengood@163.com
'''

import math
import pandas as pd
from datetime import datetime
import matplotlib.pyplot as plt
from pandas.core.algorithms import mode
from sklearn.preprocessing import LabelEncoder, MinMaxScaler
from tensorflow.python.keras.backend import concatenate
from sklearn.metrics import mean_squared_error
from tensorflow.python.keras.callbacks import History
from series_to_supervised import series_to_supervised
from keras.models import Sequential
from keras.layers import Dense, Activation, Embedding, LSTM


dataset = pd.read_csv("raw.csv", index_col= "datetime", parse_dates = {"datetime":['year', 'month', 'day', 'hour']}, date_parser= lambda x:datetime.strptime(x,'%Y %m %d %H')) #读取数据并拼接时间
dataset.drop("No", axis = 1, inplace = True) #去掉No列
dataset.columns = ["pm25", "dew",  "temp", "press", "wnd_dir", "wnd_spd", "snow", "rain"] #重命名表头
dataset.dropna(subset = ['pm25'], inplace = True) #去掉pm25为空的行
values = dataset.values #数值特征变量
groups = [0, 1, 2, 3, 5, 6, 7]
i = 1
plt.figure() #新建画布
for group in groups:
    plt.subplot(len(groups), 1, i) #子图
    plt.plot(values[:, group]) #折线图
    plt.title(dataset.columns[group], y = 0.5, fontsize = 10, loc = "right") #取字段为子图标题
    i +=1
plt.show()


encoder = LabelEncoder() #编码
values[:,4] = encoder.fit_transform(values[:,4]) #将第4列编码
values = values.astype('float32') #使得所有数值类型都是float类型
scaler = MinMaxScaler(feature_range = (0, 1)) #0-1归一化
scaled = scaler.fit_transform(values)
reframed = series_to_supervised(scaled, 1, 1) #调用series_to_supervised函数将数据转为监督数据变成16列
reframed.drop(reframed.columns[[9, 10, 11, 12, 13, 14, 15]], axis= 1,inplace = True) 
values = reframed.values
n_train_hours = 365*24 #一年的小时数
train = values[:n_train_hours, :] #训练集
test = values[n_train_hours:, :] #测试集
train_x, train_y = train[:, :-1], train[:, -1] #训练集特征和标签 
test_x, test_y = test[:, :-1], test[:, -1] #测试集的特征和标签
train_x = train_x.reshape((train_x.shape[0], 1, train_x.shape[1])) #转为LSTM模型的输入格式（samples, timesteps, features）
test_x = test_x.reshape((test_x.shape[0], 1, test_x.shape[1])) #转为LSTM模型的输入格式（samples, timesteps, features）


model = Sequential()
model.add(LSTM(50, input_shape = (train_x.shape[0], train_x.shape[2]))) #8760*8
model.add(Dense(1))
model.compile(loss = "mae",optimizer= "adam")
history =model.fit(train_x, train_y, epochs= 50, batch_size=72, validation_data=(test_x, test_y), verbose=2, shuffle=False)
plt.figure()
plt.plot(history.history["loss"], label = "train")
plt.plot(history.history["val_loss"], label = "test")
plt.legend()
plt.show()


yhat = model.predict(test_x)
test_x = test_x.reshape((test_x.shape[0], test_x.shape[2]))
inv_yhat = concatenate((yhat,test_x[:, 1:]), axis = 1)
inv_yhat = scaler.inverse_transform(inv_yhat)
inv_yhat = inv_yhat[:, 0]

test_y = test_y.reshape((len(test_y), 1))
inv_y = concatenate((test_y, test_x[:, 1:]), axis =1)
inv_y = scaler.inverse_transform(inv_y)
inv_y = inv_y[:, 0]
rmse = math.sqrt(mean_squared_error(inv_y, inv_yhat))
print("the rmse is: %.3f" %rmse)

