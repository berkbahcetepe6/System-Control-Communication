%1.A)
m_original = audioread("speech_dft_8kHz.wav");
%increases the sampling rate of the input signal by a factor of 300 to make it
%equal to 2400k
m = interp(m_original,300);

%total number of samples
ls = length(m);

%1.B)
%variable initialization for the FM modulated signal y
fs = 8000*300; %sampling rate
fc = 450000; %carrier frequency
kf = 300000*pi;
t=0:1/fs:(ls-1)/fs;
t=transpose(t);

%creates the modulated signal
y = cos(2*pi*fc*t+ kf * cumsum(m)/fs);

%1.C)
%plots the Fourier magnitude of y
FT_size = 2^nextpow2(length(y));
f = fs*(0:FT_size-1)/FT_size;
FT_y = fft(y,FT_size);
mag_y = abs(FT_y);

figure
plot(f,mag2db(fftshift(mag_y)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the modulated signal in dB")
grid on

%1.D) This part will be answered in the report

%2.A)
y_diff = diff(y)*fs;
y_diff(y_diff<0)=0; %passes through an ideal diode


%2.B)
tau = 1e-3;
h = exp(-t/tau);
h(t<0)=0; %since there is a unitstep function that is multiplied with exp part of the filter
FT_h = fft(h,FT_size);

%2.C)
FT_y_diff = fft(y_diff,FT_size);
dem_y = FT_h.*FT_y_diff;
mag_dem_y = abs(dem_y);
dem_y_time = ifft(dem_y);

%plots the spectrum of message signal and the demodulated signal in frequency domain(before
%downsampling)
subplot(2,1,1);
plot(f,mag2db(fftshift(mag_y)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the message signal")

%subplot(2,1,2);
plot(f,mag2db(fftshift(mag_dem_y)))
xlabel("Frequency(Hz)")
ylabel("Magnitude(dB)")
title("Magnitude spectrum of the demodulated signal in dB")
grid on

%plots the spectrum of message signal and the demodulated signal in time domain(after
%downsampling)

subplot(2,1,1);
plot(m)
xlabel("Time")
ylabel("Magnitude")
title("Magnitude of the message signal")

subplot(2,1,2);
plot(dem_y_time)
xlabel("Frequency")
ylabel("Magnitude")
title("Magnitude of the demodulated signal")
grid on

%2.D)
%downsamples the signal to 8k Hz and listens to it
down_m = decimate(dem_y_time,300);
soundsc(down_m, 8000);

