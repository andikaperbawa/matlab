function varargout = BHGM_AP2009(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BHGM_AP2009_OpeningFcn, ...
                   'gui_OutputFcn',  @BHGM_AP2009_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


function BHGM_AP2009_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = BHGM_AP2009_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function inputdata_edit_Callback(hObject, eventdata, handles)
input = get(hObject,'String');

function inputdata_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function inputdata_pushbutton_Callback(hObject, eventdata, handles)
[fileName, filePath] = uigetfile('*.txt','Select input data anomali'); % receive and the path from the user
if fileName==0          % if it is canceled
    fileName='';        % create an empty name
    filePath='';        % create an empty path
end
fullname = [filePath fileName] % form a new name
set(handles.inputdata_pushbutton,'String', fullname);

function dimXb_editbutton_Callback(hObject, eventdata, handles)
dimXb = str2double(get(hObject,'String'));
if (isempty(dimXb))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function dimXb_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dimXa_editbutton_Callback(hObject, eventdata, handles)
dimXa = str2double(get(hObject,'String'));
if (isempty(dimXa))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function dimXa_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dimYb_editbutton_Callback(hObject, eventdata, handles)
dimYb = str2double(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(dimYb))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function dimYb_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dimYa_editbutton_Callback(hObject, eventdata, handles)
dimYa = str2double(get(hObject,'String'));
if (isempty(dimYa))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function dimYa_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dimZb_editbutton_Callback(hObject, eventdata, handles)
dimZb = str2double(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(dimZb))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function dimZb_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dimZa_editbutton_Callback(hObject, eventdata, handles)
dimZa = str2double(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(dimZa))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function dimZa_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gx_input_Callback(hObject, eventdata, handles)
gx = str2double(get(hObject,'String'));
if (isempty(gx))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function gx_input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gy_input_Callback(hObject, eventdata, handles)
gy = str2double(get(hObject,'String'));
if (isempty(gy))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function gy_input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gz_input_Callback(hObject, eventdata, handles)
gz = str2double(get(hObject,'String'));
if (isempty(gz))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function gz_input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function showmodel_pushbutton_Callback(hObject, eventdata, handles)
process(handles);

function inputX_editbutton_Callback(hObject, eventdata, handles)
inputX = str2double(get(hObject,'String'));
if (isempty(inputX))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function inputX_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function inputY_editbutton_Callback(hObject, eventdata, handles)
inputY = str2double(get(hObject,'String'));
if (isempty(inputY))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function inputY_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function start_editbutton_Callback(hObject, eventdata, handles)
start = str2double(get(hObject,'String'));
if (isempty(start))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function start_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function finish_editbutton_Callback(hObject, eventdata, handles)
finish = str2double(get(hObject,'String'));
if (isempty(finish))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function finish_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function interval_editbutton_Callback(hObject, eventdata, handles)
interval = str2double(get(hObject,'String'));
if (isempty(interval))
     set(hObject,'String','0')
end
guidata(hObject, handles);

function interval_editbutton_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function plotBHGM_pushbutton_Callback(hObject, eventdata, handles)
fullname = get(handles.inputdata_pushbutton, 'String') % read the name from editPath
data = dlmread(fullname,';')    % read the matrix from file
x=data(:,1);
y=data(:,2); 
z=data(:,3);
ro=data(:,4);
number=length(x);

bbx=get(handles.dimXb_editbutton,'String');
bx=str2double(bbx);
bby=get(handles.dimYb_editbutton,'String');
by=str2double(bby);
bbz=get(handles.dimZb_editbutton,'String');
bz=str2double(bbz);

aax=get(handles.dimXa_editbutton,'String');
ax=str2double(aax);
aay=get(handles.dimYa_editbutton,'String');
ay=str2double(aay);
aaz=get(handles.dimZa_editbutton,'String');
az=str2double(aaz);

ggx=get(handles.gx_input,'String');
gx=str2double(ggx);
ggy=get(handles.gy_input,'String');
gy=str2double(ggy);
ggz=get(handles.gz_input,'String');
gz=str2double(ggz);

x0=[bx:gx:ax];
y0=[by:gy:ay];

nx0=length(x0);
ny0=length(y0);

xxx=get(handles.inputX_editbutton,'String');
xx=str2double(xxx);
yyy=get(handles.inputY_editbutton,'String');
yy=str2double(yyy);

aaa=get(handles.start_editbutton,'String');
ab=str2double(aaa);
bbb=get(handles.finish_editbutton,'String');
bb=str2double(bbb);
iii=get(handles.interval_editbutton,'String');
ii=str2double(iii);
ii0=[ab:ii:bb];
nii=length(ii0);

gbaru(nii)=0;
for q=1:number
        xb=x(q)-gx; xa=x(q)+gx;
        yb=y(q)-gy; ya=y(q)+gy;
        zb=z(q)-gz; za=z(q)+gz;
        rho=ro(q);
        g=logborehole(xb,yb,zb,xa,ya,za,rho,xx,yy,ii0,nii);
        gbaru=gbaru+g;
end

figure (2)
plot(gbaru,-ii0,'LineWidth',2); hold on; grid on;
title('Log Borehole Gravity', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('mGal');
ylabel ('depth');
hold on;

% --- Executes on button press in surface.
function surface_Callback(hObject, eventdata, handles)
fullname = get(handles.inputdata_pushbutton, 'String') % read the name from editPath
data = dlmread(fullname,';')    % read the matrix from file
x=data(:,1);
y=data(:,2); 
z=data(:,3);
ro=data(:,4);
number=length(x);

bbx=get(handles.dimXb_editbutton,'String');
bx=str2double(bbx);
bby=get(handles.dimYb_editbutton,'String');
by=str2double(bby);
bbz=get(handles.dimZb_editbutton,'String');
bz=str2double(bbz);

aax=get(handles.dimXa_editbutton,'String');
ax=str2double(aax);
aay=get(handles.dimYa_editbutton,'String');
ay=str2double(aay);
aaz=get(handles.dimZa_editbutton,'String');
az=str2double(aaz);

ggx=get(handles.gx_input,'String');
gx=str2double(ggx);
ggy=get(handles.gy_input,'String');
gy=str2double(ggy);
ggz=get(handles.gz_input,'String');
gz=str2double(ggz);

x0=[bx:gx:ax];
y0=[by:gy:ay];
z0=0;

nx0=length(x0);
ny0=length(y0);

gbaru(ny0,nx0)=0;
for q=1:number
        xb=x(q)-gx; xa=x(q)+gx;
        yb=y(q)-gy; ya=y(q)+gy;
        zb=z(q)-gz; za=z(q)+gz;
        rho=ro(q);
        g=kotaksurface(x0,y0,z0,xb,yb,zb,xa,ya,za,nx0,ny0,rho);
        gbaru=gbaru+g;
end
figure (3)
subplot (2,1,1)
colormap jet
surf(x0,y0,gbaru); hold on;
shading interp;
title('Surface Anomaly Gravity', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('X');
ylabel ('Y');
zlabel ('mGal');
hold on;

subplot (2,1,2)
contourf(x0,y0,gbaru); hold on;
colormap jet
colorbar('location','southoutside')
title('Kontur Respon Gravity', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('X');
ylabel ('Y');
hold on;

function save_pushbutton_Callback(hObject, eventdata, handles)
fullname = get(handles.inputdata_pushbutton, 'String') % read the name from editPath
data = dlmread(fullname,';')    % read the matrix from file
x=data(:,1);
y=data(:,2); 
z=data(:,3);
ro=data(:,4);
number=length(x);

bbx=get(handles.dimXb_editbutton,'String');
bx=str2double(bbx);
bby=get(handles.dimYb_editbutton,'String');
by=str2double(bby);
bbz=get(handles.dimZb_editbutton,'String');
bz=str2double(bbz);

aax=get(handles.dimXa_editbutton,'String');
ax=str2double(aax);
aay=get(handles.dimYa_editbutton,'String');
ay=str2double(aay);
aaz=get(handles.dimZa_editbutton,'String');
az=str2double(aaz);

ggx=get(handles.gx_input,'String');
gx=str2double(ggx);
ggy=get(handles.gy_input,'String');
gy=str2double(ggy);
ggz=get(handles.gz_input,'String');
gz=str2double(ggz);

x0=[bx:gx:ax];
y0=[by:gy:ay];

nx0=length(x0);
ny0=length(y0);

xxx=get(handles.inputX_editbutton,'String');
xx=str2double(xxx);
yyy=get(handles.inputY_editbutton,'String');
yy=str2double(yyy);

aaa=get(handles.start_editbutton,'String');
ab=str2double(aaa);
bbb=get(handles.finish_editbutton,'String');
bb=str2double(bbb);
iii=get(handles.interval_editbutton,'String');
ii=str2double(iii);
ii0=[ab:ii:bb];
nii=length(ii0);

gbaru(nii)=0;
for q=1:number
        xb=x(q)-gx; xa=x(q)+gx;
        yb=y(q)-gy; ya=y(q)+gy;
        zb=z(q)-gz; za=z(q)+gz;
        rho=ro(q);
        g=logborehole(xb,yb,zb,xa,ya,za,rho,xx,yy,ii0,nii);
        gbaru=gbaru+g;
end
intfinal=ii0';
gfinal=gbaru';
matrix=[intfinal gfinal];

[filename, pathname] = uiputfile('*.txt','save into text file');
fullname2=[pathname filename];
save(fullname2,'-ascii','matrix');


function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function process(handles)
fullname = get(handles.inputdata_pushbutton, 'String') % read the name from editPath
data = dlmread(fullname,';')    % read the matrix from file
x=data(:,1);
y=data(:,2); 
z=data(:,3);
ro=data(:,4);
number=length(x);

bbx=get(handles.dimXb_editbutton,'String');
bx=str2double(bbx);
bby=get(handles.dimYb_editbutton,'String');
by=str2double(bby);
bbz=get(handles.dimZb_editbutton,'String');
bz=str2double(bbz);

aax=get(handles.dimXa_editbutton,'String');
ax=str2double(aax);
aay=get(handles.dimYa_editbutton,'String');
ay=str2double(aay);
aaz=get(handles.dimZa_editbutton,'String');
az=str2double(aaz);

ggx=get(handles.gx_input,'String');
gx=str2double(ggx);
ggy=get(handles.gy_input,'String');
gy=str2double(ggy);
ggz=get(handles.gz_input,'String');
gz=str2double(ggz);

x0=[bx:gx:ax];
y0=[by:gy:ay];

nx0=length(x0);
ny0=length(y0);

xxx=get(handles.inputX_editbutton,'String');
xx=str2double(xxx);
yyy=get(handles.inputY_editbutton,'String');
yy=str2double(yyy);

aaa=get(handles.start_editbutton,'String');
ab=str2double(aaa);
bbb=get(handles.finish_editbutton,'String');
bb=str2double(bbb);
iii=get(handles.interval_editbutton,'String');
ii=str2double(iii);

figure (1)
tt=[bx by bz;ax by bz;ax ay bz;bx ay bz;bx ay -az;bx by -az;ax ay -az;ax ay -az]; 
plot3(tt(:,1),tt(:,2),tt(:,3),'-w'); grid on;
title('Body Anomaly', 'fontweight', 'bold', 'fontsize', 18);
xlabel ('X');
ylabel ('Y');
zlabel ('kedalaman'); hold on;
for m=1:number
    bbb=plotcube([x(m) y(m) -z(m)],[2*gx 2*gy 2*gz],[0 0 0],[1 1 1 1 1 1 1 1],0.5,1);hold on;
end
hold on
vv = ab:ii:bb;
for lb = 1:length(vv)
    ccc = plotcube([xx yy -vv(lb)],[0.5*gx 0.5*gy ii],[0 0 0],[0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2],1,0);hold on;
end

function handle = plotcube(coordinates,size,orientation,color8,transparency,LineOnOff)
    %compute the 8 corners
    c1 = get3Dpoints(coordinates,[-size(1)/2;-size(2)/2;-size(3)/2],orientation);
    c2 = get3Dpoints(coordinates,[+size(1)/2;-size(2)/2;-size(3)/2],orientation);
    c3 = get3Dpoints(coordinates,[-size(1)/2;-size(2)/2;+size(3)/2],orientation);
    c4 = get3Dpoints(coordinates,[+size(1)/2;-size(2)/2;+size(3)/2],orientation);

    c5 = get3Dpoints(coordinates,[-size(1)/2;+size(2)/2;-size(3)/2],orientation);
    c6 = get3Dpoints(coordinates,[+size(1)/2;+size(2)/2;-size(3)/2],orientation);
    c7 = get3Dpoints(coordinates,[-size(1)/2;+size(2)/2;+size(3)/2],orientation);
    c8 = get3Dpoints(coordinates,[+size(1)/2;+size(2)/2;+size(3)/2],orientation);

    %plot the 6 sides
    hold on;
    handle(1) = fill3([c1(1) c2(1) c4(1) c3(1) c3(1) c3(1) c3(1) c3(1)],[c1(2) c2(2) c4(2) c3(2) c3(2) c3(2) c3(2) c3(2)],[c1(3) c2(3) c4(3) c3(3) c3(3) c3(3) c3(3) c3(3)],[color8(1) color8(2) color8(4) color8(3) color8(3) 0 1 color8(3)]);
    handle(2) = fill3([c2(1) c4(1) c8(1) c6(1) c6(1) c6(1) c6(1) c6(1)],[c2(2) c4(2) c8(2) c6(2) c6(2) c6(2) c6(2) c6(2)],[c2(3) c4(3) c8(3) c6(3) c6(3) c6(3) c6(3) c6(3)],[color8(2) color8(4) color8(8) color8(6) color8(6) 0 1 color8(6)]);
    handle(3) = fill3([c5(1) c6(1) c8(1) c7(1) c7(1) c7(1) c7(1) c7(1)],[c5(2) c6(2) c8(2) c7(2) c7(2) c7(2) c7(2) c7(2)],[c5(3) c6(3) c8(3) c7(3) c7(3) c7(3) c7(3) c7(3)],[color8(5) color8(6) color8(8) color8(7) color8(7) 0 1 color8(7)]);
    handle(4) = fill3([c1(1) c3(1) c7(1) c5(1) c5(1) c5(1) c5(1) c5(1)],[c1(2) c3(2) c7(2) c5(2) c5(2) c5(2) c5(2) c5(2)],[c1(3) c3(3) c7(3) c5(3) c5(3) c5(3) c5(3) c5(3)],[color8(1) color8(3) color8(7) color8(5) color8(5) 0 1 color8(5)]);
    handle(5) = fill3([c1(1) c2(1) c6(1) c5(1) c5(1) c5(1) c5(1) c5(1)],[c1(2) c2(2) c6(2) c5(2) c5(2) c5(2) c5(2) c5(2)],[c1(3) c2(3) c6(3) c5(3) c5(3) c5(3) c5(3) c5(3)],[color8(1) color8(2) color8(6) color8(5) color8(5) 0 1 color8(5)]);
    handle(6) = fill3([c3(1) c4(1) c8(1) c7(1) c7(1) c7(1) c7(1) c7(1)],[c3(2) c4(2) c8(2) c7(2) c7(2) c7(2) c7(2) c7(2)],[c3(3) c4(3) c8(3) c7(3) c7(3) c7(3) c7(3) c7(3)],[color8(3) color8(4) color8(8) color8(7) color8(7) 0 1 color8(7)]);

    %set transparency
    alpha(handle,transparency)
    %set LineStyle
    if LineOnOff == 0
        for cnt1 = 1:1:6
            set(handle(cnt1),'LineStyle','none');
        end
    end

function erg_coordinates = get3Dpoints(vec,coordinates,orientation);
    rot_mat = [...
                cos(orientation(1))*cos(orientation(2)),                  -cos(orientation(1))*sin(orientation(2)),                    sin(orientation(1));...
                cos(orientation(3))*sin(orientation(2))+sin(orientation(3))*sin(orientation(1))*cos(orientation(2)), cos(orientation(3))*cos(orientation(2))-sin(orientation(3))*sin(orientation(1))*sin(orientation(2)), -sin(orientation(3))*cos(orientation(1));...
                sin(orientation(3))*sin(orientation(2))-cos(orientation(3))*sin(orientation(1))*cos(orientation(2)), sin(orientation(3))*cos(orientation(2))+cos(orientation(3))*sin(orientation(1))*sin(orientation(2)),  cos(orientation(3))*cos(orientation(1))...
            ];

    erg_coordinates = (vec'+rot_mat*coordinates)';

function g=logborehole(xb,yb,zb,xa,ya,za,rho,xx,yy,ii0,nii)
G=6.670e-8;
m2cm=1e2;
cgs2mig=1e3;

isign=[-1 1];
for n=1:nii
    sum=0;
        for i=1:2
            for j=1:2
                for k=1:2
                x(1)=xx-xb; x(2)=xx-xa;
                y(1)=yy-yb; y(2)=yy-ya;
                z(1)=ii0(n)-zb; z(2)=ii0(n)-za;
            
                rijk=sqrt((x(i).^2)+(y(j).^2)+(z(k).^2));
                ijk=isign(i)*isign(j)*isign(k);
                arg1=atan2((x(i)*y(j)),(z(k)*rijk));
                if lt(arg1,0.)
                    arg1=arg1+(2*pi);
                end

                if (y(j)==-rijk)
                    y(j) = rijk;
                end
                arg2=rijk+y(j); 
                arg2=log(arg2);
              
                if (x(i)==-rijk)
                    x(i) = rijk;
                end
                arg3=rijk+x(i);
                arg3=log(arg3);
                sum = sum + ijk*((z(k)*arg1)-(x(i)*arg2)-(y(j)*arg3));
                end
            end
        end
   g(n)=rho*G*sum*cgs2mig*m2cm;
end


function g=kotaksurface(x0,y0,z0,xb,yb,zb,xa,ya,za,nx0,ny0,rho)
G=6.670e-8;
m2cm=1e2;
cgs2mig=1e3;
isign=[-1 1];
for n=1:ny0;
    for m=1:nx0;
        sum=0;
        for i=1:2;
            for j=1:2;
                for k=1:2;
                x(1)=x0(m)-xb; x(2)=x0(m)-xa;
                y(1)=y0(n)-yb; y(2)=y0(n)-ya;
                z(1)=z0-zb; z(2)=z0-za;
            
               rijk=sqrt((x(i).^2)+(y(j).^2)+(z(k).^2));
                ijk=isign(i)*isign(j)*isign(k);
                arg1=atan2((x(i)*y(j)),(z(k)*rijk));
                if lt(arg1,0.)
                    arg1=arg1+(2*pi);
                end

                if (y(j)==-rijk)
                    y(j) = rijk;
                end
                arg2=rijk+y(j); 
                arg2=log(arg2);
              
                if (x(i)==-rijk)
                    x(i) = rijk;
                end
                arg3=rijk+x(i);
                arg3=log(arg3);
                sum = sum + ijk*((z(k)*arg1)-(x(i)*arg2)-(y(j)*arg3));
                end
            end
        end
        g(n,m)=rho*G*sum*cgs2mig*m2cm;
    end
end