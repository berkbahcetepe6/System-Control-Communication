m_original = audioread("speech_dft_8kHz.wav");
soundsc(m_original,8000)
% 1.A)
%increases the sample rate of the input signal by a factor of 100 to make it
%equal to 800k
m = interp(m_original,100);

%total number of samples
ls = length(m);

%1.B)
%creats a cos signal with the carrier frequency 250kHz
fs = 8000*100;
fc = 250000;
t=0:1/fs:(ls-1)/fs;
t=transpose(t);
cos_sig = cospi(2*fc*t);

%in order to determine A, I found the maximum value of m which is 0.9914 as
%well as its index. From the equation if we devide 0.9914 by 0.6(which is 
%the modulation index), we calculate A which is equal to 1.6523.
[maxSignal,index] = max(m);
modulation_index = 0.6;
A = maxSignal/modulation_index;

%modulates the m signal with the carrier frequency 250kHz, then takes the
%fourier transform of it in order to plot the magnitude spectrum of it
y = (A+m).*cos_sig;
f = fs*(-(ls-1)/2:(ls-1)/2)/ls;

%y = awgn(y,20,'measured');
% this is for Q3., it adds 20 dB white Gaussian noise to y.
%please delete the comment sign when you check the Q3.

%1.C)
%plots the magnitude spectrum of m
FT_m = fft(m);
mag_m = abs(FT_m);

plot(f,mag2db(fftshift(mag_m)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the message signal in dB")
grid on

%plots the magnitude spectrum of y
FT_y = fft(y);
mag_y = abs(FT_y);

figure
plot(f,mag2db(fftshift(mag_y)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the modulated signal in dB")
grid on

%2.A)
%In order to emulate an ideal diode, I set the negative values of the
%modulated signal to 0
y(y<0) = 0;
FT_y1 = fft(y);
mag_y1 = abs(FT_y1);

figure
plot(f,mag2db(fftshift(mag_y1)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the rectified modulated signal  in dB")
grid on

%2.B)
%for tau = 5*10^-5
tau_1 = 5* 1e-5;
h1 = exp(-t/tau_1);
h1(t<0)=0;
FT_h1 = fft(h1);
mag_h1= abs(FT_h1);

%plots the magnitude spectrum of the filter
figure
plot(f,mag2db(fftshift(mag_h1)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the low pass filter in dB (tau=5*10^5)")
grid on

dem_y = FT_h1.*FT_y1;
mag_dem_y = abs(dem_y);

%plots the demodulated signal in freq. domain
figure
plot(f,mag2db(fftshift(mag_dem_y)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the demodulated signal in dB (tau=5*10^5)")
grid on

%plots the demodulated signal in freq. domain
dem_y_time = ifft(dem_y);

figure
plot(f,dem_y_time)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the demodulated signal(tau=5*10^5)")
grid on

%for tau = 5*10^-4
tau_2 = 5* 1e-4;
h2 = exp(-t/tau_2);
h2(t<0)=0;
FT_h2 = fft(h2);
mag_h2= abs(FT_h2);

%plots the magnitude spectrum of the filter
figure
plot(f,mag2db(fftshift(mag_h2)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the low pass filter in dB (tau=5*10^4)")
grid on

%plots the magnitude of the original signal in time domain
figure
plot(m)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the original signal")
grid on

dem_y1 = FT_h2.*FT_y1;
mag_dem_y1 = abs(dem_y1);

%plots the demodulated filtered signal in freq. domain
figure
plot(f,mag2db(fftshift(mag_dem_y1)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the demodulated signal in dB (tau=5*10^4)")
grid on

%plots the demodulated signal in time domain
dem_y1_time = ifft(dem_y1);

figure
plot(f,dem_y1_time)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the demodulated signal(tau=5*10^4)")
grid on

%plots the original signal
figure
plot(f,m)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the message signal")
grid on

%2.C)
down_m1 = decimate(dem_y_time,100); %for tau = 5*10^-5
FT_down_m1 = fft(down_m1);
mag_down_m1 = abs(FT_down_m1);

down_m = decimate(dem_y1_time,100); %for tau = 5*10^-4
FT_down_m = fft(down_m);
mag_down_m = abs(FT_down_m);

FT_m_original = fft(m_original);
mag_m_original = abs(FT_m_original);


subplot(3,2,1);
plot(m_original)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the message signal")
grid on

subplot(3,2,2);
plot(mag2db(fftshift(mag_m_original)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the message signal in dB")
grid on

subplot(3,2,3);
plot(down_m)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the downsampled and demodulated signal (tau= 5*10^-4)")
grid on

subplot(3,2,4);
plot(mag2db(fftshift(mag_down_m)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the downsampled and demodulated signal in dB (tau= 5*10^-4)")
grid on

subplot(3,2,5);
plot(down_m1)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the downsampled and demodulated signal (tau= 5*10^-5)")
grid on

subplot(3,2,6);
plot(mag2db(fftshift(mag_down_m1)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the downsampled and demodulated signal in dB (tau= 5*10^-5)")
grid on


soundsc(down_m, 8000) %makes me listen the demodulated and downsampled signal

%3)
%The noise is added to y in line 31, please delete the comment sign in order to add noise to y signal
%Thanks for the understanding

