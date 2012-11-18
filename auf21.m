clear all;
close all;
clc;

% read data from files

testfile='pendigits-testing.txt';
trainfile='pendigits-training.txt';
X_train=dlmread(trainfile);
X_test=dlmread(testfile);



% loop through every digit
for n=0:9
	subplot(2,5,n+1);
    % find all vectors labeled with n
	idx=find(X_train(:,end)==n);
	ns=X_train(idx,1:16);
    % compute mean of these vectors
	mean=sum(ns)*(1/size(ns,1));
	xs=mean(1:2:16);
	ys=mean(2:2:16);
    % plot the mean
	plot(xs,ys,'or'); hold on;
	plot(xs,ys,'-');
	axis equal;
	xlim([0 100]);
	ylim([0 100]);
	set(gca,'XTick',[]);
	set(gca,'YTick',[]);
	xlabel(sprintf('%d',n));
end