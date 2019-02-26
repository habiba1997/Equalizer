function [ handles ] = presetAudio( handles,g)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
set(handles.S1,'value',g(1));
set(handles.S2,'value',g(2));
set(handles.S3,'value',g(3));
set(handles.S4,'value',g(4));
set(handles.S5,'value',g(5));
set(handles.S6,'value',g(6));
set(handles.S7,'value',g(7));
set(handles.S8,'value',g(8));
set(handles.S9,'value',g(9));
set(handles.s10,'value',g(10));

handles.newFourier = handles.originalFourier;

handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(1)),31,62);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(2)),62,125);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(3)),125,250);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(4)),250,500);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(5)),500,1000);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(6)),1000,2000);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(7)),2000,4000);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(8)),4000,8000);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(9)),8000,10000);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,GetGain(g(10)),10000,20000);

handles.newSong = fftshift(handles.newFourier);
handles.newSong = ifft(handles.newSong);
handles.newSong = real(handles.newSong);

if handles.player == 0
    handles.currentPosition = 1;
else
    handles.currentPosition = get(handles.player,'CurrentSample');
end
x = linspace(-0.5,0.5, length(handles.newFourier))*handles.Fs;
axes(handles.axes2);
plot(x,abs(handles.newFourier));
handles.player = audioplayer(handles.newSong,handles.Fs);
axes(handles.axes5);
plot(handles.time,handles.newSong);
axis([handles.time(1) handles.time(length(handles.time)) -1 1 ]);
    %set(handles.player,'CurrentSample',currentPosition);
if handles.isPlaying
    play(handles.player,handles.currentPosition);
end



end

