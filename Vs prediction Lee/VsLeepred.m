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
Depth = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'A2:A998');
vdcl  = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'H2:H998');
vqz   = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'I2:I998');
%vcoal = xlsread('F:\Thesis\Matlab_Thesis\Data\MLP-2\Log_Input_MLP2_NeuSon', 1, 'V2:V1698');
por   = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'D2:D998');
rhob  = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'F2:F998');
Vpori = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'G2:G998');
%Vsori = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'N1104:N1698');
%Vsori = smooth(Vsori,9,'moving');
sb    = xlsread('C:\Users\Andika Perbawa\Documents\MATLAB\seismic\dummy', 1, 'L2:L998');

%% Kgrain calculation %%%%%%%%%%%%%%%% Berryman
f1 = vqz;
f2 = vdcl;
%f3 = vcoal;
%[kavg,gavg] = berrym(k1,k2,k3,mu1,mu2,mu3,f1,f2,f3);
[kavg,gavg]= khash(k1,k2,mu1,mu2,f1,f2);
%[kavg,gavg]= kvr(k1,k2,mu1,mu2,f1,f2); %Voigt-Reuss-Hill
[Kreuss,Kvoigt,Kfluid] = vrh(sb,Kb,Ko,Kg);
   
%% Newton rhapson opt
xdata(:,1)=smooth(kavg,9,'moving'); xdata(:,2)=smooth(gavg,9,'moving'); 
xdata(:,3)=smooth(por,9,'moving'); xdata(:,4)=smooth(sb,9,'moving'); 
xdata(:,5)=smooth(rhob,9,'moving');xdata(:,6)=smooth(Kfluid,9,'moving'); ; %xdata(1:3,7)=mux;
Vpori=smooth(Vpori,11,'moving');

options = optimset('Algorithm','trust-region-reflective','ScaleProblem','Jacobian','TolX',1e-4,'TolFun',1e-4);
alfa0 = 5.+(por-por);                    % Starting guess
lb    = 1/100.+(por-por);
ub    = 100.+(por-por);
[alfa] = lsqcurvefit(@vpfun,alfa0,xdata,Vpori,lb,ub,options);

%%  calculating kdry and mhudry %
%====================================================================
alfa = alfa;
gama =(1+2.*alfa)./(1.+alfa); %gamma
kdry = (kavg.*(1.-por))./(1.+alfa.*por);
gdry = (gavg.*(1.-por))./(1.+(gama.*alfa).*por);

%% calculating kfluid %
sg =1.-sb;
so =1.-sb-sg;
Kfluid=1./(sb./Kb+sg./Kg); %% reuss uniformly mixing
    
%% Vp Vs calculation %
Bd = 1. - (kdry./kavg); %(Biot Coefficient)%

%Ksat
Cd = (por)./ Kfluid;
Dd = (Bd-por)./kavg;
Ksat= kdry + ((Bd.^2)./(Cd+Dd));
gsat= gdry;
    
VpLee = 1000.*(sqrt ((Ksat + 4/3.*gsat)./(rhob)));
VpLee = smooth(VpLee,11,'moving');
VsLee = 1000.*(sqrt (gsat./ rhob));
VsLee = smooth(VsLee,11,'moving');
 
clear Cd Dd Bd alfa0 ku kl gu gl lb ub 
    
%% Excel output
Vel_pred = [Depth Vpori VpLee VsLee alfa por];
Lgn1     = {'Depth','Vpori','VpLee','VsLee','alfa','por'};
Lgn2     = {'Depth','por','vsl','sb'};
Input    = [Depth por vdcl sb];
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Vel_pred, 'Vel_Pred', 'A1');
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Lgn1, 'Legend1', 'A1');
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Input, 'Input', 'A1');
%xlswrite('F:\Thesis\Matlab_Thesis\Data\MLP-2\Vp_predict_MLP',Lgn2, 'Legend2', 'A1');    
%% ploting menu %
errordiff=abs(Vpori-VpLee);
errordiffs=abs(Vsori-VsLee(1103:1697,:));

% Create figure
figure1 = figure;
 
% Create axes
axes1 = axes(...
  'FontSize',14,...
  'FontWeight','bold',...
  'Position',[0.06484 0.6193 0.9094 0.3236],...
  'Parent',figure1);
axis(axes1,[1900 2500 0 5000]);
title(axes1,'MBL-1 Measured and Predicted');
xlabel(axes1,'Depth (m)');
ylabel(axes1,'P-wave (m/s)');
box(axes1,'on');
hold(axes1,'all');
 
% Create mutliple lines using matrix input to plot
plot1 = plot(Depth,VpLee,'r',Depth,Vpori,'k',Depth,errordiff);
set(plot1(1),'Color',[1 0 0],'LineWidth',2);
set(plot1(2),'Color',[0 0 0],'LineWidth',1.5);
set(plot1(3),'Color',[0 0.5 0],'LineWidth',1.5);
 
% Create legend
legend1 = legend(...
  axes1,{'Vp (predicted)','Vp (measured)','Abs error'},...
  'FontSize',11,...
  'FontWeight','bold',...
  'Position',[0.07036 0.8409 0.1343 0.09917]);
 
% Create axes
axes2 = axes(...
  'FontSize',14,...
  'FontWeight','bold',...
  'Position',[0.06563 0.2974 0.9086 0.2352],...
  'Parent',figure1);
axis(axes2,[1900 2500 500 3000]);
xlabel(axes2,'Depth (m)');
ylabel(axes2,'Vs (m/s)');
box(axes2,'on');
hold(axes2,'all');
 
% Create plot
plot2 = plot(...
  Depth,VsLee,...
  'Color',[0.5 0 0],...
  'LineWidth',1.5,...
  'Parent',axes2);
 
% Create axes
axes3 = axes(...
  'FontSize',14,...
  'FontWeight','bold',...
  'Position',[0.06485 0.0644 0.9086 0.1667],...
  'Parent',figure1);
axis(axes3,[1900 2500 0 10]);
xlabel(axes3,'Depth (m)');
ylabel(axes3,'Alfa');
box(axes3,'on');
hold(axes3,'all');
 
% Create plot
plot3 = plot(...
  Depth,alfa,...
  'Color',[0.5 0 0],...
  'LineWidth',1.5,...
  'Parent',axes3);
 
figure (2);
scatter (Vpori,VpLee,25,vdcl,'filled');
axis ([2000 5000 2000 5000]);
title('MBL-1 Measured and Predicted');
xlabel('Measured P-wave');
ylabel('Predicted P-wave');
colorbar;
colormap (jet);
hold on
plot (Vpori,Vpori,'-k','Linewidth',1.5);
hold off

figure (3);
subplot(2,1,1);
plot (Depth,VsLee,Depth(1103:1697,:),Vsori,'k');
hold on
plot (Depth(1103:1697,:),errordiffs,'r');
hold off
subplot(2,1,2);
plot (Depth,vdcl);


%fungsi
[kavg,gavg]= khash(k1,k2,mu1,mu2,f1,f2)

kupper=k1+(f2/((1/(k2-k1))+(f1/(k1+(4/3)*mu1))));
klower=k2+(f1/((1/(k2-k2))+(f2/(k2+(4/3)*mu2))));
kavg=(kupper+klower)/2;

gupper=mu1+(f2/((1/(mu2-mu1))+((2*f1*(k1+2*mu1))/(5*mu1*(k1+(4/3)*mu1)))));
glower=mu2+(f1/((1/(mu2-mu1))+((2*f2*(k2+2*mu2))/(5*mu2*(k2+(4/3)*mu2)))));
gavg=(gupper+glower)/2;