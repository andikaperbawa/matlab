clear,clc

x=-3:0.1:3; %diskritisasi x axis
y=-3:0.1:3; %diskritisasi y axis
L=length(x); %pendefinisian banyaknya data x

%mencari nilai z
for i=1:1:L
    for j=1:1:L
        z(i,j)=10-(3*(1-x(i)^2)*exp(-(x(i)^2)-(y(j)+1)^2))-(10*(x(i)/5-(x(i)^3)-(y(j)^5))*exp(-(x(i)^2)-(y(j)^2)))-(1/3*exp(-(x(i)+1)^2-(y(j)^2)));
    end
end

%plotting gambar
contourf(x,y,z,10);
surface(x,y,z);
view(-25,25);
title ('PEAK FUNCTION', 'fontweight', 'bold', 'fontsize', 18);
xlabel('x axis');
ylabel('y axis');
zlabel('z axis');