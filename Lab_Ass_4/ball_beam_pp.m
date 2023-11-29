clc;
clear;

global m R g L d J
m = 0.1; % mass of ball
R = 0.02; % radius of ball
g = 9.8; % acceleration due to gravity
L = 1; % length of rod
d = 0.05; % lever arm
J = 1e-5; % moment of inertia of ball

A = [0 1; 0 0];
B = [0; m*g*d/L/(J/R^2+m)];

%% Pole placement
%P = [-1 -2];
%P = [-2+i, -2-i];
global K
%K = place(A,B,P);

%% LQR
Qmat = [1 0; 0 10];
Rmat = 1;
K = lqr(A,B,Qmat,Rmat);

%%
tSpan = 0:0.1:25;
%tSpan = [0 10];
X0 = [0.25 0];

global cont tc
cont = 0;
tc = 0;

[t,X]=ode45(@(t,x) sysdyn(t,x), tSpan, X0);

figure
subplot(2,1,1)
plot(t,X(:,1));
ylabel('r')

subplot(2,1,2)
plot(tc,cont);
ylabel('theta')

%%
function dX = sysdyn(t,X)
    global m R g L d J
    r = X(1);
    dr = X(2);   
        
    th = control(X); % Feedback control
          
    global cont tc
    cont = [cont;th];
    tc = [tc;t];

    dX = zeros(2,1);
    dX(1) = dr;
    %dX(2) = m*g/(J/R^2+m)*sin(d/L*th) + m*r*(d/L*dth)^2;
    dX(2) = m*g/(J/R^2+m)*(d/L*th);
end

%%
function th = control(X)
global K;
th = -K*X;

%th = mod(th,2*pi);
end