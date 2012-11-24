clear all;
close all;
clc;

% Daten einlesen
file = dlmread('prostatecancer.txt');

y = file(:,10);
X = file(:,2:9);

% Normiere X
for i=1:8
	meanI = mean(X(:,i));
	deviationI = std(X(:,i));
	X(:,i) = (X(:,i)-meanI)./deviationI;
end

% Normiere y
meanY = mean(y);
deviationY = std(y);
y = (y-meanY)./deviationY;

%meanX = mean(X);
%deviationX = sqrt(mean(sum((X-meanX).^2,2)));
%X = (X - meanX)./deviationX;


% Berechne die Werte für df(delta) und alpha
for i=1:10000
	delta = (i-1)*5;
	A = (X'*X + delta*eye(8))^-1*X';
	df = trace(X*A);
	xs(i) = df;
	% alpha bestimmen
	alpha = A * y;
	ys(i,:) = alpha;
end

% Plotte die alphas gegen df(delta)
plot(xs,ys,'-');