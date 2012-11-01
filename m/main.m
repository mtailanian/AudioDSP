% startup
close all
clear all
home
audio_colors

%% Params

[x,fs] = wavread('train13.wav');
L      = length(x);

n_win  = 1024;
n_hop  = n_win/2;
n_bins = 2048;

win    = n_win/fs;
hop    = n_hop/fs;
n      = win/2:hop:L/fs;           % frame times [s]
N      = length(n);                % frames quantity

%% Feature detection: Spectral Flux

SFx = SF(x,n_win,n_hop,n_bins,'hamming');

% Filtrado
[B,A]   = butter(10,.4,'low');
SF_filt = filtfilt(B,A,SFx);

figure;
    plot(n,SF_filt)
    title('\fontsize{16}Spectral Flux filtrada forward y backward')

%% Pre-Tracking

[P,Phi,S] =  pre_tracking(SF_filt,n_win,n_hop,fs);

