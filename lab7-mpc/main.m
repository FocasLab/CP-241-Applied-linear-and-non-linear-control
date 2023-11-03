%% Control of an Inverted Pendulum on a Cart
clc;
clear;
%% Model
% Plant Model
mdlPlant = 'mpc_pendcartPlant';
load_system(mdlPlant)

% Control Structure
mdlMPC = 'mpc_pendcartImplicitMPC';
%open_system(mdlMPC)

%% Linear Plant Model
% Specify linearization input and output points.
io(1) = linio([mdlPlant '/F'],1,'openinput');
io(2) = linio([mdlPlant '/Pendulum and Cart System'],1,'openoutput');
io(3) = linio([mdlPlant '/Pendulum and Cart System'],3,'openoutput');

% Create operating point specifications for the plant initial conditions.
opspec = operspec(mdlPlant);

% X(1) = x, x(0) = 0.
opspec.States(1).Known = true;
opspec.States(1).x = 0;

% X(3) = theta, theta(0) = 0.
opspec.States(3).Known = true;
opspec.States(3).x = 0;

% Compute operating point using these specifications.
options = findopOptions('DisplayReport',false);
op = findop(mdlPlant,opspec,options);

% Obtain the linear plant model at the specified operating point.
plant = linearize(mdlPlant,op,io);
plant.InputName = {'F'};
plant.OutputName = {'x';'theta'};

% Examine the poles of the linearized plant.
pole(plant)

%% MPC Design
Ts = 0.01;
PredictionHorizon = 50;
ControlHorizon = 5;
mpcobj = mpc(plant,Ts,PredictionHorizon,ControlHorizon);

mpcobj.MV.Min = -200;
mpcobj.MV.Max = 200;
mpcobj.OV(2).Min = -pi/2;
mpcobj.OV(2).Max = pi/2;

mpcobj.MV.ScaleFactor = 100;
mpcobj.Weights.MVRate = 1;
mpcobj.Weights.OV = [1 1];

%% Closed-Loop Simulation
sim(mdlMPC)