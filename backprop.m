function [gradient1,gradient2,error] = backprop(input,W1,W2,label)
	input = [input,1];
	
	%%%%% Feed Forward %%%%%

	% Berechne Outputvektoren
	o1 = sigmoid(input * W1);
	o1_hat = [o1,1];
	o2 = sigmoid(o1_hat * W2);

	% Berechne Ableitungsmatrizen
	D1 = diag(o1 .* (1 .- o1));
	D2 = diag(o2 .* (1 .- o2));
	% Berechne Fehler und seine Ableitung
	e = (o2 .- label)'; 
	error = sum((e.^2)./2);



	%%%%% Backpropagation %%%%%

	delta2 = D2 * e;
	W2 = W2(1:end-1,:);
	delta1 = D1 * W2 * delta2;
	
	gradient1 = (delta1 * input)';
	gradient2 = (delta2 * o1_hat)';
	
endfunction