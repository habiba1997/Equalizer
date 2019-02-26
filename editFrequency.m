function [ handles ] = editFrequency( handles,dbGain, f1 , f2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
gain = GetGain(dbGain);
handles.newFourier = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,gain,f1,f2);
handles.newSong = fftshift(handles.newFourier);
handles.newSong = ifft(handles.newSong);
handles.newSong = real(handles.newSong);

currentPosition = get(handles.player,'CurrentSample');
x = linspace(-0.5,0.5, length(handles.newFourier))*handles.Fs;
axes(handles.axes2);
plot(x,abs(handles.newFourier));
handles.player = audioplayer(handles.newSong,handles.Fs);
axes(handles.axes5);
plot(handles.time,handles.newSong);
axis([handles.time(1) handles.time(length(handles.time)) -1 1 ]);
    %set(handles.player,'CurrentSample',currentPosition);
if handles.isPlaying
    play(handles.player,currentPosition);
end

end

