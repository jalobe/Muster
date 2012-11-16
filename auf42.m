clear all;
close all;
clc;

# Daten einlesen
file = dlmread('prostatecancer.txt');

X_test = file(find(file(:,end)==0),:);
X_train = file(find(file(:,end)==1),:);

y_test = X_test(:,10);
y_train = X_train(:,10);

X_test = X_test(:,1:9);
X_train = X_train(:,1:9);

X_test(:,1) = 1;
X_train(:,1) = 1;

X_all = [X_test; X_train];

      
for i=1:8
      subsets = nchoosek(1:8,i);
      for j=1:size(subsets,1)
            X = X_train(:,[1,subsets(j,:).+1]);
            a = ((X'*X)^-1)*X'*y_train;
                  
                  y_predict = X_all(:,[1,subsets(j,:).+1]) * a;
            error = [y_test;y_train] - y_predict;
            q = error'*error;
            plot(i,q,'xr');
            hold on;
      end
end