clear all;
close all;
clc;


% Daten aus Dateien einlesen
X = dlmread('ionosphere.txt');
X_train= X(1:200,1:end-1);
X_test=X(201:end,1:end-1);
t_train = X(1:200,end);
y_test = X(201:end,end);


% Zentriere Daten
u_train = mean(X_train,1);
u_test = mean(X_test,1);
X_train = X_train - repmat(u_train,size(X_train,1),1);
X_test = X_test - repmat(u_test,size(X_test,1),1);



gamma = .1;
epsilon = .01;
n = 15; 


% random weights
W1_hat = rand(35,n);
W2_hat = rand(n+1,1);

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
