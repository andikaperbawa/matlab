clear, clc

data=load ('input.dat');
depth=data(:,1);
ndata=length(data);
GR=data(:,2);
ILD=data(:,3);
DT=data(:,4);
RHOB=data(:,5);
NPHI=data(:,6);
Ro=data(:,7);
LOM=data(:,8);
TOCori=data(:,9);
cons=10.^(2.297-(0.1688*LOM));

TOCorix=[];
depthx=[];
for a=1:ndata
    if TOCori(a)>-999.25
        depthx=[depthx;depth(a)];
        TOCorix=[TOCorix;TOCori(a)];
    end
end

TOCpred=[];

RTbase=2; %model awal
DTbase=108; %model awal

% TOC CALCULATION %
DLogR=[];
DLog=0;
for i=1:ndata;
    if GR(i)==-999.25
    elseif ILD(i)==-999.25
    elseif DT(i)==-999.25
        DLog=0;
    else
        DLog=log10(ILD(i)/RTbase)+0.02*(DT(i)-DTbase);
    end
    DLogR=[DLogR;DLog];
end
TOCpred=DLogR.*cons;

%error calculation
error=[];
e=0;
cek=0;
for j=1:ndata;
    if TOCori(j)==-999.25;
    elseif TOCpred(j)==0;
        e=0;
    else
        e=TOCori(j)-TOCpred(j);
        cek=cek+1
    end
    error=[error;e];
end

RMSerror=sqrt((sum(error.^2))/cek)

figure ('name','error plot');
plot (error,-1*depth);

figure ('name','TOC prediction');
plot(TOCpred,-1*depth,'-r');hold on;
plot(TOCorix,-1*depthx,'o');
title('TOC Prediction (Passey Method)', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('TOC (%)');
ylabel ('Depth (ft)');
grid on;

%pencarian yang optimal
winRT=(RTbase-1):0.1:(RTbase+2);
winDT=(DTbase-10):1:(DTbase+20);

poin=[];
for k=1:ndata;
    if TOCori(k)>-999.25;
    poin=[poin;k];
    end
end

TOCprednew=[];
eror=[];
nwinDT=length(winDT);
nwinRT=length(winRT);
npoin=length(poin);

for y=1:nwinDT;
    for x=1:nwinRT;
       % TOC CALCULATION %
        DLogR=[];
        DLog=0;
        for i=1:ndata;
            if GR(i)==-999.25
            elseif ILD(i)==-999.25
            elseif DT(i)==-999.25
            DLog=0;
            else
            DLog=log10(ILD(i)/winRT(x))+0.02*(DT(i)-winDT(y));
            end
            DLogR=[DLogR;DLog];
        end
        TOCpred=DLogR.*cons;

        %error calculation
        error=[];
        e=0;
        cek=0;
        for j=1:ndata;
            if TOCori(j)==-999.25;
            elseif TOCpred(j)==0;
            e=0;
            else
            e=TOCori(j)-TOCpred(j);
            cek=cek+1;
            end
            error=[error;e];
        end
        RMSerrornew(x,y)=sqrt((sum(error.^2))/cek);
        error=0;
        end
end

figure ('name','Error Map');
surf (winRT,winDT,RMSerrornew);



