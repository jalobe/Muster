clear all;
close all;
clc;

more off;

% Daten aus Dateien einlesen
X_train=dlmread('pendigits-training.txt');
X_test=dlmread('pendigits-testing.txt');
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



% Subsetgröße
s = 100;
% Anzahl innerer Neuronen
n = 15;
% Fehlerschwelle
epsilon = .02*s;
u = 1.2;
d = 0.5;
gammamax = 50;
gammamin = 10^-6;
 
% random weights
%W1_hat = (rand(17,n).-.5)*100;
%W2_hat = (rand(n+1,10).-.5)*100;
W1_hat = rand(17,n);
W2_hat = rand(n+1,10);

gamma1 = ones(17,n)*0.1;
gamma2 = ones(n+1,10)*0.1;
oldgrad1 = zeros(17,n);
oldgrad2 = zeros(n+1,10);
count = 0;

do
	count += 1;
	E = 0;
	grad1 = 0;		
	grad2 = 0;
	

	for(j=1:s)
		% Input
		%i = randi(size(X_train,1));
		[g1,g2,error] = backprop(X_train(j,:),W1_hat,W2_hat,t_train(j,:));
		E += error;		
		grad1 += g1;
		grad2 += g2;
	endfor
	
	newgrad1 = grad1;
	newgrad2 = grad2;
	
	a = newgrad1 .* oldgrad1;
	b = newgrad2 .* oldgrad2;
	
	for(i=1:size(a,1))
		for(j=1:size(a,2))
			if(a(i,j)>0)
				gamma1(i,j) = min(gamma1(i,j)*u,gammamax);
				W1_hat(i,j) += -gamma1(i,j) * sign(newgrad1(i,j));
				oldgrad1(i,j) = newgrad1(i,j);
			elseif(a(i,j)<0)
				gamma1(i,j) = max(gamma1(i,j)*d,gammamin);
				oldgrad1(i,j) = 0;
			else
				W1_hat(i,j) += -gamma1(i,j) * sign(newgrad1(i,j));
				oldgrad1(i,j) = newgrad1(i,j);
			endif
		end
	end
	
	for(i=1:size(b,1))
		for(j=1:size(b,2))
			if(b(i,j)>0)
				gamma2(i,j) = min(gamma2(i,j)*u,gammamax);
				W2_hat(i,j) += -gamma2(i,j) * sign(newgrad2(i,j));
				oldgrad2(i,j) = newgrad2(i,j);
			elseif(b(i,j)<0)
				gamma2(i,j) = max(gamma2(i,j)*d,gammamin);
				oldgrad2(i,j) = 0;
			else
				W2_hat(i,j) += -gamma2(i,j) * sign(newgrad2(i,j));
				oldgrad2(i,j) = newgrad2(i,j);
			endif
		end
	end	
	E
	Es(count,1) = E;	

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


