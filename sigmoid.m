% sigmoid Funktion
function r = sigmoid(X)
	t = 1 .+ exp(-X);
	r = 1 ./ t; 
endfunction