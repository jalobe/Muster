clear all;
close all;
clc;

datasize = 100;

% Generiere Gewichtsvektor w_gen
w_gen = rand(4,1).*2.-1;

% Generiere Zufallsdaten
X = rand(datasize,4).*2.-1;
X(:,1) = 1;

% Finde Labels y
y_gen = X * w_gen;
idx = find(y_gen < 0);
y_gen = ones(datasize,1);
y_gen(idx,:) = 0;


% Lernen des Gewichtsvektors w
w = rand(4,1).*2.-1;
y = X * w;
idx = find(y < 0);
y = ones(datasize,1);
y(idx,:) = 0;

count = 0;
while(any(y_gen - y))	
	count = count + 1;
	idx = find(y_gen-y,1,'first');
	if(y_gen(idx)==0);
		w = w - X(idx,:)';
	else
		w = w + X(idx,:)';
	endif
	y = X * w;
	idx = find(y < 0);
	y = ones(datasize,1);
	y(idx,:) = 0;		
endwhile 
