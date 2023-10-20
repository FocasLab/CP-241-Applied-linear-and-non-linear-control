clc;
clear;

global M m L g b
M = 0.5;
m = 0.2;
b = 0.1;
g = 9.8;
L = 0.3;

global tp I
tp = 0;
I = 0;

%tSpan = 0:0.1:25;
tSpan = [0 10];
X0 = [0 0 1 0];

global cont
cont = 0;

[t,X]=ode45(@(t,x) sysdyn(t,x), tSpan, X0);
subplot(2,1,1)
plot(t,X(:,1));
ylabel('x')

subplot(2,1,2)
plot(t,X(:,3));
xlim([0 2])
ylabel('theta')
% for i=1:length(t)
%     plotcartpend(X(i,:));
% end

%%
function dX = sysdyn(t,X)
    global M m L g b
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);
    x4 = X(4);    
    Mb = (M+m*sin(x3)^2);
    
    global tp
    theta_ref = 0;
    e = theta_ref-x3;
    de = 0-x4;
    t-tp
    F = control(t,e,de,tp); % Feedback control
    tp = t;
    
    % if t<0.2
    %     Fimpulse = 1;
    % else
    %     Fimpulse = 0;
    % end
    % F = F+Fimpulse;
    
    global cont
    cont = [cont;F];

    dX = zeros(4,1);
    dX(1) = x2;
    dX(2) = (m*g*sin(x3)*cos(x3) -m*L*sin(x3)*x4^2 - b*x2 + F)/Mb;
    dX(3) = x4;
    dX(4) = cos(x3)/L*(m*g*sin(x3)*cos(x3) - m*L*sin(x3)*x4^2 -b*x2 + F)/Mb + g/L*sin(x3);
end

%%
function F = control(t,e,de,tp)
Kp = 100;
Ki = 1;
Kd = 1;
global I;
I = (I+Ki*e*(t-tp));
F = Kp*e + I + Kd*de;

% Fmax = 10;
% if F>Fmax
%     F = Fmax;
% elseif F<-Fmax
%     F = -Fmax;
% else
%     F = F;
% end
end