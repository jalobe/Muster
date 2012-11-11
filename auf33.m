clear all;
close all;
clc;

[xs,ys] = meshgrid(-5:0.2:5);

%zs = -4*(xs.*xs + ys.*ys);
%x1 = -8 .* xs;
%y1 = -8 .* ys;

%surfc(xs,ys,x1);
%hold on;
%surfc(xs,ys,x1);
%hold on;
%quiver(xs,ys,x1,y1);

zs = e^(-(xs.-0.5).^2-(xs.-0.5).*(ys.+0.5)+(ys.+0.5).^2./(3/4));
surfc(xs,ys,zs);