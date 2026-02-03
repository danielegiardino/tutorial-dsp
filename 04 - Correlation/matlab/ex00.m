%% TARGET
% Perform the cross-correlation between s[n] and x[n] using Matlab
% * x[n] = sin(2*pi*Fc*n*Ts);
% * w[n] = 0.25*randn(...);
% * s[n] = x[n-100] + w[n];
% 
% The parameters are:
% * Fc =  1 [kHz]
% * Fs = 16 [kHz]
%
% *Suggestions*
%   1) The cross-correlation function is:
%      r_xy        = xcorr(x,y);
%      [r_xy, lag] = xcorr(x,y);
%

%% Clear everything
clc;        % 'clc' clears all the text from the Command Window
clear;      % 'clear' removes all variables from the current workspace
close all;  % 'close all' deletes all figures whose handles are not hidden.

%% Parameters
Fs = 16e3;
Ts = 1/Fs;
Fc = Fs/16;
len = 100;

%% Exercise
n = 0:len-1;
ns = 0:(len+100)-1;

% Signal
x = sin(2*pi*Fc*n*Ts);
s = [zeros(1,100), x];
s = s + 0.25 * randn(1, length(s));

% Cross-correlation
[r1, lag1] = xcorr(x,s);
[r2, lag2] = xcorr(s,x);

%% Figure
figure
subplot(3,1,1)
    hold on
    plot(n+100,x)
    plot(ns,s)
    hold off
    grid on
    legend('x delayed','s')
    xlabel('Samples')
    ylabel('Amplitude')
subplot(3,1,2)
    plot(lag1, r1)
    grid on
    legend('r_1')
    xlabel('lag')
    ylabel('Amplitude')
subplot(3,1,3)
    plot(lag2,r2)
    grid on
    legend('r_2')
    xlabel('Lag')
    ylabel('Amplitude')
