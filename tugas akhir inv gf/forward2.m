clear,clc

%pembuatan topografi
x=[0:20:500];
y=[0:20:500];
xn=length(x);
yn=length(y);
for i=1:xn
    for j=1:yn
        z(i,j)=2*(x(i)^(3/5))+2*(y(j)^(1/2))
    end
end

st1=[x(3) y(10) z(3,10)]    %posisi stasiun 1
st2=[x(12) y(5) z(12,5)]    %posisi stasiun 2
st3=[x(15) y(21) z(15,21)]  %posisi stasiun 3
st4=[x(20) y(14) z(20,14)]  %posisi stasiun 4

stasiun=[st1;st2;st3;st4]
xst=stasiun(:,1); %pendeklarasian posisi X tiap stasiun
yst=stasiun(:,2); %pendeklarasian posisi Y tiap stasiun
zst=stasiun(:,3); %pendeklarasian posisi Z tiap stasiun

hiposenter=[200 250 0]    % posisi hiposenter sintetik x=200, y=250 , z=0

vp=2    % kecepatan rambat gelombang gempa dalam km/s

T1=sqrt(((xst(1)-hiposenter(1))^2)+((yst(1)-hiposenter(2))^2)+((zst(1)-hiposenter(3))^2))/vp; %travel time ke stasiun 1
T2=sqrt(((xst(2)-hiposenter(1))^2)+((yst(2)-hiposenter(2))^2)+((zst(2)-hiposenter(3))^2))/vp; %travel time ke stasiun 2
T3=sqrt(((xst(3)-hiposenter(1))^2)+((yst(3)-hiposenter(2))^2)+((zst(3)-hiposenter(3))^2))/vp; %travel time ke stasiun 3
T4=sqrt(((xst(4)-hiposenter(1))^2)+((yst(4)-hiposenter(2))^2)+((zst(4)-hiposenter(3))^2))/vp; %travel time ke stasiun 4

t0=[round(T1) round(T2) round(T3) round(T4)]            % travel time sintetik untuk setiap stasiun

%plotting
colormap jet
surf(x,y,z); hold on;
title('PETA LOKASI HIPOSENTER GEMPA SINTETIS', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('Longitude');
ylabel ('Latitude');
zlabel ('Elevasi'); hold on;
scatter3(xst,yst,zst,'filled'); hold on;
scatter3(hiposenter(1),hiposenter(2),hiposenter(3),'filled'); hold on;