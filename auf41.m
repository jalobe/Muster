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


# X * a = y
# a berechnen
a = ((X_train'*X_train)^-1)*X_train'*y_train;
# Werte vorhersagen
y_predict = X_test * a;
# Quadratische Abweichung berechnen und ausgeben
error = y_test - y_predict;
q = error'*error
