clear all;
close all;
clc;

% Daten einlesen
file = dlmread('prostatecancer.txt');
X_train = file(find(file(:,end)==1),:);

y = X_train(:,10);
X = X_train(:,2:9);

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
grid on;
ylabel('Koeffizienten');
xlabel('df(\lambda)');
textYPos = ys(1,:);

text(8.1,textYPos(1),'lcavol');
text(8.1,textYPos(2),'lweight');
text(8.1,textYPos(3),'age');
text(8.1,textYPos(4),'lbph');
text(8.1,textYPos(5)+0.015,'svi');
text(8.1,textYPos(6),'lcp');
text(8.1,textYPos(7),'gleason');
text(8.1,textYPos(8)-0.015,'pgg45');
