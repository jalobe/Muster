clear all;
close all;
clc;


% sigmoid Funktion
function r = sigmoid(X)
	t = 1 .+ exp(-X);
	r = 1 ./ t; 
endfunction


function r = classify(W1,W2,input)
	input = [input,1];	
	out1 = sigmoid(input * W1);
	out1_hat = [out1,1];
	output = sigmoid(out1_hat * W2);
	[x,ret] = max(output);
	r = ret - 1;
endfunction


% Daten aus Dateien einlesen
testfile='pendigits-testing.txt';
trainfile='pendigits-training.txt';
X_train=dlmread(trainfile);
X_test=dlmread(testfile);
y_train = X_train(:,end);
t_train = zeros(size(y_train,1),10);
for i=1:size(y_train)
t_train(i,y_train(i) + 1) = 1;
end
y_test = X_test(:,end);
X_train = X_train(:,1:16);
X_test = X_test(:,1:16);

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


s = 100;
% Lernkonstante
gamma = 10/s;
% Fehlerschwelle
epsilon = .01*s;
E = 100;
 
% random weights
W1_hat = rand(15,15);
W2_hat = rand(16,10);

count = 0;
while(E > epsilon) 
	count += 1;
	Es(count,1) = E;
	E = 0;
	dW1_hat = 0;
	dW2_hat = 0;

	for(j=1:s)
		% Input
		i = randi(size(X_train,1));
		o_hat = [X_train(i,:),1];


		%%%%% Feed Forward %%%%%

		% Berechne Outputvektoren
		o1 = sigmoid(o_hat * W1_hat);
		o1_hat = [o1,1];
		o2 = sigmoid(o1_hat * W2_hat);
		% Berechne Ableitungsmatrizen
		D1 = diag(o1 .* (1 .- o1));
		D2 = diag(o2 .* (1 .- o2));
		% Berechne Fehler
		e = (o2 .- t_train(i,:))'; 
		% Summiere gesamten Fehler auf
		dE = sum((e.^2)./2);
		E += dE;

		%%%%% Backprop to output layer %%%%%
		delta2 = D2 * e;


		%%%%% Backprop to hidden layer %%%%%
		W2 = W2_hat(1:end-1,:);
		delta1 = D1 * W2 * delta2;


		%%%%% Weights Update %%%%%

		dw = -gamma * delta2 * o1_hat;
		dW2_hat += dw';

		dw = -gamma * delta1 * o_hat;
		dW1_hat += dw';

	endfor

W1_hat += dW1_hat;
W2_hat += dW2_hat;

endwhile

plot(Es);

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
W1_hat
W2_hat
