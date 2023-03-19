clear;
clc;

%% Load one frequency sound of the instrument
file = 'piano_A4.wav';
[y, Fs] = audioread(file);          % y is sound data, Fs is sample frequency.
t = (0:length(y)-1)/Fs;             % time

%% The envelope with the frequency sound of the instrument
envelope(y,200,'rms')
j = resample(envelope(y,200,'rms'), 1 ,2); % make the envelope to be more samlpe points

N = 2^13;                           % number of points to analyze

%% Pick the harmonic of the sound to get the timebre
p1=pspectrum(y,Fs);
f1=Fs/N:Fs/N:11025;
p1=p1(1:N/2);
[M,I] = max(p1);
A = islocalmax(p1,'MinProminence',M/300000,'MinSeparation', 120);

%% Generate the sound using sine function for simulating the timbre and synthesis the different length of beat
f = 440:440:length(f1(A))*440;      % frequencies
c = p1(A).^0.5;                     % amplitudes
S = length(j);
N1 = 1.0 * S;                       % 1.0 sec
ta = 60;
tb = 100;
tc = 1000;
td = 10000;
tt = ta/tb;                         % 0.6 sec

t41 = (0:N1-1)/S*tt;                % time samples: t41 = N1/S (time for one beat)
x41 = 0;
for k=1:length(f1(A))
x41 = x41 + 12 * c(k) * sin(2 * pi * f(k) * t41);
end
z41 = x41.*j';                      % using envelope to simulating the timbre 
w41 = resample(z41,ta,tb);
tm41 = resample(t41,ta,tb);

t42 = (0:N1-1)/S*2*tt;              % (time for two beats)
x42 = 0;
for k=1:length(f)
x42 = x42 + 12 * c(k) * sin(2 * pi * f(k) * t42);
end
z42 = x42.*j';
w42 = resample(z42,2*ta,tb);
tm42 = resample(t42,2*ta,tb);

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

%% Let the melody to be visible by the bar of the numbered musical notation
sheetfile = 'twinkle1.xlsx';
num = readmatrix(sheetfile);
th=0;
for p=1:length(num)
    if p==length(num)
       break;
    end
    switch num(4,p)
        case 41
            th = [th th(length(th))+tt];
        case 42
			th = [th th(length(th))+2*tt];
        case 43
			th = [th th(length(th))+3*tt];
		case 44
			th = [th th(length(th))+4*tt];
        case 45
			th = [th th(length(th))+0.5*tt];
        case 46
			th = [th th(length(th))+0.25*tt];
    end
end
xa=num(1,:);
bar(th,xa,'r');
xticks(th);
axis([0 29 0 7]);

%% Change the numbered musical notation to fit the sound function
for q=1:length(num)
    switch num(1,q)
        case 1.5
			num(1,q) = 2;
        case 2
			num(1,q) = 3;
		case 2.5
			num(1,q) = 4;
        case 3
			num(1,q) = 5;
        case 4
			num(1,q) = 6;
        case 4.5
			num(1,q) = 7;
        case 5
			num(1,q) = 8;
        case 5.5
			num(1,q) = 9;
		case 6
			num(1,q) = 10;
        case 6.5
			num(1,q) = 11;
        case 7
			num(1,q) = 12;
    end
end

%% Using melody formula to synthesize different frequency of the generated sound
n=-9 : 2;
Sp= (2 .^ (n/12)) * S;

%% Use sound function to play the synthesis of piano with the melody
for p=1:length(num)
    switch num(4,p)
        case 41
			sound(w41,num(2,p).*Sp(num(1,p))); pause(num(3,p).*tt);
        case 42
			sound(w42,num(2,p).*Sp(num(1,p))); pause(num(3,p).*tt);
        case 43
			sound(w43,num(2,p).*Sp(num(1,p))); pause(num(3,p).*tt);
		case 44
			sound(w44,num(2,p).*Sp(num(1,p))); pause(num(3,p).*tt);
        case 45
			sound(w45,num(2,p).*Sp(num(1,p))); pause(num(3,p).*tt);
        case 46
			sound(w46,num(2,p).*Sp(num(1,p))); pause(num(3,p).*tt);
    end
end

