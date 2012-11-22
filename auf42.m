clear all;
close all;
clc;

% Daten einlesen
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

%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%

% X * a = y
% a berechnen
a = ((X_train'*X_train)^-1)*X_train'*y_train;
% Werte vorhersagen
y_predict = X_test * a;
% Quadratische Abweichung berechnen und ausgeben
error = y_test - y_predict;
q = error'*error




%%%%%%%%%%%%
% Aufgabe 2
%%%%%%%%%%%%      

for i=1:8
      subsets = nchoosek(1:8,i);
      for j=1:size(subsets,1)
            X = X_train(:,[1,subsets(j,:).+1]);
            a = ((X'*X)^-1)*X'*y_train;
            y_predict = X_all(:,[1,subsets(j,:).+1]) * a;
            error = [y_test;y_train] - y_predict;
            q = error'*error;
            qs(j) = q;
            figure(1);
            plot(i,q,'xr');
            hold on;
      end
      figure(2);
      plot(i,min(qs),'xr');
      hold on;
end

saveas(1,'plot1.png');
saveas(2,'plot2.png');