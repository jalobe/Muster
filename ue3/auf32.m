clear all;
close all;
clc;

# Daten aus Dateien einlesen
testfile='pendigits-testing.txt';
trainfile='pendigits-training.txt';
X_train=dlmread(trainfile);
X_test=dlmread(testfile);

# Matrix der Erkennungsraten
ER = zeros(10);

# Container für Cluster,deren Mittelpunkte und Kovarianzmatrizen
Data = cell(10,3);

# Finde Cluster, Means und Kovarianzmatrizen
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
# Finde Projektionsrichtung w
        w = (u1 - u2) * inv(E1 + E2);
# Normalisiere w
        w = w / (norm(w));
# Projiziere Punkte auf w und berechne Mittelwert und Varianz
        proj1 = Data{i+1,1} * w';
        proj2 = Data{j+1,1} * w';
	mean1 = mean(proj1);
        mean2 = mean(proj2);
        var1 = mean((proj1 - mean1) .^2);
        var2 = mean((proj2 - mean2) .^2);
# a priori Wahrscheinlichkeiten
	size1 = rows(proj1);
	size2 = rows(proj2);
	size = size1 + size2;
	weight1 = size1 / size;
	weight2 = size2 / size;
# Klassifiziere Punkte aus Testmenge
        hits = 0;
	testids = find(X_test(:,end)==i | X_test(:,end)==j);
	test = X_test(testids,1:end); 
        for k=1:rows(test)
            x = test(k,1:16) * w';
            p1 = (weight1/(sqrt(2*pi*var1))) * e^(-0.5*((x-mean1)^2)/var1);
            p2 = (weight2/(sqrt(2*pi*var2))) * e^(-0.5*((x-mean2)^2)/var2); 
	    s = (p1 - p2) / (p1 + p2);
	    if(s>0)
                    belief = i;
            else
                    belief = j;
            endif
            actual = test(k,end);
            if(actual == belief)
                    hits = hits + 1;
            endif
        end
        rate = hits*100/rows(test);
        ER(i+1,j+1) = rate;
    end
end

# ER ausgeben
ER
