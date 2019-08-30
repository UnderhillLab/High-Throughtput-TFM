function varargout = island_boundary_GUI(varargin)

% This program was produced at the University of Illinois, by Ian Berg in
% 2019. This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as
% published by the Free Software Foundation, either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.



% GUI for running cell_boundary iterively with input from the user or
% allowing used to manually draw boundaries


% ISLAND_BOUNDARY_GUI MATLAB code for island_boundary_GUI.fig
%      ISLAND_BOUNDARY_GUI, by itself, creates a new ISLAND_BOUNDARY_GUI or raises the existing
%      singleton*.
%
%      H = ISLAND_BOUNDARY_GUI returns the handle to a new ISLAND_BOUNDARY_GUI or the handle to
%      the existing singleton*.
%
%      ISLAND_BOUNDARY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISLAND_BOUNDARY_GUI.M with the given input arguments.
%
%      ISLAND_BOUNDARY_GUI('Property','Value',...) creates a new ISLAND_BOUNDARY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before island_boundary_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to island_boundary_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help island_boundary_GUI

% Last Modified by GUIDE v2.5 21-Jul-2019 13:42:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @island_boundary_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @island_boundary_GUI_OutputFcn, ...
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


% --- Executes just before island_boundary_GUI is made visible.
function island_boundary_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to island_boundary_GUI (see VARARGIN)

% Choose default command line output for island_boundary_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

im_bf = varargin{1};
sigma = varargin{2};
cny = varargin{3};
di = varargin{4};
boundary_points = varargin{5};
mask = varargin{6};

%handles.SliderxListener = addlistener(handles.sens_slider,'Value','PostSet',@(s,e) XListenerCallBack);
setappdata(handles.axes1, 'im_bf', im_bf);
setappdata(handles.axes1, 'boundary_points', boundary_points);
setappdata(handles.axes1, 'mask', mask);
setappdata(handles.manual_button, 'man_count',0);

setappdata(handles.blur_slider, 'sigma', sigma);
set(handles.blur_text,'String',num2str(sigma));
set(handles.blur_slider,'Max',1000);
set(handles.blur_slider,'SliderStep',[1/100 10/100]);
set(handles.blur_slider,'Value',sigma);

setappdata(handles.sens_slider, 'cny', cny);
set(handles.sens_text,'String',num2str(cny));
set(handles.sens_slider,'Max',.1);
set(handles.sens_slider,'SliderStep',[.01 .05]);
set(handles.sens_slider,'Value',cny);

set(handles.er_text,'String',num2str(di));
setappdata(handles.er_slider, 'di', di);
set(handles.er_slider,'Max',100);
set(handles.er_slider,'SliderStep',[1/100 10/100]);
set(handles.er_slider,'Value',di);


imagesc(im_bf);hold on;axis off;axis equal;colormap gray
for i = 1:length(boundary_points)
    boundary = boundary_points{i};
    xrub = boundary(:,2);
    yrub = boundary(:,1);
    plot(xrub, yrub,'-r');
end
% UIWAIT makes island_boundary_GUI wait for user response (see UIRESUME)
uiwait;


% --- Outputs from this function are returned to the command line.
function varargout = island_boundary_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;

varargout{1} = str2num(get(handles.blur_text,'String'));
varargout{2} = [str2num(get(handles.sens_text,'String'))*.4 str2num(get(handles.sens_text,'String'))];
varargout{3} = str2num(get(handles.er_text,'String'));
varargout{4} = getappdata(handles.axes1,'mask');
varargout{5} = getappdata(handles.axes1,'boundary_points');

close(hObject)


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume


% --- Executes on button press in rerun_button.
function rerun_button_Callback(hObject, eventdata, handles)
% hObject    handle to rerun_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cny = str2num(get(handles.sens_text,'String'));
sigma = floor(round(str2num(get(handles.blur_text,'String'))/2))*2;
di = round(str2num(get(handles.er_text,'String')));

set(handles.sens_slider,'Value',cny);
set(handles.er_slider,'Value',di);
set(handles.blur_slider,'Value',sigma);

setappdata(handles.sens_slider,'cny',cny);
setappdata(handles.er_slider,'di',di);
setappdata(handles.blur_slider,'sigma',sigma);

im_bf = getappdata(handles.axes1, 'im_bf');

[boundary_points,mask] = cell_boundary(im_bf, sigma, cny, di);
setappdata(handles.axes1, 'boundary_points', boundary_points);
setappdata(handles.axes1, 'mask', mask);

imagesc(im_bf,'Parent',handles.axes1);
hold on;axis off;axis equal;colormap gray
for i = 1:length(boundary_points)
    boundary = boundary_points{i};
    xrub = boundary(:,2);
    yrub = boundary(:,1);
    plot(xrub, yrub,'-r');
end


% --- Executes on button press in manual_button.
function manual_button_Callback(hObject, eventdata, handles)
% hObject    handle to manual_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

man_count = getappdata(handles.manual_button, 'man_count');
im_bf = getappdata(handles.axes1, 'im_bf');
sigma = floor(round(str2num(get(handles.blur_text,'String'))/2))*2;

if man_count == 0
    mask = zeros(size(im_bf));
    boundary_points = {};
else
    boundary_points = getappdata(handles.axes1, 'boundary_points');
    mask = getappdata(handles.axes1, 'mask');
end

imagesc(im_bf,'Parent',handles.axes1);
hold on;axis off;axis equal;colormap gray

for i = 1:length(boundary_points)
    boundary = boundary_points{i};
    xrub = boundary(:,2);
    yrub = boundary(:,1);
    plot(xrub, yrub,'-r');
end


[BW, ~, ~] = roipoly;
man_count = man_count+1;
BW = double(BW); 
H = fspecial('gaussian', sigma/2, sigma);
BW_filt = imfilter(BW,H,'replicate');
im_fill = mat2gray(BW_filt);
im_fill = im2bw(im_fill,.1);
im_fill= double(imfill(im_fill,'holes'));
simp = bwareaopen(im_fill,1000);
[boundary_i,mask_i] = bwboundaries(simp,'noholes');
boundary_points{man_count} = boundary_i{1};
mask((mask_i>0)) = man_count; 

setappdata(handles.axes1, 'boundary_points', boundary_points);
setappdata(handles.axes1, 'mask', mask);
setappdata(handles.manual_button, 'man_count',man_count);
imagesc(im_bf,'Parent',handles.axes1);
hold on;axis off;axis equal;colormap gray
for i = 1:length(boundary_points)
    boundary = boundary_points{i};
    xrub = boundary(:,2);
    yrub = boundary(:,1);
    plot(xrub, yrub,'-r');
end



uiwait










function sens_text_Callback(hObject, eventdata, handles)
% hObject    handle to sens_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens_text as text
%        str2double(get(hObject,'String')) returns contents of sens_text as a double


% --- Executes during object creation, after setting all properties.
function sens_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blur_text_Callback(hObject, eventdata, handles)
% hObject    handle to blur_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blur_text as text
%        str2double(get(hObject,'String')) returns contents of blur_text as a double


% --- Executes during object creation, after setting all properties.
function blur_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blur_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function er_text_Callback(hObject, eventdata, handles)
% hObject    handle to er_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of er_text as text
%        str2double(get(hObject,'String')) returns contents of er_text as a double


% --- Executes during object creation, after setting all properties.
function er_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to er_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sens_slider_Callback(hObject, eventdata, handles)
% hObject    handle to sens_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
cny =(get(handles.sens_slider,'Value'));
setappdata(handles.sens_slider,'cny',cny);
set(handles.sens_text,'String',num2str(cny));

im_bf = getappdata(handles.axes1, 'im_bf');
cny = getappdata(handles.sens_slider,'cny');
sigma = getappdata(handles.blur_slider,'sigma');
di = getappdata(handles.er_slider,'di');

[boundary_points,mask] = cell_boundary(im_bf, sigma, cny, di);
setappdata(handles.axes1, 'boundary_points', boundary_points);
setappdata(handles.axes1, 'mask', mask);

imagesc(im_bf,'Parent',handles.axes1);
hold on;axis off;axis equal;colormap gray
for i = 1:length(boundary_points)
    boundary = boundary_points{i};
    xrub = boundary(:,2);
    yrub = boundary(:,1);
    plot(xrub, yrub,'-r');
end




% --- Executes during object creation, after setting all properties.
function sens_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blur_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blur_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sigma =floor(round(get(handles.blur_slider,'Value')/2))*2;
setappdata(handles.blur_slider,'sigma',sigma);
set(handles.blur_text,'String',num2str(sigma));

im_bf = getappdata(handles.axes1, 'im_bf');
cny = getappdata(handles.sens_slider,'cny');
sigma = getappdata(handles.blur_slider,'sigma');
di = getappdata(handles.er_slider,'di');

[boundary_points,mask] = cell_boundary(im_bf, sigma, cny, di);
setappdata(handles.axes1, 'boundary_points', boundary_points);
setappdata(handles.axes1, 'mask', mask);

imagesc(im_bf,'Parent',handles.axes1);
hold on;axis off;axis equal;colormap gray
for i = 1:length(boundary_points)
    boundary = boundary_points{i};
    xrub = boundary(:,2);
    yrub = boundary(:,1);
    plot(xrub, yrub,'-r');
end


% --- Executes during object creation, after setting all properties.
function blur_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blur_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function er_slider_Callback(hObject, eventdata, handles)
% hObject    handle to er_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
di =round(get(handles.er_slider,'Value'));
setappdata(handles.er_slider,'di',di);
set(handles.er_text,'String',num2str(di));

im_bf = getappdata(handles.axes1, 'im_bf');
cny = getappdata(handles.sens_slider,'cny');
sigma = getappdata(handles.blur_slider,'sigma');
di = getappdata(handles.er_slider,'di');

[boundary_points,mask] = cell_boundary(im_bf, sigma, cny, di);
setappdata(handles.axes1, 'boundary_points', boundary_points);
setappdata(handles.axes1, 'mask', mask);

imagesc(im_bf,'Parent',handles.axes1);
hold on;axis off;axis equal;colormap gray
for i = 1:length(boundary_points)
    boundary = boundary_points{i};
    xrub = boundary(:,2);
    yrub = boundary(:,1);
    plot(xrub, yrub,'-r');
end


% --- Executes during object creation, after setting all properties.
function er_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to er_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in clear_button.
function clear_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

im_bf = getappdata(handles.axes1, 'im_bf');

boundary_points = {};
mask = zeros(size(im_bf));
man_count = 0;

imagesc(im_bf,'Parent',handles.axes1);

setappdata(handles.axes1, 'boundary_points', boundary_points);
setappdata(handles.axes1, 'mask', mask);
setappdata(handles.manual_button, 'man_count',man_count);
