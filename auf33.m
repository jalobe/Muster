clear all;
close all;
clc;


[xs,ys] = meshgrid(-3:.2:3);
zs1 = -4*(xs.^2 + ys.^2);
zs2 = e.^(-((xs.- 0.5).^2-(xs.- 0.5).*(ys .+ 0.5)+(ys .+ 0.5).^2)/(3/4));
dxs = -(4/3)*(2*(xs.-1/2) - (ys.+1/2)).*zs2;
dys = -(4/3)*(-xs .+ (1/2) + 2*(ys .+ (1/2))).*zs2;
    

#surfc(xs,ys,zs1);
surfc(xs,ys,zs2);
surfc(xs,ys,dys);
hold on;

#quiver3(xs,ys,zs1,-8*xs,-8*ys,zs1);
#quiver3(xs,ys,zs2,dxs,dys,ones(size(zs2)));