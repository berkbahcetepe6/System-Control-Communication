%------------------------------------------------
% q1
%------------------------------------------------
%a) generates a double polarity random sequence with length 300 for 3
%bits/symbol. Therefore, the it can take 8 different amplitude values such
%as -7, -5, -3, -1, 1, 3, 5, 7

length = 300;

random_sequence = randi([1 8],length, 1);

%since I could not randomly generate integers from -7 to 7 with an
%incremenet of 2, I generated integers from 1 to 8 and assigned the extra
%values to the negative ones

for i = 1:length
    if random_sequence(i) == 2
        random_sequence(i) = -1;
        
    elseif random_sequence(i) == 4
          random_sequence(i) = -3;  
          
    elseif random_sequence(i) == 6  
          random_sequence(i) = -5;
    elseif random_sequence(i) == 8
           random_sequence(i) = -7;
    end
    
end

%b)

%chooses Ts, fs and beta
Ts = 1;
fs = 500;
beta = 1;
%creates the time interval
t = 0:1/fs:length;
t1 = linspace(-10,10,100000);
root_raised_cosine = 1/Ts*((sin(pi*t1*(1-beta)/Ts)+(4*beta*t1)/Ts.*cos(((1+beta)*pi*t1)/Ts))./(((pi*t1)/Ts).*(1-((4*beta*t1)/Ts).^2)));
A = max(root_raised_cosine);


%PAM modulates the signal with root raised cosine function

pam = 0;

for i=1:length
   
    pam = pam + random_sequence(i)* (1/Ts*((sin(pi*(t-(i-1))*(1-beta)/Ts)+(4*beta*(t-(i-1)))/Ts.*cos(((1+beta)*pi*(t-(i-1)))/Ts))./(((pi*(t-(i-1)))/Ts).*(1-((4*beta*(t-(i-1)))/Ts).^2))))/A;
    
end

subplot(2,1,1);
plot(t, pam);
xlabel('Time');
xlim([0 10.5]);
ylabel('Amplitude');
title('PAM modulated signal (Beta = 1)');

subplot(2,1,2);
plot(pam);
xlabel('Time');
ylabel('Amplitude');
title('PAM modulated sequence (Beta = 1)');

%c

%in order to filter the PAM signal, I filtered it with the same pulse which
%is the root raised cosine function. Therefore I took the convolution of
%them

normalized_root_raised_cosine = root_raised_cosine/A;

filtered_pam = conv(pam, normalized_root_raised_cosine);

%plots the filtered signal
figure;
plot(filtered_pam);
xlabel('Time');
ylabel('Amplitude');
title('Filtered PAM signal');

%------------------------------------------------
% q2
%------------------------------------------------

%for beta = 0.50
beta1 = 0.50;
%creates the time interval
root_raised_cosine1 = 1/Ts*((sin(pi*t1*(1-beta1)/Ts)+(4*beta1*t1)/Ts.*cos(((1+beta1)*pi*t1)/Ts))./(((pi*t1)/Ts).*(1-((4*beta1*t1)/Ts).^2)));
A1 = max(root_raised_cosine1);


%PAM modulates the signal with root raised cosine function

pam1 = 0;

for i=1:length
   
    pam1 = pam1 + random_sequence(i)* (1/Ts*((sin(pi*(t-(i-1))*(1-beta1)/Ts)+(4*beta1*(t-(i-1)))/Ts.*cos(((1+beta1)*pi*(t-(i-1)))/Ts))./(((pi*(t-(i-1)))/Ts).*(1-((4*beta1*(t-(i-1)))/Ts).^2))))/A1;
    
end

subplot(2,1,1);
plot(t, pam1);
xlabel('Time');
xlim([0 10.5]);
ylabel('Amplitude');
title('PAM modulated signal (Beta = 0.50)');

subplot(2,1,2);
plot(pam1);
xlabel('Time');
ylabel('Amplitude');
title('PAM modulated sequence (Beta = 0.50)');

normalized_root_raised_cosine1 = root_raised_cosine1/A1;

filtered_pam1 = conv(pam, normalized_root_raised_cosine1);

%plots the filtered signal
figure;
plot(filtered_pam1);
xlabel('Time');
ylabel('Amplitude');
title('Filtered PAM signal');

%for beta = 0.25

beta2 = 0.25;
%creates the time interval
root_raised_cosine2 = 1/Ts*((sin(pi*t1*(1-beta2)/Ts)+(4*beta2*t1)/Ts.*cos(((1+beta2)*pi*t1)/Ts))./(((pi*t1)/Ts).*(1-((4*beta2*t1)/Ts).^2)));
A2 = max(root_raised_cosine2);


%PAM modulates the signal with root raised cosine function

pam2 = 0;

for i=1:length
   
    pam2 = pam2 + random_sequence(i)* (1/Ts*((sin(pi*(t-(i-1))*(1-beta2)/Ts)+(4*beta2*(t-(i-1)))/Ts.*cos(((1+beta2)*pi*(t-(i-1)))/Ts))./(((pi*(t-(i-1)))/Ts).*(1-((4*beta2*(t-(i-1)))/Ts).^2))))/A2;
    
end

subplot(2,1,1);
plot(t, pam2);
xlabel('Time');
xlim([0 10.5]);
ylabel('Amplitude');
title('PAM modulated signal (Beta = 0.25)');

subplot(2,1,2);
plot(pam2);
xlabel('Time');
ylabel('Amplitude');
title('PAM modulated sequence (Beta = 0.25)');

normalized_root_raised_cosine2 = root_raised_cosine2/A2;

filtered_pam2 = conv(pam, normalized_root_raised_cosine2);

%plots the filtered signal
figure;
plot(filtered_pam2);
xlabel('Time');
ylabel('Amplitude');
title('Filtered PAM signal');

%------------------------------------------------
% q3
%------------------------------------------------

root_raised_cosine_noisy = awgn(root_raised_cosine_noisy, 15, 'measured');


