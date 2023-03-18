clear;
clc;

%% Load one frequency sound of the instrument
file = 'piano_A4.wav';
[y, Fs] = audioread(file);          % y is sound data, Fs is sample frequency.
t = (0:length(y)-1)/Fs;             % time

%% The envelope with the frequency sound of the instrument
figure;
subplot(3,2,1);
plot(t,y);
axis tight;       
envelope(y,200,'rms');
j = resample(envelope(y,200,'rms'), 1 ,2);
title(['Waveform of ' file]);

N = 2^13;                           % number of points to analyze

%% Pick the harmonic of the sound to get the timebre
p1=pspectrum(y,Fs);
f1=Fs/N:Fs/N:11025;
p1=p1(1:N/2);
[M,I] = max(p1);
A = islocalmax(p1,'MinProminence',M/300000,'MinSeparation', 120);
subplot(3,2,2);
semilogy(f1,p1,'-', f1(A), p1(A),'r*');
axis([0 6000 10^-9 10^0]);
title(['Power Spectrum of ' file]);

%% Generate the sound using sine function for simulating the timbre and synthesis the different length of beat
f = 440:440:length(f1(A))*440;      % frequencies
c = p1(A).^0.5;                     % amplitudes
S = length(j);
N1 = 1.0 * S;                       % 1.0 sec
ta = 60;
tb = 100;
tc = 1000;
td = 10000;
tt = ta/tb;
t41 = (0:N1-1)/S*tt;                % time samples: t41 = N1/S (time for one beat)
x41 = 0;
for k=1:length(f1(A))
x41 = x41 + 12 * c(k) * sin(2 * pi * f(k) * t41);
end
subplot(3,2,3);
plot(t41, x41, '-');
xlabel 't41', ylabel 'x41(t)'
z41 = x41.*j';                      % using envelope to simulating the timbre 
w41 = resample(z41,ta,tb);
tm41 = resample(t41,ta,tb);
subplot(3,2,4);
plot(tm41, w41, '-');
xlabel 'tm41', ylabel 'w41(t)';

t42 = (0:N1-1)/S*2*tt;              % (time for two beats)
x42 = 0;
for k=1:length(f)
x42 = x42 + 12 * c(k) * sin(2 * pi * f(k) * t42);
end
subplot(3,2,5);
plot(t42, x42, '-');
xlabel 't42', ylabel 'x42(t)';

z42 = x42.*j';
w42 = resample(z42,2*ta,tb);
tm42 = resample(t42,2*ta,tb);
subplot(3,2,6)
plot(tm42, w42, '-')
xlabel 'tm42', ylabel 'w42(t)'

t43 = (0:N1-1)/S*3*tt;              % (time for three beats)
x43 = 0;
for k=1:length(f)
x43 = x43 + 12 * c(k) * sin(2 * pi * f(k) * t43);
end
z43 = x43.*j';
w43 = resample(z43,3*ta,tb);
tm43 = resample(t43,3*ta,tb);

t44 = (0:N1-1)/S*4*tt;              % (time for four beats)
x44 = 0;
for k=1:length(f)
x44 = x44 + 12 * c(k) * sin(2 * pi * f(k) * t44);
end
z44 = x44.*j';
w44 = resample(z44,4*ta,tb);
tm44 = resample(t44,4*ta,tb);

t45 = (0:N1-1)/S*0.5*tt;            % (time for half beats)
x45 = 0;
for k=1:length(f)
x45 = x45 + 12 * c(k) * sin(2 * pi * f(k) * t45);
end
z45 = x45.*j';
w45 = resample(z45,5*ta,tc);
tm45 = resample(t45,5*ta,tc);

t46 = (0:N1-1)/S*0.25*tt;           % (time for quarter beats)
x46 = 0;
for k=1:length(f)
x46 = x46 + 12 * c(k) * sin(2 * pi * f(k) * t46);
end
z46 = x46.*j';
w46 = resample(z46,25*ta,td);
tm46 = resample(t46,25*ta,td);

