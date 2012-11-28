clear all;
close all;
clc;

% read data from file
trainfile='pendigits-training.txt';
X_train=dlmread(trainfile);

% find all vectors labeled with 5
idx=find(X_train(:,end)==5);
cluster = X_train(idx,1:16);
% compute covariance matrix
sigma = cov(cluster);
% compute eigenvector
[es,lambda] = eig(sigma);
[lambda,idx] = max(diag(lambda));
e = es(:,idx);
% norm of eigenvector with biggest eigenvalue
e = e/norm(e);

x = rand(16,1) * 100;

for i=1:10
	x = sigma * x;
	x = x/norm(x);
end

% Quadratischer Fehler der Beträge	
e = abs(e)-abs(x);
e'* e

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Das x kovergiert in die Richtung des Eigenvektors e mit dem  %
% größten Eigenwert oder in die entgegengesetzte Richtung.     %
% Anders ausgerückt wird x an e bzw. -e herangezogen.          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%