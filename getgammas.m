function [gamma1,gamma2] = getgammas(grad1,grad2,oldgamma1,oldgamma2,u,d,gammamax,gammamin)
	for(i=1:size(grad1,1))
		for(j=1:size(grad1,2))
			if(grad1(i,j)>0)
				ret1(i,j) = min(oldgamma1(i,j)*u,gammamax);
			elseif(grad1(i,j)<0)
				ret1(i,j) = max(oldgamma1(i,j)*d,gammamin);
			else
				ret1(i,j) = oldgamma1(i,j);
			endif
		end
	end
	
	for(i=1:size(grad2,1))
		for(j=1:size(grad2,2))
			if(grad2(i,j)>0)
				ret2(i,j) = min(oldgamma2(i,j)*u,gammamax);
			elseif(grad2(i,j)<0)
				ret2(i,j) = max(oldgamma2(i,j)*d,gammamin);
			else
				ret2(i,j) = oldgamma2(i,j);
			endif
		end
	end
	
	gamma1 = ret1;
	gamma2 = ret2;
endfunction