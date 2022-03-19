%------------------------------------------------
% q1
%------------------------------------------------
%chooses Ts
Ts = 1;

%creates the time interval
t = linspace(-10,10,100000);

%creates the raise cosine function
beta = 0;

%I found the max value of each root_raised_cosine function and divided the
%function by the max value in order to normalize the function
root_raised_cosin = 1/Ts*((sin(pi*t*(1-beta)/Ts)+(4*beta*t)/Ts.*cos(((1+beta)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta*t)/Ts).^2)));
A = max(root_raised_cosin);
root_raised_cosine = (1/Ts*((sin(pi*t*(1-beta)/Ts)+(4*beta*t)/Ts.*cos(((1+beta)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta*t)/Ts).^2))))/A;



%plots the raised cosine function for each beta value

%normally I tried to plot all the graphs on a single plot using for
%loop(as shown between the lines 20 and 26), however even though I used hold on; comment it only displayed the
%graph with the latest beta value which is 1 therefore I plotted them one
%by one
%for beta = 0:0.25:1
    %plot(t,raised_cosine);
    %title('Raised Cosine Pulses with Different Betas');
    %xlabel('Time');
    %ylabel('Amplitude');
    %hold on;
%end
plot(t,root_raised_cosine);
hold on;

beta1 = 0.25;
root_raised_cosin1 = 1/Ts*((sin(pi*t*(1-beta1)/Ts)+(4*beta1*t)/Ts.*cos(((1+beta1)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta1*t)/Ts).^2)));
A1 = max(root_raised_cosin1);
root_raised_cosine1 = (1/Ts*((sin(pi*t*(1-beta1)/Ts)+(4*beta1*t)/Ts.*cos(((1+beta1)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta1*t)/Ts).^2))))/A1;
plot(t,root_raised_cosine1);
hold on;

beta2 = 0.5;
root_raised_cosin2 = 1/Ts*((sin(pi*t*(1-beta2)/Ts)+(4*beta2*t)/Ts.*cos(((1+beta2)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta2*t)/Ts).^2)));
A2 = max(root_raised_cosin2);
root_raised_cosine2 = (1/Ts*((sin(pi*t*(1-beta2)/Ts)+(4*beta2*t)/Ts.*cos(((1+beta2)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta2*t)/Ts).^2))))/A2;
plot(t,root_raised_cosine2);
hold on;

beta3 = 0.75;
root_raised_cosin3 = 1/Ts*((sin(pi*t*(1-beta3)/Ts)+(4*beta3*t)/Ts.*cos(((1+beta3)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta3*t)/Ts).^2)));
A3 = max(root_raised_cosin3);
root_raised_cosine3 = (1/Ts*((sin(pi*t*(1-beta3)/Ts)+(4*beta3*t)/Ts.*cos(((1+beta3)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta3*t)/Ts).^2))))/ A3;
plot(t,root_raised_cosine3);
hold on;

beta4 = 1;
root_raised_cosin4 = 1/Ts*((sin(pi*t*(1-beta4)/Ts)+(4*beta4*t)/Ts.*cos(((1+beta4)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta4*t)/Ts).^2)));
A4 = max(root_raised_cosin4);
root_raised_cosine4 = (1/Ts*((sin(pi*t*(1-beta4)/Ts)+(4*beta4*t)/Ts.*cos(((1+beta4)*pi*t)/Ts))./(((pi*t)/Ts).*(1-((4*beta4*t)/Ts).^2))))/ A4;
plot(t,root_raised_cosine4);
hold on;

title('Root Raised Cosine Functions using Different Betas');
xlabel('Time');
ylabel('Amplitude');
legend('Beta = 0', 'Beta = 0.25', 'Beta = 0.5', 'Beta = 0.75', 'Beta = 1');

%------------------------------------------------
% q2
%------------------------------------------------

%first takes the fourier transform of each root raised cosine function and
%uses fftshift commend for better visualization and plots each function on
%a single plot
figure;
ft1=fft(root_raised_cosine);
shifted_ft1 = fftshift(ft1);
plot(abs(shifted_ft1));
hold on;

ft2=fft(root_raised_cosine1);
shifted_ft2 = fftshift(ft2);
plot(abs(shifted_ft2));
hold on;

ft3=fft(root_raised_cosine2);
shifted_ft3 = fftshift(ft3);
plot(abs(shifted_ft3));
 
hold on;
ft4=fft(root_raised_cosine3);
shifted_ft4 = fftshift(ft4);
plot(abs(shifted_ft4));
hold on;

ft5=fft(root_raised_cosine4);
shifted_ft5 = fftshift(ft5);
plot(abs(shifted_ft5));
hold on;
 
title('Fourier Transforms of the Root Raised Cosine Functions');
xlabel('Frequency');
ylabel('Magnitude');
legend('Beta = 0', 'Beta = 0.25', 'Beta = 0.5', 'Beta = 0.75', 'Beta = 1');

%------------------------------------------------
% q3
%------------------------------------------------

%creates the rectangular pulse using rectpuls() built-in function and takes
%the FT of it

rect_pulse = rectpuls(t);
ft_rect = fft(rect_pulse);
mag_rect = abs(ft_rect);
shifted_rect = fftshift(mag_rect);


%plots the time and frequency domain of the rectangular pulse
subplot(2,1,1);
plot(t,shifted_rect);
subplot(2,1,2);
title('Rectangular pulse in frequency domain');
xlabel('Frequency');
ylabel('Magnitude');
plot(t, rect_pulse);
title('Rectangular pulse in time domain');
xlabel('Time');
ylabel('Amplitude');


