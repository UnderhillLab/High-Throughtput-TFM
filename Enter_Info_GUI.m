function varargout = Enter_Info_GUI(varargin)

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


% ENTER_INFO_GUI MATLAB code for Enter_Info_GUI.fig
%      ENTER_INFO_GUI, by itself, creates a new ENTER_INFO_GUI or raises the existing
%      singleton*.
%
%      H = ENTER_INFO_GUI returns the handle to a new ENTER_INFO_GUI or the handle to
%      the existing singleton*.
%
%      ENTER_INFO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTER_INFO_GUI.M with the given input arguments.
%
%      ENTER_INFO_GUI('Property','Value',...) creates a new ENTER_INFO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Enter_Info_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Enter_Info_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Enter_Info_GUI

% Last Modified by GUIDE v2.5 05-Aug-2019 15:26:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Enter_Info_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Enter_Info_GUI_OutputFcn, ...
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


% --- Executes just before Enter_Info_GUI is made visible.
function Enter_Info_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Enter_Info_GUI (see VARARGIN)

% Choose default command line output for Enter_Info_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Enter_Info_GUI wait for user response (see UIRESUME)

set(handles.islands_con_num_text,'Visible','off');
set(handles.arrayed_con_num_text,'Visible','off');
set(handles.arrayed_con,'Visible','off');
set(handles.islands_incon,'Visible','off');
set(handles.setcon_button,'Visible','off');
set(handles.done_button,'Visible','off');

experiment = varargin{1};
date_ID = varargin{2};
soluble = varargin{3};
dish_num = varargin{4};
time = varargin{5};
young = varargin{6};
pois = varargin{7};
num_array = varargin{8};
pixelsize = varargin{9};
filename = varargin{10};
XYposition = varargin{11};
str = varargin{12};

setappdata(handles.axes1,'XYposition',XYposition);
setappdata(handles.axes1,'str',str);

set(handles.experiment_desc,'String',experiment);
set(handles.date_ID_box,'String',date_ID);
set(handles.soluble_box,'String',soluble);
set(handles.dish_ID_box,'String',dish_num);
set(handles.time_pt,'String',time);
set(handles.youngs,'String',young);
set(handles.pois_box,'String',pois);
set(handles.num_array_box,'String',num_array);
set(handles.pixelsize_box,'String',pixelsize);
set(handles.filename_text,'String',filename);

hold on
plot(XYposition(:,1), XYposition(:,2),'bo')
text(XYposition(:,1), XYposition(:,2), str)
axis equal;
xlim([0.98*min(XYposition(:,1)) 1.02*max(XYposition(:,1))]); 
ylim([0.98*min(XYposition(:,2)) 1.02*max(XYposition(:,2))]); 

uiwait;


% --- Outputs from this function are returned to the command line.
function varargout = Enter_Info_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


varargout{1} = get(handles.experiment_desc,'String');
varargout{2} = get(handles.date_ID_box,'String');
varargout{3} = get(handles.soluble_box,'String');
varargout{4} = get(handles.dish_ID_box,'String');
varargout{5} = get(handles.time_pt,'String');
varargout{6} = get(handles.youngs,'String');
varargout{7} = get(handles.pois_box,'String');
varargout{8} = get(handles.num_array_box,'String');
varargout{9} = get(handles.pixelsize_box,'String');
varargout{10} = get(handles.save_name_box,'String');
varargout{11} = getappdata(handles.arrayed_con, 'arrayed_conditions');
varargout{12} = getappdata(handles.arrayed_con, 'arrayed_condition_islands');


close(hObject)




function experiment_desc_Callback(hObject, eventdata, handles)
% hObject    handle to experiment_desc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of experiment_desc as text
%        str2double(get(hObject,'String')) returns contents of experiment_desc as a double


% --- Executes during object creation, after setting all properties.
function experiment_desc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to experiment_desc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function date_ID_box_Callback(hObject, eventdata, handles)
% hObject    handle to date_ID_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of date_ID_box as text
%        str2double(get(hObject,'String')) returns contents of date_ID_box as a double


% --- Executes during object creation, after setting all properties.
function date_ID_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to date_ID_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function soluble_box_Callback(hObject, eventdata, handles)
% hObject    handle to soluble_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of soluble_box as text
%        str2double(get(hObject,'String')) returns contents of soluble_box as a double


% --- Executes during object creation, after setting all properties.
function soluble_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to soluble_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dish_ID_box_Callback(hObject, eventdata, handles)
% hObject    handle to dish_ID_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dish_ID_box as text
%        str2double(get(hObject,'String')) returns contents of dish_ID_box as a double


% --- Executes during object creation, after setting all properties.
function dish_ID_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dish_ID_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_pt_Callback(hObject, eventdata, handles)
% hObject    handle to time_pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_pt as text
%        str2double(get(hObject,'String')) returns contents of time_pt as a double


% --- Executes during object creation, after setting all properties.
function time_pt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function youngs_Callback(hObject, eventdata, handles)
% hObject    handle to youngs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of youngs as text
%        str2double(get(hObject,'String')) returns contents of youngs as a double


% --- Executes during object creation, after setting all properties.
function youngs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to youngs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pois_box_Callback(hObject, eventdata, handles)
% hObject    handle to pois_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pois_box as text
%        str2double(get(hObject,'String')) returns contents of pois_box as a double


% --- Executes during object creation, after setting all properties.
function pois_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pois_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_array_box_Callback(hObject, eventdata, handles)
% hObject    handle to num_array_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_array_box as text
%        str2double(get(hObject,'String')) returns contents of num_array_box as a double


% --- Executes during object creation, after setting all properties.
function num_array_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_array_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in set_info_button.
function set_info_button_Callback(hObject, eventdata, handles)
% hObject    handle to set_info_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

num_array = get(handles.num_array_box,'String');
experiment = get(handles.experiment_desc,'String');
date_ID = get(handles.date_ID_box,'String');
soluble = get(handles.soluble_box,'String');
dish_num = get(handles.dish_ID_box,'String');
time = get(handles.time_pt,'String');
young = get(handles.youngs,'String');

young_kpa = str2num(young)/1000;
save_file_name = [date_ID, '_', experiment, '_', num2str(young_kpa),'kPa_',time '_', soluble, '_', dish_num];
set(handles.save_name_box,'String',save_file_name);

set(handles.islands_con_num_text,'Visible','on');
set(handles.arrayed_con_num_text,'Visible','on');

set(handles.islands_con_num_text,'String','Islands with Condition 1:');
set(handles.arrayed_con_num_text,'String','Condition 1:');

set(handles.arrayed_con,'Visible','on');
set(handles.islands_incon,'Visible','on');
set(handles.setcon_button,'Visible','on');
set(handles.arrayed_con,'String','');
set(handles.islands_incon,'String','');

current_cond_ind = 1;
setappdata(handles.arrayed_con, 'current_cond_ind', current_cond_ind);
setappdata(handles.arrayed_con, 'arrayed_condition_islands',{});
setappdata(handles.arrayed_con, 'arrayed_conditions',{});

XYposition = getappdata(handles.axes1,'XYposition');
str = getappdata(handles.axes1,'str');
hold off
plot(XYposition(:,1), XYposition(:,2),'bo')
hold on
text(XYposition(:,1), XYposition(:,2), str)
axis equal;
xlim([0.98*min(XYposition(:,1)) 1.02*max(XYposition(:,1))]); 
ylim([0.98*min(XYposition(:,2)) 1.02*max(XYposition(:,2))]); 





function arrayed_con_Callback(hObject, eventdata, handles)
% hObject    handle to arrayed_con (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arrayed_con as text
%        str2double(get(hObject,'String')) returns contents of arrayed_con as a double


% --- Executes during object creation, after setting all properties.
function arrayed_con_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arrayed_con (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function islands_incon_Callback(hObject, eventdata, handles)
% hObject    handle to islands_incon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of islands_incon as text
%        str2double(get(hObject,'String')) returns contents of islands_incon as a double


% --- Executes during object creation, after setting all properties.
function islands_incon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to islands_incon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setcon_button.
function setcon_button_Callback(hObject, eventdata, handles)
% hObject    handle to setcon_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_cond_ind = getappdata(handles.arrayed_con, 'current_cond_ind');
XYposition = getappdata(handles.axes1,'XYposition');

arrayed_conditions = getappdata(handles.arrayed_con, 'arrayed_conditions');
arrayed_condition_islands = getappdata(handles.arrayed_con, 'arrayed_condition_islands');

arrayed_conditions{current_cond_ind} = get(handles.arrayed_con,'String');
arrayed_condition_islands{current_cond_ind} = str2num(get(handles.islands_incon,'String'));

setappdata(handles.arrayed_con, 'arrayed_condition_islands',arrayed_condition_islands);
setappdata(handles.arrayed_con, 'arrayed_conditions',arrayed_conditions);

num_array = str2num(get(handles.num_array_box,'String'));
if current_cond_ind < num_array
    
    current_cond_ind = current_cond_ind + 1;
    set(handles.islands_con_num_text,'String',['Islands with Condition ' num2str(current_cond_ind) ':']);
    set(handles.arrayed_con_num_text,'String',['Condition ' num2str(current_cond_ind) ':']);
    set(handles.arrayed_con,'String','');
    set(handles.islands_incon,'String','');
    setappdata(handles.arrayed_con, 'current_cond_ind',current_cond_ind);

else    
    set(handles.done_button,'Visible','on');
    
end

for i = 1:length(arrayed_conditions)
   for j = 1:length(arrayed_condition_islands{i})
       plot(XYposition(arrayed_condition_islands{i}(j),1), XYposition(arrayed_condition_islands{i}(j),2),'go','MarkerFaceColor','g')
   end
end


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume




function save_name_box_Callback(hObject, eventdata, handles)
% hObject    handle to save_name_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_name_box as text
%        str2double(get(hObject,'String')) returns contents of save_name_box as a double


% --- Executes during object creation, after setting all properties.
function save_name_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_name_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pixelsize_box_Callback(hObject, eventdata, handles)
% hObject    handle to pixelsize_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pixelsize_box as text
%        str2double(get(hObject,'String')) returns contents of pixelsize_box as a double


% --- Executes during object creation, after setting all properties.
function pixelsize_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pixelsize_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
