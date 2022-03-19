% ========================================================
% q1
% ========================================================

%defines necessary variables
C = 0.01;
a = 0.01;
b = 0.1;
e = 0.5;
f = 1;

%since d=0 I did not define the variable d for the first 4 questions
numerator = [C];
denominator = [a*e f*a+b*e b*f+C^2 0];
plant_func = tf(numerator, denominator);

%since we have a unit feedback I wrote 1 in the feedback function
sys = feedback(plant_func, 1);

%plots the step response of the plant
figure;
step(sys);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the Plant');


% ========================================================
% q2
% ========================================================

%according to my calculations, which are shown in the report I found Ku is
%equal to 120.12 using the Routh Table. Therefore, from the ZN method, Kp = 60

%defines necessary variables
Ku = 120.12;
sys2 = feedback(plant_func*Ku, 1);

figure;
step(sys2);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of H');

figure;
rlocus(sys,'r',sys2,'b')
hold on;
legend('Root Locus of P(s)','Root Locus of H(s)')
hold off;

% ========================================================
% q3
% ========================================================

%a)
figure;
step(sys);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the Plant');
plant_info = stepinfo(sys);

%b)
%for this case Kp = 60.06 and the others are 0 since Kp = 0.5*Ku for P control

p_control = pid(60.06,0,0);
sys3 = feedback(p_control*plant_func, 1);

figure;
step(sys3);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the CL System with P');
p_control_info = stepinfo(sys3);

%c)
%for this case Kp = 54.054, Ki =42.96, Kd=0, since Kp = Ku*0.45 and Ki = Ku*0.45/(Tu/1.2) where Tu
%=1.51 for PI control 

pi_control = pid(54.054,42.96,0);
sys4 = feedback(pi_control*plant_func, 1);

figure;
step(sys4);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the CL System with PI');
pi_control_info = stepinfo(sys4);

%d)
%for this case Kp = 72.072, Ki=95.46, Kd=13.6, since Kp = Ku*0.6, Ki = 0.6*2*Ku/Tu and Kd = 0.6*Ku*Tu/8 where Tu
%=1.51 for PID control

pid_control = pid(72.072,95.46,13.6);
sys5 = feedback(pid_control*plant_func, 1);

figure;
step(sys5);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the CL System with PID');
pid_control_info = stepinfo(sys5);

% ========================================================
% q4
% ========================================================

%I changed the value of Kd from 13.6 to 50 to satisfy the requirement of
%this question. I obtained sep response without steady state error, with
%less than 14% overshoot percent but slightly more than 0.14 rise time

modified_pid_control = pid(72.072,95.46,50);
sys6 = feedback(modified_pid_control*plant_func, 1);

figure;
step(sys6);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the CL System with PID(with modified control value)');
modified_pid_control_info = stepinfo(sys6);

% ========================================================
% q5
% ========================================================








