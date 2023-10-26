clc;
clear;

A = [0 1; 2 -1]; 
B = [1; 0];
C = [1 0];
D = 0;

sys = ss(A,B,C,D);
E = eig(A)

P = [-2, -1];
K = place(A,B,P);

Acl = A-B*K;
Ecl = eig(Acl)

syscl = ss(Acl,B,C,D);

subplot(3,1,1)
step(sys)
subplot(3,1,2)
step(syscl)

Kr = 2;
syscl_scaled = ss(Acl,B*Kr,C,D);

subplot(3,1,3)
step(syscl_scaled)

