clc,clear

x=[40 220 280 380]                      %X coordinate for each seismogram station
y=[180 80 400 260]                      %y coordinate for each seismogram station
z=[45.1250 68.7611 98.7929 102.8645]    %Z coordinate for each seismogram station
t=[90 92 98 104]                        %travel time for each station
n=length(x);

%Topography
xx=[0:20:500];
yy=[0:20:500];
xn=length(xx);
yn=length(yy);
for i=1:xn
    for j=1:yn
        zz(i,j)=2*(xx(i)^(3/5))+2*(yy(j)^(1/2));
    end
end


vp=2;   %velocity. assume constant velocity model
x0(1)=100; %initial model of hypocenter in X
y0(1)=100; %initial model of hypocenter in Y
z0(1)=10;   %initial model of hypocenter in Z
misfit(1)=10; %initial misfit

figure(1)
surf(xx,yy,zz); colormap cool;
title('Hypocenter location', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('Longitude');
ylabel ('Latitude');
zlabel ('Elevation');
hold on;
scatter3(x0,y0,z0, 'filled'); 
legend('Topography','Initial Model');hold on;


%iteration
iterasi=0
while misfit(end)>2
        for i=1:n
        r(i)=sqrt(((x(i)-x0(end))^2)+((y(i)-y0(end))^2)+((z(i)-z0(end))^2));     %calculate distance
        t2(i)=r(i)/vp;                                            %travel time from (xo,yo)
        dt(i)=(t(i)-t2(i))^2;                                     %misfit time
        Txx(i)=((x0(end)-x(i))/(sqrt((x(i)-x0(end))^2+((y(i)-y0(end))^2)+((z(i)-z0(end))^2))))/vp;
        Tyy(i)=((y0(end)-y(i))/(sqrt((x(i)-x0(end))^2+((y(i)-y0(end))^2)+((z(i)-z0(end))^2))))/vp;
        Tzz(i)=((z0(end)-z(i))/(sqrt((x(i)-x0(end))^2+((y(i)-y0(end))^2)+((z(i)-z0(end))^2))))/vp;
    end

invX=Txx';
invY=Tyy';
invZ=Tzz';
j=[invX invY invZ]; %matrix jacobian or G

D=inv(j'*j)*j'*(t'-t2'); %linearize a non-linear inversion 
iterasi=iterasi+1
x0(end+1)=x0(end)+D(1); %new Hypocenter location in X after inversion
y0(end+1)=y0(end)+D(2); %new Hypocenter location in Y after inversion
z0(end+1)=z0(end)+D(3); %new Hypocenter location in Z after inversion

misfit(i+1)=sqrt(sum(dt))/n %misfit

figure(1)
scatter3(x0(end),y0(end),z0(end), 'filled');

end

figure(2)
plot ([0:1:iterasi(end)],misfit); xlabel 'Iteration'; ylabel 'misfit';

