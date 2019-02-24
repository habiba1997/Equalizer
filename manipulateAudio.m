function [ newSongMatrix ] = manipulateAudio( audioMatrix, samplingFrequency, gain, f1, f2 )
%MANIPULATEAUDIO Summary of this function goes here
%   Detailed explanation goes here
fourierAudio = fft(audioMatrix);
fourierAudio = fftshift(fourierAudio);

vectorLength = length(audioMatrix);
vectorCentre = vectorLength/2;
vectorCentre = ceil(vectorCentre);

beginIndex = (f1/(samplingFrequency/2))*(vectorLength/2);
endIndex = (f2/(samplingFrequency/2))*(vectorLength/2);

beginIndex = round(beginIndex);
endIndex = round(endIndex);


fourierAudio(vectorCentre+beginIndex+1:vectorCentre+endIndex,:) =fourierAudio(vectorCentre+beginIndex+1:vectorCentre+endIndex,:)*gain;
fourierAudio(vectorCentre-endIndex+1:vectorCentre-beginIndex,:) =fourierAudio(vectorCentre-endIndex+1:vectorCentre-beginIndex,:)*gain;

newSongMatrix = fftshift(fourierAudio);
newSongMatrix = ifft(newSongMatrix);
newSongMatrix = real(newSongMatrix);


end

