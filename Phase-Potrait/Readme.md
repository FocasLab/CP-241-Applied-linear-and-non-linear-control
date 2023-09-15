## Documentation for Function `phasePotrait`
The function `phasePotrait` can be used to check whether your code is working correctly. Alternatively, you can also use the online version https://aeb019.hosted.uark.edu/pplane.html 

Example Usage

Minimal -> only phase potraits
```matlab
% settings
x_lim = [-5 5]; % x-axis limit
y_lim = [-5 5]; % y-axis limit
step_size = 20; % discretization factor

% function definition
k_1 = 0.21;
k_2 = 0.42;
f = @(t,X) ([-k_1*X(1); k_1*X(1) - k_2*X(2)]);

% phase potraint -> return figure handle
fig = phasePotrait(f, x1_lim, x2_lim, step_size);
```
Advanced
Phase-Potrait with trajectories plotting trajectories
```matlab
% settings
x_lim = [-5 5]; % x-axis limit
y_lim = [-5 5]; % y-axis limit
step_size = 20; % discretization factor

% options
options.vector_color = 'r'; % arrow color
options.xlabel = 'x_1';
options.ylabel = 'x_2';
options.title = ["Phase Potrait", "$\dot{x}_1 = -k_1 x_1$", "$\dot{x}_2 = k_1 x_1 - k_2 x_2$"]; % multi-line title
options.title_Fontsize = 12;

options.equal_size_vectors = 1;
options.trajectories.tend = 50; % time [0 tend] for the duration of the trajectory
options.trajectories.traj_color = 'b'; % color of the trajectory
options.trajectories.plotTraj = true; % to plot the user input trajectory
options.trajectories.numTraj = 2; % will only be used if above statement is true
options.trajectories.plotArrow = false; % to plot the directions of the trajectory
options.trajectories.numArrows = 0; % will only be used if above statement is true
options.trajectories.lineWidth = 2;

% function definition
k_1 = 0.21;
k_2 = 0.42;
f = @(t,X) ([-k_1*X(1); k_1*X(1) - k_2*X(2)]);

% phase potraint -> return figure handle
fig = phasePotrait(f, x1_lim, x2_lim, step_size, options);
```
