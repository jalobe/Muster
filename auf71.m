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
	output = sigmoid(out1_hat * W2)
	if(output>=.5)
		r = 1;
	else
		r = 0;
	end
	
endfunction

% Daten
X = [0,0; 0,1; 1,0; 1,1];
y = [0;1;1;0];


% Lernkonstante
gamma = 1;
% Fehlerschwelle
epsilon = 0.01;
E = 1;
 
% random weights
W1_hat = rand(3,2);
W2_hat = rand(3,1);

count = 0;
while(E > epsilon) 
	count +=1;
	Es(count) = E;
	E = 0;
	dW1_hat = 0;
	dW2_hat = 0;

	for(i=1:4)
		% Input
		o_hat = [X(i,:),1];



		%%%%% Feed Forward %%%%%

		% Berechne Outputvektoren
		o1 = sigmoid(o_hat * W1_hat);
		o1_hat = [o1,1];
		o2 = sigmoid(o1_hat * W2_hat);

		% Berechne Ableitungsmatrizen
		D1 = diag(o1 .* (1 .- o1));
		D2 = diag(o2 .* (1 .- o2));
		% Berechne Fehler
		e = (o2 .- y(i))'; 
		% Summiere gesamten Fehler auf
		E += sum((e.^2)./2);

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

% endgültiges Update(offline Backprop)
W1_hat += dW1_hat;
W2_hat += dW2_hat;

endwhile

%Plotte Fehler über Anzahl der Iterationen
plot(Es);

ER = 0;
hits = 0;

for(i=1:4)
	class = classify(W1_hat,W2_hat,X(i,:));
	if(class == y(i))
		hits += 1;
	endif
end
ER = hits/4 *100