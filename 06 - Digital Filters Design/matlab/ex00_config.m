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
len = 2^12;
n = 0:len-1;

% Signals
w_0 = 1e-2 * complex(randn(1,len), randn(1,len));
w_1 = 1e-2 * complex(randn(1,len), randn(1,len));
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
% Using 'freqz'
nFFT = 2^12; % Number of points of the fft
Hf_fir = freqz(fir_num, 1, nFFT);
Hf_iir = freqz(iir_num, iir_num, nFFT);
Yf0_fir = freqz(y_0_fir, 1, nFFT);
Yf1_fir = freqz(y_1_fir, 1, nFFT);
Yf0_iir = freqz(y_0_iir, 1, nFFT);
[Yf1_iir, w] = freqz(y_1_iir, 1, nFFT);

% Frequency normalization
w = w/pi;

% Mag to dB
Hf_fir  = mag2db(abs(Hf_fir));
Hf_iir  = mag2db(abs(Hf_iir));
Yf0_fir = mag2db(abs(Yf0_fir)/nFFT);
Yf0_iir = mag2db(abs(Yf0_iir)/nFFT);
Yf1_fir = mag2db(abs(Yf1_fir)/nFFT);
Yf1_iir = mag2db(abs(Yf1_iir)/nFFT);

figure;
subplot(3,1,1)
  hold on
  plot(w, Hf_fir)
  plot(w, Hf_iir)
  hold off
  grid on
  legend('H_{FIR}','H_{IIR}')
  xlabel('Normalized Frequency \times \pi')
  ylabel('Amplitude [dB]')
subplot(3,1,2)
  hold on
  plot(w, Yf0_fir)
  plot(w, Yf0_iir)
  hold off
  grid on
  legend('Yf_0 - FIR','Yf_0 - IIR')
  xlabel('Normalized Frequency \times \pi')
  ylabel('Amplitude [dB]')
subplot(3,1,3)
  hold on
  plot(w, Yf1_fir)
  plot(w, Yf1_iir)
  hold off
  grid on
  legend('Yf_1 - FIR','Yf_1 - IIR')
  xlabel('Normalized Frequency \times \pi')
  ylabel('Amplitude [dB]')

% Using 'fvtool'
hfvt0 = fvtool(fir_num, 1, iir_num, iir_den, ...
               'Fs', F_s, 'NumberOfPoints', nFFT);
legend(hfvt0, 'FIR','IIR')


hfvt1 = fvtool(y_0_fir, 1, y_0_iir, 1, ...
               'Fs', F_s, 'NumberOfPoints', nFFT);
legend(hfvt1, 'y_0 - FIR','y_0 - IIR')


hfvt2 = fvtool(y_1_fir, 1, y_1_iir, 1, ...
               'Fs', F_s, 'NumberOfPoints', nFFT);
legend(hfvt2, 'y_1 - FIR','y_1 - IIR')

