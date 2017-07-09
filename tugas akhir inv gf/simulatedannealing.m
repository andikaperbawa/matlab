clear,clc

%inisiasi batas
%X axis
x=-3:0.1:3
Xmin=-3;Xmax=3;

%Y axis
y=-3:0.1:3
Ymin=-3;Ymax=3 

L=length(x)

%inisiasi model awal
M0=[0 0] 

%inisiasi peak function
F0=10-3*(1-M0(1))^2*exp(-(M0(1)^2)-(M0(2)+1)^2)-10*(M0(1)/5-M0(1)^3-M0(2)^5)*exp(-M0(1)^2-M0(2)^2)-1/3*exp(-(M0(1)+1)^2-M0(2)^2) 

%inisialisasi kondisi
T=1;
iter=0;

%solusi
while (T>0.01)
    R=[rand() rand()];                                      %memasukkan angka random number antara 0 s.d. 1
    Mr=[Xmin+(R(1)*(Xmax-Xmin)) Ymin+(R(2)*(Ymax-Ymin))];   %model dengan masukkan random number
    Fr=10-3*(1-Mr(1))^2*exp(-(Mr(1)^2)-(Mr(2)+1)^2)-10*(Mr(1)/5-Mr(1)^3-Mr(2)^5)*exp(-Mr(1)^2-Mr(2)^2)-1/3*exp(-(Mr(1)+1)^2-Mr(2)^2)

    %misfit
    M1=M0;
    M2=Mr;
    miss1=F0;
    miss2=Fr;
    dm=miss2-miss1;

    %syarat model
    if  dm<=0
        M0=M2
        miss1=miss2
    else
        P=exp(-dm/T);
        R=rand();
    if  R<=P
        M0=M2;
        miss1=miss2
    else
        M0=M1;
        miss1=miss1
    end
    end
%fungsi penurunan temperatur
T=0.98*T;
iter=iter+1
end

%hasil akhir
model_akhir=M1
missfit_akhir=miss1

%plotting
for i=1:1:L
    for j=1:1:L
        z(i,j)=10-(3*(1-x(i)^2)*exp(-(x(i)^2)-(y(j)+1)^2))-(10*(x(i)/5-(x(i)^3)-(y(j)^5))*exp(-(x(i)^2)-(y(j)^2)))-(1/3*exp(-(x(i)+1)^2-(y(j)^2)));
    end
end
contourf(x,y,z,20); hold on; colormap jet;
plot (M1(1),M1(2),'o'); hold on;
title ('PEAK FUNCTION', 'fontweight', 'bold', 'fontsize', 18);
xlabel('x axis');
ylabel('y axis');
zlabel('z axis');