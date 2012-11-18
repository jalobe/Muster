clear all;
close all;
clc;

data = dlmread('prosdata');
trainids  = find(data(:,end)==1);
testids  = find(data(:,end)==0);

y = data(trainids,10);
X = data(trainids,2:9);
beta = inv(X' * X) * X' * y;

yact = data(testids,10);
Xhat = data(testids,2:9);
yhat = Xhat * beta;

err = yact - yhat;
qerr = err .^ 2
qmeanerr = mean(qerr)

saveas(bar(sort(qerr)),"plot41.png");
