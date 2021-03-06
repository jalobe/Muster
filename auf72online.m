clear all;
close all;
clc;


% Daten aus Dateien einlesen
X_train=dlmread('pendigits-training.txt');
X_test=dlmread('pendigits-testing.txt');
y_train = X_train(:,end);
t_train = zeros(size(y_train,1),10);
for i=1:size(y_train)
t_train(i,y_train(i) + 1) = 1;
end
y_test = X_test(:,end);
X_train = X_train(:,1:16)./100;
X_test = X_test(:,1:16)./100;

% Zentriere Daten
u_train = mean(X_train,1);
u_test = mean(X_test,1);
X_train = X_train - repmat(u_train,size(X_train,1),1);
X_test = X_test - repmat(u_test,size(X_test,1),1);

% Berechne Kovarianzmatrix von X_train
cov_train = cov(X_train);
% Berechne Eigenvektoren mittels SVD
[u,s,v] = svd(cov_train);
% Basistransformationsmatrix
X_haupt = u;

% Transformiere Daten in neue Basis und reduziere auf 14 Dimensionen
X_test = X_test * X_haupt;
X_train = X_train * X_haupt;
X_test = X_test(:,1:14);
X_train = X_train(:,1:14);



gamma = .1;
epsilon = .01;
n = 15; 


% random weights
W1_hat = rand(15,n);
W2_hat = rand(n+1,10);

count = 0;
while(count < 100000)
	count += 1;
	E = 0;
	i = randi(size(X_train,1));
	[grad1,grad2,error] = backprop(X_train(i,:),W1_hat,W2_hat,t_train(i,:));
	E = error;		
	Es(count,1) = E;
	W1_hat += -gamma * grad1;
	W2_hat += -gamma * grad2;
endwhile



ER = 0;
hits = 0;
datasize = size(X_test,1);
for(i=1:datasize)
	class = classify(W1_hat,W2_hat,X_test(i,:));
	if(class == y_test(i))
		hits += 1;
	endif
end
ER = hits/datasize *100
