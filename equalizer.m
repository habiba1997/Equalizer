function varargout = equalizer(varargin)
% EQUALIZER MATLAB code for equalizer.fig
%      EQUALIZER, by itself, creates a new EQUALIZER or raises the existing
%      singleton*.
%
%      H = EQUALIZER returns the handle to a new EQUALIZER or the handle to
%      the existing singleton*.
%
%      EQUALIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUALIZER.M with the given input arguments.
%
%      EQUALIZER('Property','Value',...) creates a new EQUALIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equalizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equalizer

% Last Modified by GUIDE v2.5 26-Feb-2019 15:11:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @equalizer_OutputFcn, ...
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


% --- Executes just before equalizer is made visible.
function equalizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equalizer (see VARARGIN)

% Choose default command line output for equalizer
handles.output = hObject;

% Update handles structure
handles.isPlaying = 0;
handles.song = 0;
handles.Fs = 44100;
handles.currentPosition = 0;
handles.originalFourier = 0;
handles.newFourier = 0;
handles.newSong =0;
handles.player = 0;
guidata(hObject, handles);


% UIWAIT makes equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = equalizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BrowseButton.
function BrowseButton_Callback(hObject, eventdata, handles)
% hObject    handle to BrowseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.mp3'},'File Selector');
if filename==0
    return
end
if handles.isPlaying
    pause(handles.player)
end

handles.fullpathname = strcat(pathname, filename);
[song, Fs] = audioread(handles.fullpathname);
set(handles.StartPauseButton,'String','Start');

set(handles.FileAddress, 'String' , handles.fullpathname);
handles.Fs=Fs;
handles.song = song;
handles.originalFourier = fftshift(fft(handles.song));
handles.newFourier = handles.originalFourier;
handles.newSong = song;
handles.player = 0;
handles.isPlaying = 0;
handles.time=0:(1/Fs):(length(song)/Fs);
handles.time = handles.time(1:end-1);
axes(handles.axes4);
plot(handles.time,song);
x = linspace(-0.5,0.5, length(handles.newFourier))*handles.Fs;
axes(handles.axes1);
plot(x,abs(handles.originalFourier));
g1 = get(handles.S1,'value');
g2 = get(handles.S2,'value');
g3 = get(handles.S3,'value');
g4 = get(handles.S4,'value');
g5 = get(handles.S5,'value');
g6 = get(handles.S6,'value');
g7 = get(handles.S7,'value');
g8 = get(handles.S8,'value');
g9 = get(handles.S9,'value');
g10 = get(handles.s10,'value');

handles = presetAudio(handles, [g1 g2 g3 g4 g5 g6 g7 g8 g9 g10]);


guidata(hObject,handles);



function FileAddress_Callback(hObject, eventdata, handles)
% hObject    handle to FileAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileAddress as text
%        str2double(get(hObject,'String')) returns contents of FileAddress as a double


% --- Executes during object creation, after setting all properties.
function FileAddress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartPauseButton.
function StartPauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartPauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.player == 0)
handles.player = audioplayer(handles.song,handles.Fs);
handles.isPlaying = 1;
play(handles.player)
guidata(hObject,handles);
return;
end
if (handles.isPlaying == 1)
    set(handles.StartPauseButton,'String','Resume');
    handles.currentPosition = get(handles.player,'CurrentSample');
    pause(handles.player);
    handles.isPlaying =0;
    guidata(hObject,handles);
    return;
end
if (handles.isPlaying == 0)
    set(handles.StartPauseButton,'String','Pause');
    play(handles.player, handles.currentPosition);
    handles.isPlaying =1;
    guidata(hObject,handles);
    guidata(hObject,handles);
    return;
end


% --- Executes on slider movement.
function S9_Callback(hObject, eventdata, handles)
% hObject    handle to S9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S9,'value');
handles= editFrequency(handles,dbGain,8000,10000);
guidata(hObject,handles);
    




% --- Executes during object creation, after setting all properties.
function S9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S8_Callback(hObject, eventdata, handles)
% hObject    handle to S8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S8,'value');
handles= editFrequency(handles,dbGain,4000,8000);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S7_Callback(hObject, eventdata, handles)
% hObject    handle to S7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S7,'value');
handles= editFrequency(handles,dbGain,2000,4000);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S6_Callback(hObject, eventdata, handles)
% hObject    handle to S6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S6,'value');
handles= editFrequency(handles,dbGain,1000,2000);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S5_Callback(hObject, eventdata, handles)
% hObject    handle to S5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S5,'value');
handles= editFrequency(handles,dbGain,500,1000);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S4_Callback(hObject, eventdata, handles)
% hObject    handle to S4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S4,'value');
handles= editFrequency(handles,dbGain,250,500);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S3_Callback(hObject, eventdata, handles)
% hObject    handle to S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S3,'value');
handles= editFrequency(handles,dbGain,125,250);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S2_Callback(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S2,'value');
handles= editFrequency(handles,dbGain,62,125);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S1_Callback(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.S1,'value');
handles= editFrequency(handles,dbGain,31,62);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function S1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in BassButton.
function BassButton_Callback(hObject, eventdata, handles)
% hObject    handle to BassButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

g = [ 0 0 -0.3 -2.7 0 2.1 4.5 3 0.6 0 ]
handles = presetAudio(handles,g);
guidata(hObject,handles);

% --- Executes on button press in ClassicalButton.
function ClassicalButton_Callback(hObject, eventdata, handles)
% hObject    handle to ClassicalButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
g = [0 0 0 0 0 0 -0.3 -5.7 -6 -8.1 ]
handles = presetAudio(handles,g);
guidata(hObject,handles);


% --- Executes on button press in DanceButton.
function DanceButton_Callback(hObject, eventdata, handles)
% hObject    handle to DanceButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

g = [5.4 0 0 0 0 0 0 0 0 5.4 ]
handles = presetAudio(handles,g);
guidata(hObject,handles);


% --- Executes on button press in RockButton.
function RockButton_Callback(hObject, eventdata, handles)
% hObject    handle to RockButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

g=[4.5 -3.6 -6.6 -2.7 2.1 6 7.5 7.8 7.8 8.1];
handles = presetAudio(handles,g);
guidata(hObject,handles);



% --- Executes on button press in TechnoButton.
function TechnoButton_Callback(hObject, eventdata, handles)
% hObject    handle to TechnoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

g=[4.8 4.2 1.5 -2.4 -3.3 -1.5 1.5 5.1 5.7 5.4 ];
handles = presetAudio(handles,g);
guidata(hObject,handles);




% --- Executes on button press in TrebleButton.
function TrebleButton_Callback(hObject, eventdata, handles)
% hObject    handle to TrebleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


g = [ -1.5 3.9 5.4 4.5 0.9 -1.5 -1.8 -2.1 -2.1 -0.3 ]
handles = presetAudio(handles,g);
guidata(hObject,handles);


% --- Executes on slider movement.
function s10_Callback(hObject, eventdata, handles)
% hObject    handle to s10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dbGain = get(handles.s10,'value');
handles= editFrequency(handles,dbGain,10000,20000);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function s10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g = zeros(1,10);
handles = presetAudio(handles,g);
guidata(hObject,handles);

