%--------------------------------------
%q1
%--------------------------------------

%creates bit sequences
%a)
length = 180;
random_sequence = randi([0 1],length, 1);

%b)
%modulation level
M = 64;
x = 0:M-1;

%number of bits per symbol
k = log2(M);

%draws the contellation diagram for 64-QAM
y = qammod(x,M);
scatterplot(y,1,0,'k*');
title("Constellation diagram for 64-QAM");


%--------------------------------------
%q2
%--------------------------------------

%since qammod function accepts integer values I converted the binary values
%to integer values
noisy_y = awgn(y, 10, 'measured');

y1 = scatterplot(noisy_y,1,0,'g.');
hold on
scatterplot(y,1,0,'k*',y1);
title("Constellation diagram for 64-QAM with 10 db noise");
