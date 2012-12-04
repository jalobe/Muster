clear all;
close all;
clc;

% Daten aus Dateien einlesen
testfile='pendigits-testing.txt';
trainfile='pendigits-training.txt';
X_train=dlmread(trainfile);
X_test=dlmread(testfile);

y_train = X_train(:,end);
y_test = X_test(:,end);

X_train = X_train(:,1:16);
X_test = X_test(:,1:16);

% Matrix der Erkennungsraten
ER = zeros(10);

% Container für Cluster,deren Mittelpunkte und Kovarianzmatrizen
Data = cell(10,3);

% Zentriere Daten
u_train = mean(X_train,1);
u_test = mean(X_test,1);
X_train = X_train - repmat(u_train,size(X_train,1),1);
X_test = X_test - repmat(u_test,size(X_test,1),1);

% Berechne Kovarianzmatrix von X_train
cov_train = cov(X_train);
% Berechne Eigenvektoren mittels SVD
[u,s,v] = svd(cov_train);
% Basistransformationsmatrix
X_haupt = u;

% Transformiere Daten in neue Basis
X_test = X_test * X_haupt;
X_train = X_train * X_haupt;

X_test = [X_test(:,1:10),y_test];
X_train = [X_train(:,1:10),y_train];





# Finde Cluster, Means und Kovarianzmatrizen
for i=0:9
    idx=find(X_train(:,end)==i);
    Data{i+1,1} = X_train(idx,1:10);
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
        w = (u1 - u2)/(E1 + E2);
        # Normalisiere w
        w = w/(norm(w));
        # Projiziere Punkte auf w und berechne Mittelwert und Varianz
        proj1 = Data{i+1,1} * w';	
        proj2 = Data{j+1,1} * w';
        mean1 = mean(proj1);
        mean2 = mean(proj2);
        var1 = mean((proj1 - mean1).^2);
        var2 = mean((proj2 - mean2).^2);
        # Klassifiziere Punkte aus Testmenge
        hits = 0;
        # Bilde Testmenge
        idx1 = find(X_test(:,end)==i);
        idx2 = find(X_test(:,end)==j);
        A = X_test(idx1,:);
        B = X_test(idx2,:);
        X = [A;B];
        for k=1:size(X,1)
            x = X(k,1:10)*w';
            p1 = 1/(sqrt(2*pi*var1))*e^(-0.5*((x-mean1)^2)/var1);
            p2 = 1/(sqrt(2*pi*var2))*e^(-0.5*((x-mean2)^2)/var2);
            if(p1>p2)
                    belief = i;
            else
                    belief = j;
            endif
            actual = X(k,end);
            if(actual == belief)
                    hits = hits + 1;
            endif
        end
        rate = hits*100/size(X,1);
        ER(i+1,j+1) = rate;
    end
end

# ER ausgeben
ER

