clc;
clear;

% Kp = 100;
% Ki = 100;
% Kd = 1;
% 
% s = tf('s');
% C = Kp + Ki/s + Kd*s;
% 
% %% Spring-Mass-Damper System
% m = 1; % kg
% b = 10; % N s/m
% k = 20; % N/m
% F = 1; % N
% P = 1/(m*s^2 + b*s + k); % Plant Transfer Funtion
% 
% %step(P); % Step Input
% H = feedback(C*P,1); % C*P/(1+C*P)
% 
% %t = 0:0.01:10;
% %step(H,t)
% step(H)

%% Automatic PID Tuning
%pidTuner(P,'p') % 'p' specifies that the tuner employ a proportional controller.

%pidTuner(P,C) % compare the response of the system with the automated controller with that of the baseline controller C.

%% Inverted Pendulum PID
M = 0.5;
m = 0.2;
b = 0.1;
g = 9.8;
L = 0.3;
l = L;
s = tf('s');
P_pend = s/(M*L*s^3 + b*L*s^2 - (M+m)*g*s - b*g);

Kp = 100;
Ki = 1;
Kd = 1;
C = pid(Kp,Ki,Kd);
T = feedback(P_pend,C);

t=0:0.01:10;
subplot(2,1,1)
impulse(T,t)

% Kp = 100;
% Ki = 1;
% Kd = 1;
% C = pid(Kp,Ki,Kd);
% T = feedback(P_pend,C);
% t=0:0.01:2;
% impulse(T,t)
% C1 = pidtune(P_pend,C);
% T1 = feedback(P_pend,C1);
% impulse(T,T1)
% legend('manual','automated','Location','SouthEast')

%%
P_cart = P_pend*(L-g/s^2);
T2 = feedback(1,P_pend*C)*P_cart;
t = 0:0.01:5;
subplot(2,1,2)
impulse(T2, t);
