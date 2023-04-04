function varargout = DemoFigure_LAI(varargin)
% DEMOFIGURE_LAI MATLAB code for DemoFigure_LAI.fig
%      DEMOFIGURE_LAI, by itself, creates a new DEMOFIGURE_LAI or raises the existing
%      singleton*.
%
%      H = DEMOFIGURE_LAI returns the handle to a new DEMOFIGURE_LAI or the handle to
%      the existing singleton*.
%
%      DEMOFIGURE_LAI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMOFIGURE_LAI.M with the given input arguments.
%
%      DEMOFIGURE_LAI('Property','Value',...) creates a new DEMOFIGURE_LAI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DemoFigure_LAI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DemoFigure_LAI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DemoFigure_LAI

% Last Modified by GUIDE v2.5 21-Jun-2022 00:47:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DemoFigure_LAI_OpeningFcn, ...
                   'gui_OutputFcn',  @DemoFigure_LAI_OutputFcn, ...
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


% --- Executes just before DemoFigure_LAI is made visible.
function DemoFigure_LAI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DemoFigure_LAI (see VARARGIN)

% Choose default command line output for DemoFigure_LAI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DemoFigure_LAI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DemoFigure_LAI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% [file path] =uigetfile({'*.txt'},'选择文本');
path = get(handles.edit2,'String');

if path == 0    
else
    if path(end) ~= '\'
        path = [path '\']
    end
    List =dir([path,'*.txt']); %设置路径
    n=length(List);%计算文件长度
    datatxt = zeros(n,3);
    for i = 1:n
        file_name=List(i).name;
        s=importdata([path,file_name],' ');
        ss=s.textdata;
        %搜索LAI位置
        LAIadd = strfind(ss, 'LAI','ForceCellOutput',1);
        ind = ~cellfun(@isempty, LAIadd);
        LAIadd2=find(ind==1);
        LAI=ss{LAIadd2(2)};
        LAI = str2double(LAI(5:end));
        %搜索DIFN位置，LAI+3
        DIFN=ss{LAIadd2(2)+3};
        DIFN = str2double(DIFN(6:end));
        %搜索MTA位置，LAI+4
        MTA=ss{LAIadd2(2)+4};
        MTA = str2double(MTA(5:end));
        datatxt(i,:) = [LAI DIFN MTA];
    end
    datatxtt = [{List.name}' {List.date}' num2cell(datatxt)];
    
    xlswrite([path 'a0_LAI_DIFN_MTA.xlsx'],datatxtt);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit2 and none of its controls.
function edit2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
