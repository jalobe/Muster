clear all;
close all;
clc;

% Daten aus Dateien einlesen
testfile='pendigits-testing.txt';
trainfile='pendigits-training.txt';
X_train=dlmread(trainfile);
X_test=dlmread(testfile);

% Matrix der Erkennungsraten
ER = zeros(10);

% Container für Cluster,deren Mittelpunkte und Kovarianzmatrizen
Data = cell(10,3);

% Finde Cluster, Means und Kovarianzmatrizen
for i=0:9
    idx=find(X_train(:,end)==i);
    Data{i+1,1} = X_train(idx,1:16);
    Data{i+1,2} = mean(Data{i+1,1});
    Data{i+1,3} = cov(Data{i+1,1});
end

for i=0:8
    for j=i+1:9
        u1 = Data{i+1,2};
        u2 = Data{j+1,2};
        E1 = Data{i+1,3};
        E2 = Data{j+1,3};
        % Finde Projektionsrichtung w
        w = (u1 - u2)/(E1 + E2);
        % Normalisiere w
        w = w/(norm(w));
        % Projiziere Punkte auf w und berechne Mittelwert und Varianz
        mean1 = mean(Data{i+1,1} * w');
        mean2 = mean(Data{j+1,1} * w');
        var1 = mean((Data{i+1,1} * w' .- mean1).^2);
        var2 = mean((Data{j+1,1} * w' .- mean2).^2);
        % Berechne Schwellenwert für Klassentrennung
        t = threshold(mean1,mean2,var1,var2);
        hits = 0;
        for k=1:size(X_test,1)
            proj = w'*X_test(k,1:16);
            if(proj < t && mean1 < mean2 || proj > t && mean1 > mean2)
                class = i;
            else
                class = j;
            endif
            if(class == X_test(k,end))
                hits = hits + 1;
            endif
        end
        rate = hits*100/size(X_test,1);
        ER(i+1,j+1) = rate;
    end
end

% ER ausgeben
ER