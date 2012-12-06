clear all;
close all;
clc;

% Finde alle möglichen Inputs
A = 0;
B = 1;
s = 2;
for i=1:8
	tmp = [A;B];
	A = [zeros(s,1),tmp];
	B = [ones(s,1),tmp];
	s = s*2;
end

datasize = 512;

X = [A;B];

% Finde Lables
y = zeros(datasize,1);
y(find(X(:,5)==0)) = 1;
y(1) = 0;

X = [ones(datasize,1),X];

% Lernen des Gewichtsvektors w
w = rand(10,1);
y_predict = X * w;
idx = find(y_predict < 0);
y_predict = ones(datasize,1);
y_predict(idx,:) = 0;

count = 0;
while(any(y - y_predict))	
	count = count + 1;
	idx = find(y-y_predict,1,'first');
	if(y(idx)==0);
		w = w - X(idx,:)';
	else
		w = w + X(idx,:)';
	endif
	y_predict = X * w;
	idx = find(y_predict < 0);
	y_predict = ones(datasize,1);
	y_predict(idx,:) = 0;		
endwhile


%a circle
[xs,ys]=meshgrid(-100:100);
I=zeros(size(xs));
I(sqrt(xs.^2+ys.^2)<(0.3*size(xs,1)))=1;
 
%display
figure;
imagesc(I); colormap('gray'); axis equal off;

for i=1:199
	for j=1:199
		v = [1,I(i,j:j+2),I(i+1,j:j+2),I(i+2,j:j+2)];
		v = v * w;
		if(v<0)
		kante = 0;
		else
		kante = 1;
		endif 	
		E(i,j) = kante;
	end
end