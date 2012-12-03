function [] = chasqui_variable(fs,t,BPM,BPM_var,texto,opt)
% -------------------------------------------------------------------------
% [train] = beat_train_template(60*fs/BPM,1,fs*t,10);
% -------------------------------------------------------------------------
% Example: chasqui(44100,10,180,'180BPM',opt);
% -------------------------------------------------------------------------
% [B,A]   = butter(1,0.01,'low');
% audio = filtfilt(B,A,train);
% wavwrite(abs(audio*(1/0.02)),fs,texto);
% plot(abs(audio*(1/0.02)))
% -------------------------------------------------------------------------

% load click sound
if opt
    [click,fs_click] = wavread('../../../../matlab/audio/beatroot/audio/53-cymbell.wav');
else
    [click,fs_click] = wavread('..\audio\31-sticks.wav');
end
if fs_click ~= fs
    fprintf('===========================================\nOJOOOO!!! FRECUENCIAS DE MUESTREO DISTINTAS\n===========================================\n')
end

P = 60*fs/BPM;
n_win = fs*t;
phi = 1;

BPMvar = 60*fs/BPM_var;

lin = phi:P:n_win;
var = BPMvar*(0:length(lin)-1)/length(lin);

train = zeros(n_win,1);
train(lin+var,1)=1;

tracked_beats = conv(train,click);
tracked_beats = tracked_beats/max(abs(tracked_beats));
wavwrite(tracked_beats,fs,texto);
