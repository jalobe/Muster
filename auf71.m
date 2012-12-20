clear all;
close all;
clc;


% Daten
X = [0,0; 0,1; 1,0; 1,1];
y = [0;1;1;0];


% Lernkonstante
gamma = 2;
% Fehlerschwelle
epsilon = 0.01;
 
% random weights
W1_hat = rand(3,2);
W2_hat = rand(3,1);

count = 0;
do 
	count += 1;
	E = 0;
	dW1_hat = 0;
	dW2_hat = 0;

	for(i=1:4)
		[grad1,grad2,error] = backprop(X(i,:),W1_hat,W2_hat,y(i));
		E += error;		
		dW1_hat += -gamma * grad1;
		dW2_hat += -gamma * grad2;
	endfor

	Es(count) = E;
	% endgültiges Update(offline Backprop)
	W1_hat += dW1_hat;
	W2_hat += dW2_hat;

until(E < epsilon)

%Plotte Fehler über Anzahl der Iterationen
plot(Es);
hits = 0;
for(i=1:4)
	class = classify(W1_hat,W2_hat,X(i,:))
	if(class == y(i))
		hits += 1;
	endif
end
ER = hits/4 *100