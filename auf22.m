clear all;
close all;
clc;

testfile='pendigits-testing.txt';
trainfile='pendigits-training.txt';
X_train=dlmread(trainfile);
X_test=dlmread(testfile);

% Initialisierung
C=zeros(10);
means=zeros(10,16);
cm=zeros(160,16);

for i=0:9
	idx=find(X_train(:,end)==i);
	cluster = X_train(idx,1:16);
	means(i+1,:) = mean(cluster);
	cm(16*i+1:16*(i+1),:) = cov(cluster).+ 0.00001;
	
end;

for i=1:size(X_test,1)
	p = zeros(1,10);
	for j=0:9
		x = X_test(i,:);
		vec=x(1:16)-means(j+1,:);
		
		exponent=-0.5*vec* inv(cm(16*j+1:16*(j+1),:))*vec';
		normal = 1/((2*pi)^8 * sqrt(det(cm(16*j+1:16*(j+1),:))));
		p(j+1)=normal*exp(exponent);
	end;
	[v,idx]=max(p);
	belief = idx-1;	
	actual = x(17);
	C(belief+1,actual+1)=C(belief+1,actual+1)+1;
end;

rate=trace(C)/sum(C(:));
fprintf(1,'confusion matrix\n');
disp(C);
missed=sum(C(:))-trace(C);
fprintf(1,'%d misclassified out of %d test samples\n',missed,sum(C(:)));
fprintf(1,'rate (correct): %f\n',rate);