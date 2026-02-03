%% Target
%
% Design an interpolator and use it to filter a signal.
% 
% The parameters are:
%
% * x[n] = cos(2*pi*Fc*n*Ts) + w[n];
% * w[n] is the noise
% * Fc = 125 [kHz]
% * Fs =   1 [MHz]
% * L  =   4  % Interpolator Factor
% 
% *Suggestions*
% 
% FIR coefficients
%   fir_ord = 64;
%   [fir_num] = fir1(fir_ord, Wn, hann(fir_ord+1));
% 
% Filtering
%   y = filter(num,den,x);
%     * x   - input signal
%     * y   - output signal
%     * num - numerator   coefficients
%     * den - denominator coefficients
%

%% Clear
clc;            % Clear the text from the Command Window
clear;          % Remove all variables from the current workspace
close all;      % Close all figures

%% Matlab Exercise
Fc = 125e3;
Fs = 1e6;
Ts = 1/Fs;
L = 4;

% Filter
fir_ord = 64;
F_cut = 500e3;
Wn = F_cut / (Fs*L/2);
fir_num = fir1(fir_ord, Wn, hann(fir_ord+1));

% Method 1
E0 = fir_num(1:L:end);
E1 = fir_num(2:L:end);
E2 = fir_num(3:L:end);
E3 = fir_num(4:L:end);

% Method 2
E0 = downsample(fir_num, L, 0);
E1 = downsample(fir_num, L, 1);
E2 = downsample(fir_num, L, 2);
E3 = downsample(fir_num, L, 3);

% Method 3
E = buffer(fir_num, L);
E0 = E(1,:);
E1 = E(2,:);
E2 = E(3,:);
E3 = E(4,:);










