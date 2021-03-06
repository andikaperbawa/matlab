clear all,close all;
clc;
%% input parameter %%
k1   = 36.6; %bulk modulus quartz Gpa
k2   = 27; % bulk modulus dry clay Gpa
k3   = 4.52; %bulk modulus coal
mu1  = 45; % shear modulus quartz Gpa
mu2  = 17; % shear modulus dry clay Gpa
mu3  = 2.61; %shear modulus coal

% fluid modulus
Kb =2.1;
Kg =0.039;
Ko =1.232;

%% input data
Depth = xlsread('C:\Users\20100001\Desktop\thesis bank data\MATLAB\seismic\dummy.xls', 1, 'A2:A998');
vdcl  = xlsread('C:\Users\20100001\Desktop\thesis bank data\MATLAB\seismic\dummy.xls', 1, 'H2:H998');
vqz   = xlsread('C:\Users\20100001\Desktop\thesis bank data\MATLAB\seismic\dummy.xls', 1, 'I2:I998');
%vcoal = xlsread('F:\Thesis\Matlab_Thesis\Data\MLP-2\Log_Input_MLP2_NeuSon', 1, 'V2:V1698');
por   = xlsread('C:\Users\20100001\Desktop\thesis bank data\MATLAB\seismic\dummy.xls', 1, 'D2:D998');
rhob  = xlsread('C:\Users\20100001\Desktop\thesis bank data\MATLAB\seismic\dummy.xls', 1, 'F2:F998');
Vpori = xlsread('C:\Users\20100001\Desktop\thesis bank data\MATLAB\seismic\dummy.xls', 1, 'G2:G998');
%Vsori = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'N1104:N1698');
%Vsori = smooth(Vsori,9,'moving');
sb    = xlsread('C:\Users\20100001\Desktop\thesis bank data\MATLAB\seismic\dummy.xls', 1, 'L2:L998');
data=length(sb);

%% Kgrain calculation %%%%%%%%%%%%%%%% Berryman
f1 = vqz;
f2 = vdcl;
%f3 = vcoal;
%[kavg,gavg] = berrym(k1,k2,k3,mu1,mu2,mu3,f1,f2,f3);
[kavg,gavg]= khash(k1,k2,mu1,mu2,f1,f2);
%[kavg,gavg]= kvr(k1,k2,mu1,mu2,f1,f2); %Voigt-Reuss-Hill
[Kreuss,Kvoigt,Kfluid] = vrh(sb,Kb,Ko,Kg);
   
%% Newton rhapson opt
%xdata(:,1)=smooth(kavg,9,'moving'); xdata(:,2)=smooth(gavg,9,'moving'); 
%xdata(:,3)=smooth(por,9,'moving'); xdata(:,4)=smooth(sb,9,'moving'); 
%xdata(:,5)=smooth(rhob,9,'moving');xdata(:,6)=smooth(Kfluid,9,'moving'); ; %xdata(1:3,7)=mux;
%Vpori=smooth(Vpori,11,'moving');

%options = optimset('Algorithm','trust-region-reflective','ScaleProblem','Jacobian','TolX',1e-4,'TolFun',1e-4);
%alfa0 = 5.+(por-por);                    % Starting guess
%lb    = 1/100.+(por-por);
%ub    = 100.+(por-por);
%[alfa] = lsqcurvefit(@vpfun,alfa0,xdata,Vpori,lb,ub,options);

%% calculating kfluid %
sg =1.-sb;
so =1.-sb-sg;
Kfluid=1./(sb./Kb+sg./Kg); %% reuss uniformly mixing

%Ksat
Cd = (por)./ Kfluid;


%Vp optimalization

alfa=1:0.05:20;
alfa=alfa';
alfan=length(alfa);
gama =(1+2.*alfa)./(1.+alfa); %gamma
kdry=[];
gdry=[];
gsat=[];
rayalfa=[];

for i=1:data
for j=2:alfan
%1st round
kdry(i) = (kavg(i)*(1-por(i)))/(1+alfa(j-1)*por(i));
gdry(i) = (gavg(i)*(1-por(i)))/(1+(gama(j-1)*alfa(j-1))*por(i));
gsat(i)= gdry(i);
%% Vp Vs calculation %
Bd(i) = 1-(kdry(i)/kavg(i)); %(Biot Coefficient)%

%Ksat
Dd(i) = (Bd(i)-por(i))/kavg(i);
Ksat(i) = kdry(i) + ((Bd(i)^2)/(Cd(i)+Dd(i)));
    
VpLee(j-1) = 1000*(sqrt ((Ksat(i) + 4/3*gsat(i))/(rhob(i))));
error1=VpLee(j-1)-Vpori(i);
alfadata=alfa(j-1);
clear Ksat Kdry gdry;

%2nd round
kdry(i) = (kavg(i)*(1-por(i)))/(1+alfa(j)*por(i));
gdry(i) = (gavg(i)*(1-por(i)))/(1+(gama(j)*alfa(j))*por(i));
%% Vp Vs calculation %
Bd(i) = 1 - (kdry(i)/kavg(i)); %(Biot Coefficient)%

%Ksat
Dd(i) = (Bd(i)-por(i))/kavg(i);
Ksat(i) = kdry(i) + ((Bd(i)^2)/(Cd(i)+Dd(i)));
    
VpLee(j) = 1000*(sqrt ((Ksat(i) + 4/3*gsat(i))/(rhob(i))));
error2=VpLee(j)-Vpori(i);

if (abs(error1)<abs(error2))
    alfadata=alfa(j);
end
end
rayalfa=[rayalfa alfadata];
end
rayalfa=rayalfa';
gama =(1+2.*alfa)./(1.+alfa); %gamma

VpLee = 1000.*(sqrt ((Ksat + 4/3.*gsat)./(rhob')));
VsLee = 1000.*(sqrt (gsat./ rhob'));
VpLee=VpLee';
VsLee=VsLee';

    
%% Excel output
Vel_pred = [Depth Vpori VpLee VsLee rayalfa por];
Lgn1     = {'Depth','Vpori','VpLee','VsLee','alfa','por'};
Lgn2     = {'Depth','por','vsl','sb'};
Input    = [Depth por vdcl sb];
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Vel_pred, 'Vel_Pred', 'A1');
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Lgn1, 'Legend1', 'A1');
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Input, 'Input', 'A1');
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Lgn2, 'Legend2', 'A1');    
%% ploting menu %
errordiff=abs(Vpori-VpLee);
%errordiffs=abs(Vsori-VsLee);

figure(1)
subplot(2,1,1)
plot(Depth, Vpori);
subplot(2,1,2)
plot(Depth, VpLee);