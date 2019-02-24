
 info = audioinfo('/home/habiba/Documents/EqualizerPlebs/_La La La (Brazil 2014) (feat. Carli.wav');
 [y,Fs] = audioread('/home/habiba/Documents/EqualizerPlebs/_La La La (Brazil 2014) (feat. Carli.wav');
 t = 0:1/Fs:info.Duration;
 t = t(1:end-1);
 plot(t,y)
 axis([0 ceil(info.Duration) -1 1]);

info = audioinfo('/home/habiba/Documents/01 Titanium (feat. Sia).wav');
 [y,Fs] = audioread('/home/habiba/Documents/01 Titanium (feat. Sia).wav');
 t = 0:1/Fs:info.Duration;
 t = t(1:end-1);
 plot(t,y)
 axis([0 ceil(info.Duration) -1 1]);
axis([0 0.05 -1 1]);

info = audioinfo('/home/habiba/Downloads/1-04 Neon Lights.wav');
 [y,Fs] = audioread('/home/habiba/Downloads/1-04 Neon Lights.wav');
 t = 0:1/Fs:info.Duration;
 t = t(1:end-1);
 plot(t,y)
axis([1 1.05 -1 1]);

handles.info = audioinfo('/home/habiba/Documents/01 A Little Party Never Killed Nobod.wav');
[handles.ySignal,handles.Fs] = audioread('/home/habiba/Documents/01 A Little Party Never Killed Nobod.wav');

time = 0:1/handles.Fs:handles.info.Duration;
time = time(1:end-1);
handles.signalStart = 1;
handles.signalStep = 6600 ;handles.viewtimeAxisEnd =  7200 ;
handles.signalEnd = length(time) - handles.viewtimeAxisEnd ;
player = audioplayer(handles.ySignal, handles.Fs);
play(player);	plot(time,handles.ySignal);
for loop =handles.signalStart:handles.signalStep:handles.signalEnd
	axis([time(loop) time(loop+handles.viewtimeAxisEnd) -1 1]);drawnow
end 







info = audioinfo('/home/habiba/Downloads/1-04 Neon Lights.wav');
[y,Fs] = audioread('/home/habiba/Downloads/1-04 Neon Lights.wav');
handles.nmax = length(y);
handles.f =1;
handles.step =1/Fs;
sig = y(:,1);
 x = 1:length(y);
 Dx=0.05; y1=min(y(1,:)); y2=max(y(1,:));
 %handles.var = var.val
    for n=handles.f:handles.step:handles.nmax
        plot(x,sig); axis([x(n) x(n+Dx) y1 y2]);drawnow
        handles.f = handles.f+handles.step;
        %%checks the toggle button if it's paused during the plotting%%
    end

/home/habiba/Documents/EqualizerPlebs/_La La La (Brazil 2014) (feat. Carli.wav
/home/habiba/Documents/100Hz_44100Hz_16bit_30sec.wav
/home/habiba/Downloads/1-04 Neon Lights.wav
