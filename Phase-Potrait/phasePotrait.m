% ********************************************
% The description of the function phasePotrait
% ********************************************
%
% f  = function handle that describes the system dynamics of the format
%                   shown here  f = @(t,x) [ X1_dot; X2_dot];
% x1_lim = specifies the limits along dimension x1 and specified as 
%                   [x1_left_limit, x1_right_limit]
% x2_lim  = specifies the limits along dimension x2 and specified as
%                   [x2_left_limit, x2_right_limit]
% step_size = numerical step_size for discretizing the graph
%
% ********************************************
% for advanced usage, use the options below
% ********************************************
%
% options = structure to specify the properties of the graph
%           options.vector_color       = color of the vector (see help plot
%           for more information
%           options.xlabel             = x-axis label;
%           options.ylabel             = y-axis label;
%           options.title              = title of the phase potrait;
%           options.title_Fontsize     = font size of the ti;
%           options.equal_size_vectors = true;
%
%           options.trajectories.tend       = time [0 tend] for the 
%           duration of the trajectory
%           options.trajectories.traj_color = color of the trajectory (see
%            documentation of plot for more informations)
%           options.trajectories.plotTraj   = true/false to plot the 
%           trajectories for the given number of inputs;
%           options.trajectories.numTraj    = number of trajectories to plot 
%                                          (will only be used if above 
%                                           statement is true)
%           options.trajectories.plotArrow  = true/false to plot the arrow 
%                                            on the trajectory or not;
%           options.trajectories.numArrows  = number of arrows 
%                                            (will only be used if above 
%                                               statement is true)
%           options.trajectories.lineWidth  = linewidth of the trajectory
