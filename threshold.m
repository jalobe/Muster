function t = threshold(u1,u2,var1,var2)
    if(u1 > u2)
        t = threshold(u2,u1,var2,var1);
        return;
    endif
    if(var1 == var2)
        t = (u1 + u2)/2;
    else
        p = 2*(u2*var1 - u1*var2)/(var2 - var1);
        q = (u1*var2 - u2*var1 - 2*log(sqrt(var2)/sqrt(var1))*var1*var2)/(var2 - var1);
        term1 = -p/2;
        term2 = sqrt((p/2)^2-q);
        t1 = term1 + term2;
        t2 = term1 - term2;
        if(t1 < u2 && t1 > u1)
            t = t1;
        else
            t = t2;
        endif
    endif
endfunction
