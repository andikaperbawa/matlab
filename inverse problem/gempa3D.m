clc
clear all
close all

st=load ('STATION.txt');
vp=5; %m/s
%% Hypo 1
event=load('Tobs-Hypo2.txt');
realhypo=[191820.0622	579876.8457 -16];

% event=load('Tobs-Hypo7.txt');
% realhypo=[199581.0162	578736.2225	-19];

[n,m]=size(event);
sx=[];
sy=[];
sz=[];
for i=1:n
    sx(i)=st(event(i),1);
    sy(i)=st(event(i),2);
    z(i)=st(event(i),3);
    t(i)=event(i,5);
end
sx=sx' ; sy=sy' ; z=z'; t=t';
%%
xx=mean(sx);              %initial model of hypocenter in X
yy=mean(sy);              %initial model of hypocenter in Y

xxx=ones(n,1)*xx;
yyy=ones(n,1)*yy;

x=(sx-xxx)/1000;
y=(sy-yyy)/1000;
z=z/1000;

x0=0;              %initial model of hypocenter in X
y0=0;              %initial model of hypocenter in Y
z0=-5;                   %initial model of hypocenter in Z
t0=0;                    %initial time when hypocenter is activated

XX(1)=x0;
YY(1)=y0;
ZZ(1)=z0;
TT(1)=t0;

misfit=10;
iter=0
tpred=( sqrt( (x-x0).^2 + (y-y0).^2 + (z-z0).^2 ) / vp ) + t0;
res(:,1)=t - tpred;
%%
while misfit>0.6
    
TTx=( (x0-x) ./ ( sqrt( (x0-x).^2+(y0-y).^2+(z0-z).^2 ) ) ) / vp;
TTy=( (y0-y) ./ ( sqrt( (x0-x).^2+(y0-y).^2+(z0-z).^2 ) ) ) / vp;
TTz=( (z0-z) ./ ( sqrt( (x0-x).^2+(y0-y).^2+(z0-z).^2 ) ) ) / vp;

H=[TTx TTy TTz ones(n,1)];
Damp=eye(4);
D=((H'*H+0.001*Damp)\H')*res(:,end);

x0=x0+D(1);
y0=y0+D(2);
z0=z0+D(3);
t0=t0+D(4);
tpred=( sqrt( (x-x0).^2 + (y-y0).^2 + (z-z0).^2 ) / vp ) + t0;
res=[res (t-tpred)];
misfit=sqrt(sum(res(:,end).^2));
iter=iter+1

XX(iter+1)=x0;
YY(iter+1)=y0;
ZZ(iter+1)=z0;
TT(iter+1)=t0;
end
XX=XX'*1000+xx*ones(iter+1,1);
YY=YY'*1000+yy*ones(iter+1,1);
ZZ=ZZ';

errorepi=sqrt((realhypo(1)-XX(end)).^2+(realhypo(2)-YY(end)).^2)
errorz=abs(ZZ(end)-realhypo(3))

figure(1)
subplot(121)
scatter3(sx,sy,z,100,'filled'); hold on;
for ii=1:iter+1
    scatter3(XX(ii),YY(ii),ZZ(ii),150,'filled'); hold on;
end
scatter3(realhypo(1),realhypo(2),realhypo(3),150,'filled');
legend ({('Seismic Station'),('Initial Model'),('Iteration 1'),('Iteration 2'),('Reported Hypocenter')},'Location','northeast','FontSize',10,'FontWeight','bold');
title ('Hypocenter Location (Map View)','FontSize',20);
xlabel ('Latitude [m]','FontSize',15);
ylabel ('Longitude [m]','FontSize',15);
zlabel ('Depth [km]','FontSize',15);

subplot(122)
scatter3(sx,sy,z,100,'filled'); hold on;
for ii=1:iter+1
    scatter3(XX(ii),YY(ii),ZZ(ii),150,'filled'); hold on;
end
scatter3(realhypo(1),realhypo(2),realhypo(3),150,'filled');
legend ({('Seismic Station'),('Initial Model'),('Iteration 1'),('Iteration 2'),('Reported Hypocenter')},'Location','east','FontSize',10,'FontWeight','bold');
title ('Hypocenter Location (Section View)','FontSize',20);
xlabel ('Latitude [m]','FontSize',15);
ylabel ('Longitude m]','FontSize',15);
zlabel ('Depth [km]','FontSize',15);
