function spln = createSpline(r,period, evalTimes)
% Generates cubic spline trajectory parameters given waypoints

% Create necessary values for calculations
numPoints = numel(r);
traj_times = linspace(0,period,numPoints);

% Calculate derivatives
dt = period/(numPoints-1);
r_der = [0 0.5*(diff(r(1:end-1)) + diff(r(2:end)) )/dt 0];


% Set initial conditions
% Evaluate the trajectory at the start and halfway points for right and
% left legs, respectively
spln = cubicpolytraj(r,traj_times,evalTimes,'VelocityBoundaryCondition',r_der);
