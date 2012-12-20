% Klassifiziert den Vektor input anhand eines neuronalen Netzes gegeben durch
% die Gewichtsmatrizen W1 und W2. Als Aktivierungsfunktion wird die Sigmoidfunktion verwendet.
% Der Returnwert r gibt den Index der Klasse zurück, beginnend bei 0.
% input muss ein Zeilenvektor sein.

function r = classify(W1,W2,input)
	input = [input,1];	
	out1 = sigmoid(input * W1);
	out1_hat = [out1,1];
	output = sigmoid(out1_hat * W2);
	if(size(output,2)==1)
		output(1,2) = output;
		output(1,1) = 1 - output(1,1); 
	endif
	[x,ret] = max(output);
	r = ret - 1;
endfunction