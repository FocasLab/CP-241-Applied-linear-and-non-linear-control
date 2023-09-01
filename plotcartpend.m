function plotcartpend(y)
x = y(1);
th = pi-y(3);

% Ground
plot([-10 10],[0 0],'k','LineWidth',2); hold on
plot([-10 10],[-0.05 -0.05],'k','LineWidth',2);

% Cart
W = 1;  % cart width
H = .5; % cart height
wr = .2; % wheel radius
cx = x; % cart horizontal position
cy = wr/2+H/2; % cart vertical position
rectangle('Position',[cx-W/2,cy-H/2,W,H],'Curvature',.1,'FaceColor',[0.1 0.1 1])

% Wheel 1
w1x = x-.9*W/2;
w1y = 0;
rectangle('Position',[w1x,w1y,wr,wr],'Curvature',1,'FaceColor','k')

% Wheel 1
w2x = x+.9*W/2-wr;
w2y = 0;
rectangle('Position',[w2x,w2y,wr,wr],'Curvature',1,'FaceColor','k')

% Pendulum
L = 2;  % pendulum length
mr = 0.3; % Bob
px = cx + L*sin(th);
py = cy - L*cos(th);
plot([x px],[cy py],'k','LineWidth',2.5)
rectangle('Position',[px-mr/2,py-mr/2,mr,mr],'Curvature',1,'FaceColor',[0.8 0.1 0.1])

%
xlim([-5 5]);
ylim([-2 3]);
%set(gcf,'Position',[100 550 1000 400])

drawnow
hold off