%% Initialization
clear
close all
clc
% time parameters
t_end = 8;
dt = 0.12;
tsamples = (0:dt:t_end)';

% state initialization
numSamples = length(tsamples);
X = zeros(numSamples,1);

% initial state value
X(1) = 2;

% function definition
f = @(t,x) (-1.2*x + 7*exp(-0.3*t));

% analytical solution
phi = @(t)exp(t.*(-6.0./5.0)).*(exp(t.*(9.0./1.0e+1)).*3.5e+1-2.6e+1).*(2.0./9.0);

%% implementation

tic
for i = 1:numSamples-1
    % euler forward
    X(i+1) = X(i) + f(tsamples(i),X(i))*dt;
end
toc

x_real = phi(tsamples);
%% Plots

fig = figure();
fig.Position = [488 358.6000 855.4000 403.4000];

subplot(1,2,1)
hold on
plot(tsamples,x_real,"*k", "DisplayName","Analytical Solution")
plot(tsamples,X,"b", "DisplayName","Euler Approximation")
ylabel("X(t)")
xlabel("time (secs)")
legend()

subplot(1,2,2)

plot(tsamples,abs(x_real - X),"r",  "DisplayName", "Euler Approximation")
xlabel("time (secs)")
ylabel("|X_{an} - X_{num}|")
