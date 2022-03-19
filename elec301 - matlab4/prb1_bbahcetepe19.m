% ========================================================
% q1
% ========================================================

% define necessary variables

a = 0.1;
b = -1;
K = 1;

% create controller and plant functions and define the system with unity
% feedback

plant_numerator = 3;
plant_denominator = [a b];
plant_func = tf(plant_numerator, plant_denominator);

controller_numerator = [0.1 3.75];
controller_denominator = [16/600 1.1 19.75];
controller_func = tf(controller_numerator, controller_denominator);

sys = feedback(plant_func* controller_func, K);

%plot the step response of the closed-loop system

figure;
step(sys);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the Closed-Loop System');

% ========================================================
% q2
% ========================================================

% plot the root locus diagram of the closed-loop system

figure;
rlocus(sys,'b')
hold on;
legend('Root Locus of the Closed-Loop System')
hold off;

figure;
rlocus(plant_func* controller_func,'b')
hold on;
legend('Root Locus of the Open-Loop System')
hold off;

% plot the step response of the closed loop system with K = 5 as the new
% gain

K_new = 3;
sys2 = feedback(plant_func* controller_func, K_new);
figure;
step(sys2);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the Closed-Loop System with K = 3');

% ========================================================
% q3
% ========================================================

% calculate and plot the digital controller using impulse sampling with
% sampling period 1ms and by using s = (z-1)/Ts formula seperately

Ts = 0.001;
C_z = c2d(controller_func, Ts, 'impulse');

Cz_numerator = [0.00375 -0.003611 -4*10^(-19)];
Cz_denominator = [1 -1.959 0.9596];
Cz_func = tf(Cz_numerator, Cz_denominator, Ts);

figure;
subplot(2,1,1);
step(C_z);
title('Step Response of the Digital Controller');
subplot(2,1,2);
step(Cz_func);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the Manually Calculated Digital Controller');


% ========================================================
% q4
% ========================================================

% calculate the converted C(s) function and compares it with the original
% one
C_s = d2c(C_z, 'zoh');

figure;
subplot(2,1,1);
step(controller_func);
title('Step Response of the Original Controller Function');
subplot(2,1,2);
step(C_s);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the Converted Controller Function');

% plot the step response of the system for both controller functions

sys3 = feedback(plant_func* C_s, K_new);

figure;
subplot(2,1,1);
step(sys2);
title('Step Response of the Closed-Loop System with the Original Plant');
subplot(2,1,2);
step(sys3);
xlabel('Time');
ylabel('Amplitude');
title('Step Response of the Closed-Loop System with the Converted Plant');






