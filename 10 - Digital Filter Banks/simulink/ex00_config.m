%% Target
%
% Design an analysis filter bank.
%
% The signal is:
%   x[n] = A0*exp(1i*2*pi*Fc0*n*Ts) + A1*exp(1i*2*pi*Fc1*n*Ts) + w[n];
%   
% The parameters are:
%
% * Fs = 1 [MHz]
% * w[n] is a gaussian noise
% * Fc0 = +1/8*Fs
% * Fc1 = -3/8*Fs
% * A0 = 1
% * A1 = 1/4
% * Parallel Factor M=2
%
% 
% Filter
% 
% * fir_ord = 64;
% * Wn = 1/M;
% * h = fir1(fir_ord, Wn, hann(fir_ord+1));
% * hb = buffer(h,2);
%

%% Clear
clc;            % Clear the text from the Command Window
clear;          % Remove all variables from the current workspace
close all;      % Close all figures

%% Exercise

% Parameters
Fs = 1e6;
Ts = 1/Fs;
Fc0 = +1/8*Fs;
Fc1 = -3/8*Fs;
A0 = 1;
A1 = 1/4;
M = 2;

% Filter
fir_ord = 64;
Wn = 1/M;
h = fir1(fir_ord, Wn, hann(fir_ord+1));
hb = buffer(h,2);

