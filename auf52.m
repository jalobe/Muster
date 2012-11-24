clear all;
close all;
clc;

% Daten einlesen
file = dlmread('prostatecancer.txt');

% Wähle Merkmale 1,5 und 7 aus und mache 1. Spalte zu 1
Data = file(:,[1,2,6,8]);
Data(:,1) = 1;


for i=1:100
	% Wähle zufällig 50 Samples aus Data 
	idx = randi(size(Data,1),50,1);
	X = Data(idx,:);
	y = file(idx,10);
	% lineare Regression mit den gewählten Samples
	alpha(:,i) = (X'*X)^-1 * X'*y;
end

% Berechne für erste 10 Samples Mittelwert und Standardabweichung
ys = Data(1:10,:) * alpha;
means = mean(ys,2);
deviations = std(ys,0,2);


% Ausgabe
printf("Sample\tMittelwert\tStandardabweichung\tIntervall\n\n");
for i=1:10
	printf("%i\t%f\t%f\t\t[%f - %f]\n",i,means(i),deviations(i),means(i)-2*deviations(i),means(i)+2*deviations(1));
end