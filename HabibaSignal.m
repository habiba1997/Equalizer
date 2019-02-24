function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 23-Feb-2019 19:59:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%check if a file is selected
if get(handles.pause, 'value') == 0
    [filename pathname] = uigetfile({'*.wav'},'Select a Signal');
   
    if isequal(filename,0)
       disp('User selected Cancel');
    else
      %choose a file and file data  
        disp(['User selected ', fullfile(pathname,filename)]);
        handles.fullpathname = strcat(pathname, filename);
        set(handles.address, 'String',handles.fullpathname) %showing fullpathname
        handles.info = audioinfo(handles.fullpathname);        % read audio file and save sampling freq in Fs and signal in ySignal
        [handles.ySignal,handles.Fs] = audioread(handles.fullpathname);
        
        handles.signalStart = 1; %reset my loop iterator    
        handles.pausedButtonClicked = 0; %to reset pause button
       
        handles.time = 0:1/handles.Fs:handles.info.Duration;        %handles.time start from 1 to duration (property of file) step is 1/Fs
        handles.time = handles.time(1:end-1);        %to make 2 vectors match in length to pause them
        axes(handles.signal);        %choose axes to pause on
        plot(handles.time,handles.ySignal);
        axis([handles.time(1) handles.time(100) -1 1]);%plot first axis
        axes(handles.wholeSignal);
        plot(handles.time,handles.ySignal);%plot whole signal
        handles.player = audioplayer(handles.ySignal, handles.Fs);
    end
end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function signal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate signal


% --- Executes on mouse press over axes background.
function samples_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.pause, 'value') == 1
    handles.signalStep = 6900 ;handles.viewtimeAxisEnd =  8000 ;
    handles.signalEnd = length(handles.time) - handles.viewtimeAxisEnd;
    
    if handles.pausedButtonClicked == 1
        resume(handles.player);
        handles.pausedButtonClicked = 0;
    else
        play(handles.player);

    end
    
    axes(handles.signal);
    plot(handles.time,handles.ySignal);
    for loop =handles.signalStart:handles.signalStep:handles.signalEnd
        axis([handles.time(loop) handles.time(loop+handles.viewtimeAxisEnd) -1 1]);drawnow
        handles.signalStart = handles.signalStart+handles.signalStep;
        if get(handles.pause, 'value') ~= 1
               handles.pausedButtonClicked = 1;
               pause(handles.player);
               break;
        end
    end 
    set(handles.pause,'value',0);
    disp(loop);
end 
guidata(hObject, handles)

% Hint: get(hObject,'Value') returns toggle state of pause


% --- Executes on button press in restart.
function restart_Callback(hObject, eventdata, handles)

 if get(handles.pause, 'value') ~= 1
        handles.signalStart = 1; %reset my loop iterator    
        handles.pausedButtonClicked = 0; %to reset pause button
        pause_Callback(handles.pause, eventdata, handles);
 end
 guidata(hObject, handles)

       
       
% hObject    handle to restart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
