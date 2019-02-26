function [ fourierAudio ] = manipulateAudio( fourierAudio, originalFourier, samplingFrequency, gain, f1, f2 )
%MANIPULATEAUDIO Summary of this function goes here
%   Detailed explanation goes here
vectorLength = length(fourierAudio);
vectorCentre = vectorLength/2;
vectorCentre = ceil(vectorCentre);

beginIndex = (f1/(samplingFrequency/2))*(vectorLength/2);
endIndex = (f2/(samplingFrequency/2))*(vectorLength/2);

beginIndex = round(beginIndex);
endIndex = round(endIndex);

fourierAudio(vectorCentre+beginIndex+1:vectorCentre+endIndex,:) =originalFourier(vectorCentre+beginIndex+1:vectorCentre+endIndex,:)*gain;
fourierAudio(vectorCentre-endIndex+1:vectorCentre-beginIndex,:) =originalFourier(vectorCentre-endIndex+1:vectorCentre-beginIndex,:)*gain;

end

