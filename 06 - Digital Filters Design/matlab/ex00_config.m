%% Target
%  1. Use Matlab to analyze frequency responses of the FIR and IIR filters.
%  2. Use Matlab to analyze the outputs of a FIR and a IIR filter.
%  3. Use Simulink to analyze the outputs of a FIR and a IIR filter.
% 
% The parameters are:
%
% * x_0[n] = exp(j 2 \pi F_0 T_s n} + w_0[n]
% * x_1[n] = exp(j 2 \pi F_1 T_s n} + w_1[n]
% * F_0 =  1 [kHz]
% * F_1 =  2 [kHz]
% * F_s = 16 [kHz];
% 
% *Suggestions*
% 
% FIR coefficients
%   fir_ord = 64; Wn = 5e3 / 8e3;
%   [fir_num] = fir1(fir_ord, Wn, hann(fir_ord+1));
% 
% IIR coefficients
%   iir_ord = 12; Rp = 0.01; Wn = 5e3 / 8e3;
%   [iir_num, iir_den] = cheby1(iir_ord,Rp,Wn);
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


%% Parameters
F_0 =  1e3;
F_1 =  2e3;
F_s = 16e3;
T_s = 1/F_s;

%% Exercise
len = 2^14;
n = 0:len-1;

% Signals
w_0 = complex(randn(1,len), randn(1,len));
w_1 = complex(randn(1,len), randn(1,len));
x_0 = exp(1i * 2 * pi * F_0 * T_s * n) + w_0;
x_1 = exp(1i * 2 * pi * F_1 * T_s * n) + w_1;

% FIR Filter
fir_ord = 64; Wn = 5e3 / 8e3;
[fir_num] = fir1(fir_ord, Wn, hann(fir_ord+1));

% IIR Filter
iir_ord = 12; Rp = 0.01; Wn = 5e3 / 8e3;
[iir_num, iir_den] = cheby1(iir_ord,Rp,Wn);

% Filtering
y_0_fir = filter(fir_num,1,x_0);
y_1_fir = filter(fir_num,1,x_1);
y_0_iir = filter(iir_num,iir_den,x_0);
y_1_iir = filter(iir_num,iir_den,x_1);

%% Plot
hfvt0 = fvtool(fir_num, 1, ...
               iir_num, iir_den, 'Fs', F_s);
legend(hfvt0, 'FIR','IIR')


hfvt1 = fvtool(y_0_fir, 1, ...
               y_0_iir, 1, 'Fs', F_s);
legend(hfvt1, 'y_0 - FIR','y_0 - IIR')


hfvt2 = fvtool(y_1_fir, 1, ...
               y_1_iir, 1, 'Fs', F_s);
legend(hfvt2, 'y_1 - FIR','y_1 - IIR')

