clear,clc, close all

% topographic
x=[0:5:100]; % distance x
y=[0:5:100]; % distance y
xn=length(x); % number of grids in x
yn=length(y);  % number of grids in y
for i=1:xn
    for j=1:yn
        z(j,i)=(x(i)*0.001)+(y(j)*0.002); % surface topography
    end
end

st1=[x(3) y(10) z(10,3)];    %position station 1
st2=[x(12) y(5) z(5,12)] ;   %position station 2
st3=[x(15) y(21) z(21,15)];  %position station 3
st4=[x(20) y(14) z(14,20)] ; %position station 4
st5=[x(8) y(8) z(8,8)] ; %position station 5
st6=[x(5) y(5) z(5,5)] ; %position station 6
st7=[x(5) y(18) z(18,5)] ; %position station 7

stasiun=[st1;st2;st3;st4;st5;st6;st7];
xst=stasiun(:,1); %all station in X 
yst=stasiun(:,2); %all station in Y
zst=stasiun(:,3); %all station in Z

hiposenter=[30 45 -20 10];    % position of hypocenter x=30, y=45 , z=-20, to = 10 seconds

vp=5;    % velocity averaged km/s

T1=sqrt(((xst(1)-hiposenter(1))^2)+((yst(1)-hiposenter(2))^2)+((zst(1)-hiposenter(3))^2))/vp + hiposenter(4); %travel time to station 1
T2=sqrt(((xst(2)-hiposenter(1))^2)+((yst(2)-hiposenter(2))^2)+((zst(2)-hiposenter(3))^2))/vp + hiposenter(4); %travel time to station 2
T3=sqrt(((xst(3)-hiposenter(1))^2)+((yst(3)-hiposenter(2))^2)+((zst(3)-hiposenter(3))^2))/vp + hiposenter(4); %travel time to station 3
T4=sqrt(((xst(4)-hiposenter(1))^2)+((yst(4)-hiposenter(2))^2)+((zst(4)-hiposenter(3))^2))/vp + hiposenter(4); %travel time to station 4
T5=sqrt(((xst(5)-hiposenter(1))^2)+((yst(5)-hiposenter(2))^2)+((zst(5)-hiposenter(3))^2))/vp + hiposenter(4); %travel time to station 5
T6=sqrt(((xst(6)-hiposenter(1))^2)+((yst(6)-hiposenter(2))^2)+((zst(6)-hiposenter(3))^2))/vp + hiposenter(4); %travel time to station 6
T7=sqrt(((xst(7)-hiposenter(1))^2)+((yst(7)-hiposenter(2))^2)+((zst(7)-hiposenter(3))^2))/vp + hiposenter(4); %travel time to station 7

t0=[T1; T2; T3; T4 ; T5 ; T6; T7]          % travel time synthetic for all stations

%% plotting
figure(1);
colormap jet; hold on
surf(x,y,z);title('Elevation of Surface Topography', 'fontweight', 'bold', 'fontsize', 18);
zlim([0 0.4]);
xlabel('Latitude [km]'); ylabel('Longitude [km]');zlabel('Elevation [km]'); set(gca,'FontSize',16)
scatter3(xst,yst,zst,75,'filled','m'); hold off

figure(2);
colormap jet
surf(x,y,z); hold on;
title('Map of Synthetic Hypocenter', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('Longitude [km]');
ylabel ('Latitude [km]');
zlabel ('Elevation [km]');
scatter3(xst,yst,zst,55,'filled','g');
scatter3(hiposenter(1),hiposenter(2),hiposenter(3),105,'filled');
text(xst,yst,'1')
set(gca,'FontSize',16); hold off;