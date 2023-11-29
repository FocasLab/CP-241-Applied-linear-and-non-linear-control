clc;
clear;

global m R g L d J
m = 0.1; % mass of ball
R = 0.02; % radius of ball
g = 9.8; % acceleration due to gravity
L = 1; % length of rod
d = 0.05; % lever arm
J = 1e-5; % moment of inertia of ball

global tp I thp
tp = 0;
I = 0;
thp = 0;

tSpan = 0:0.1:25;
%tSpan = [0 10];
X0 = [0.25 0];

global cont tc
cont = 0;
tc = 0;

[t,X]=ode45(@(t,x) sysdyn(t,x), tSpan, X0);

figure(1)
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
        
    global tp thp
    r_ref = 0.25*sin(t)+0.25;
    e = r_ref-r;
    de = 0-dr;
    th = control(t,e,de,tp); % Feedback control
    
    if t==tp
        dth = 0;
    else
        dth = (th-thp)/(t-tp);
    end
    tp = t;
    thp = th;
       
    global cont tc
    cont = [cont;th];
    tc = [tc;t];

    dX = zeros(2,1);
    dX(1) = dr;
    %dX(2) = m*g/(J/R^2+m)*sin(d/L*th) + m*r*(d/L*dth)^2;
    dX(2) = m*g/(J/R^2+m)*(d/L*th);
end

%%
function th = control(t,e,de,tp)
Kp = 20;
Ki = 0.05;
Kd = 2;
global I;
I = (I+Ki*e*(t-tp));
th = Kp*e + I + Kd*de;

%th = mod(th,2*pi);
end