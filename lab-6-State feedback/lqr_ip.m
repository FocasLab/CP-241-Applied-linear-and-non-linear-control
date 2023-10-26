clc;
clear;

global M m L g b
m = 1;
M = 5;
L = 2;
g = 9.8;
b = 1;

global tp I
tp = 0;
I = 0;

%tSpan = 0:0.1:25;
tSpan = [0 10];
X0 = [0 0 1 0];

global cont
cont = 0;

%% Pole Placement
A = [0 1 0 0; ...
    0 -b/M m*g/M 0; ...
    0 0 0 1; ...
    0 -b/M/L (1+m/M)*g/L 0];
B = [0; 1/M; 0; 1/M/L];

Q = 10*[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
R = 0.01;

global K
K = lqr(A,B,Q,R);

Ecl = eigs(A-B*K);

%%
[t,X]=ode45(@(t,x) sysdyn(t,x), tSpan, X0);
subplot(2,2,1)
plot(t,X(:,1));
ylabel('x')

subplot(2,2,2)
plot(t,X(:,3));
%xlim([0 2])
ylabel('theta')

subplot(2,2,[3,4])
for i=1:length(t)
    plotcartpend(X(i,:));
end

%%
function dX = sysdyn(t,X)
    global M m L g b
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);
    x4 = X(4);    
    Mb = M;
    
    F = controlpp(X); % Full state feedback control
   
    global cont
    cont = [cont;F];

    dX = zeros(4,1);
    dX(1) = x2;
    dX(2) = (m*g*x3 - b*x2 + F)/Mb;
    dX(3) = x4;
    dX(4) = 1/L*(m*g*x3 -b*x2 + F)/Mb + g/L*x3;
end

%% Full state feedback Control
function F = controlpp(X)
global K
F = -K*X;
end