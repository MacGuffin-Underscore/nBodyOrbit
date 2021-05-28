%% nBody.m
clc; clear all; format shortg;

randn('state',0)
rand('state',0)

n = 2;                          %Number of bodies
step = 10001;                   %Steps
G = 1;                          %Gravitational constant

%% Initial Conditions
    r0 = 50*rand([3,n]);         %Initial position
    rdot0 = 0.01*randn([3,n]);   %Initial velocity
    m = rand([n,1]);             %Mass of body

%% Call ode45
X0 = [r0(:);rdot0(:)];
t = linspace(0, 5000, step);
options = odeset('RelTol', 5e-14, 'AbsTol', 5e-14);
[T,X] = ode45(@fnBody, t, X0, options, G, m, n);

%% Get Positions
fh = figure;
for i = 1:n
    r(:,:,i) = X(:,3*i-2:3*i);
end

%% Show Motion
fh = figure;
for i = 1:n
    h(i) = plot3(r(1,1,i),r(1,2,i),r(1,3,i),'bo',...
        'MarkerSize',12,'MarkerFaceColor','b');
    hold on
end
grid
axis equal
set(gca,'XLim',[min(min([r(:,1,:)])),...
    max(max([r(:,1,:)]))],...
    'YLim',[min(min([r(:,2,:)])),...
    max(max([r(:,2,:)]))],...
    'ZLim',[min(min([r(:,3,:)])),...
    max(max([r(:,3,:)]))]);
set(fh,'NextPlot','replacechildren')
for i=2:step
    for j=1:n
        set(h(j),'Xdata',r(i,1,j),'Ydata',r(i,2,j),'Zdata',r(i,3,j));
    end
    drawnow
end