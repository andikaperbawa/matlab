clc,clear

%deklarasi masing-masing variabel data
x=[20 170 10 250]
y=[10 0 80 200]
t=[25+rand() 65+rand() 25+rand() 125+rand()] %time diberi random noise agar lebih realistis 

%asumsi awal
n=length(x);
v=2;        %dalam km/s
xo=0;yo=10; %posisi model awal
misfit=100;

q=1;
%iterasi
while misfit>5 %batas nilai misfit yang diizinkan
for i=1:n     
    r(i)=sqrt(((x(i)-xo)^2)+((y(i)-yo)^2)); %kalkulasi jarak
    t2(i)=r(i)/v;                           %time dari (xo,yo)
    dt(i)=(t(i)-t2(i))^2;                   %misfit time
    Txx(i)=((xo-x(i))/(sqrt((x(i)-xo)^2+(y(i)-yo)^2)))/v;
    Tyy(i)=((yo-y(i))/(sqrt((x(i)-xo)^2+(y(i)-yo)^2)))/v;
    
end
invX=Txx';invY=Tyy';j=[invX invY];
D=inv(j'*j)*j'*(t'-t2');
disp ('iterasi ke-');disp(q);
xo=xo+D(1)
yo=yo+D(2)
misfit=sqrt(sum(dt))/n

%plotting
subplot(2,2,q)
plot(x,y,'o');hold on;%menunjukkan titik stasiun pengamatan
plot(xo,yo,'*');%menunjukkan titik gempanya
xlim([0 300]);ylim([0 300]);grid on;
title('PETA LOKASI GEMPA', 'fontweight', 'bold', 'fontsize', 18);
xlabel('Sumbu x')
ylabel('Sumbu y')
q=q+1;
end