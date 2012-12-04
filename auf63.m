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
