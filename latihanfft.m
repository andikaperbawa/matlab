clear all
close all
clc

a=10
F=10
T=2
dt=0.01
t=0:dt:T
nt=length(t)
w=a*sin(2*pi*F*t)
figure
plot (t,w)
tt=t'
ww=w'

n=200;                  %frequency total discritation
Y = fft(w,n);           %FFT of w to n number
Fs=1/dt;                %Freq sampling
f = Fs*(0:(n/2))/n;     %Frequency array of one side
P = abs(Y/n);           %Frequency Amplitude
figure
plot(f,P(1:n/2+1))
