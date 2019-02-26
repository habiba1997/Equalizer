function [ handles ] = editFrequency( handles,dbGain, f1 , f2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
gain = GetGain(dbGain);
[handles.newSong,handles.newFourier] = manipulateAudio(handles.newFourier,handles.originalFourier,handles.Fs,gain,f1,f2);
currentPosition = get(handles.player,'CurrentSample');
handles.player = audioplayer(handles.newSong,handles.Fs);
    %set(handles.player,'CurrentSample',currentPosition);
if handles.isPlaying
    play(handles.player,currentPosition);
end

end

