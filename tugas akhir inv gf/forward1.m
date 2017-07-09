clc, clear

st1=[20 10]     %posisi stasiun 1
st2=[170 0]     %posisi stasiun 2
st3=[10 80]     %posisi stasiun 3
st4=[250 200]   %posisi stasiun 4

x0=50   %posisi X episenter gempa sintetik
y0=50   %posisi Y episenter gempa sintetik

vp=2    %kecepatan rambat gelombang gempa sintetik sebesar 2 km/s

T1=sqrt(((st1(1)-x0)^2)+((st1(2)-y0)^2))/vp %travel time ke stasiun 1
T2=sqrt(((st2(1)-x0)^2)+((st2(2)-y0)^2))/vp %travel time ke stasiun 2
T3=sqrt(((st3(1)-x0)^2)+((st3(2)-y0)^2))/vp %travel time ke stasiun 3
T4=sqrt(((st4(1)-x0)^2)+((st4(2)-y0)^2))/vp %travel time ke stasiun 4

a=[T1 T2 T3 T4]
b=[st1; st2; st3; st4]
c=vp

plot(st1(1),st1(2),'o');hold on;    %menunjukkan titik stasiun pengamat 1
plot(st2(1),st2(2),'o');hold on;    %menunjukkan titik stasiun pengamat 2
plot(st3(1),st3(2),'o');hold on;    %menunjukkan titik stasiun pengamat 3
plot(st4(1),st4(2),'o');hold on;    %menunjukkan titik stasiun pengamat 4
plot(x0,y0,'*');                    %menunjukkan titik gempanya
xlim([0 300]);ylim([0 300]);grid on;
title('PETA LOKASI GEMPA','fontweight', 'bold', 'fontsize', 18);
xlabel('Sumbu x')
ylabel('Sumbu y')