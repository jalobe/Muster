clear all;
close all;
clc;

more off;

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

% Subsetgröße
s = 200;
% Anzahl innerer Neuronen
n = 15;
% Lernkonstante
gamma = 10/s;
% Fehlerschwelle
epsilon = .01*s;
 
% random weights
%W1_hat = (rand(17,n).-.5)*100;
%W2_hat = (rand(n+1,10).-.5)*100;
W1_hat = rand(35,n);
W2_hat = rand(n+1,1);

count = 0;
do
	count += 1;
	E = 0;
	dW1_hat = 0;
	dW2_hat = 0;

	for(j=1:s)
		% Input
		i = randi(size(X_train,1));
		[grad1,grad2,error] = backprop(X_train(j,:),W1_hat,W2_hat,t_train(j,:));
		E += error;		
		dW1_hat += grad1;
		dW2_hat += grad2;
	endfor
	
	E
	Es(count,1) = E;
	W1_hat += -gamma * dW1_hat;
	W2_hat += -gamma * dW2_hat;

until(E < epsilon)



plot(Es);

hits = 0;
datasize = size(X_test,1);
for(i=1:datasize)
	class = classify(W1_hat,W2_hat,X_test(i,:));
	if(class == y_test(i))
		hits += 1;
	endif
end
ER = hits/datasize *100