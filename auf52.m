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

% Berechne Mittelwerte und Standardabweichungen 
means = mean(alpha,2);
deviations = std(alpha,0,2);

% Ausgabe
printf("Koeffizient\tMittelwert\tStandardabweichung\tIntervall\n\n");
printf("alpha_0\t\t%f\t%f\t\t[%f - %f]\n",means(1),deviations(1),means(1)-2*deviations(1),means(1)+2*deviations(1));
printf("alpha_1\t\t%f\t%f\t\t[%f - %f]\n",means(2),deviations(2),means(2)-2*deviations(2),means(2)+2*deviations(2));
printf("alpha_2\t\t%f\t%f\t\t[%f - %f]\n",means(3),deviations(3),means(3)-2*deviations(3),means(3)+2*deviations(3));
printf("alpha_3\t\t%f\t%f\t\t[%f - %f]\n",means(4),deviations(4),means(4)-2*deviations(4),means(4)+2*deviations(4));