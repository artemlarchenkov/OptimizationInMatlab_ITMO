function penalty = optOpenChainmove(p,mdlName)

    % Load parameters into function workspace
    disp(p) % to display parameters of optimization
    parameters % upload static parameters 
    
    % Extract simulation inputs from parameters
    r_number = numel(p)-2; % without alpha
    r_motion = [p(1:r_number), p(1)];
    alpha = p(numel(p)-1);
    gait_period = p(numel(p));
    traj_times = linspace(0, gait_period, numel(r_motion));
    r_der = createSmoothTrajectory(-r_motion,gait_period);
  
    % Simulate the model
    simout = sim(mdlName,'StopTime','10','SrcWorkspace','current');         
    
    % Unpack logged data
    measBody = get(simout.yout,'measBody').Values;
    x_a = measBody.X.Data;
    y_a = measBody.Y.Data;
    z_a = measBody.Z.Data;
    x_f = measBody.X_f.Data;
    y_f = measBody.Y_f.Data;
    z_f = measBody.Z_f.Data;
    x = abs(mean(x_a) - mean(x_f));
    y = abs(mean(y_a) - mean(y_f));
    z = abs(mean(z_a) - mean(z_f));

    %hMean = mean(h)*100; % cm
    %xEnd = measBody.X.Data(end)*100; % cm
    %xMean = mean(measBody.X.Data)*100; % cm
    tEnd = simout.tout(end);

    % Reward for moving
    %penalty = - hMean^2 * tEnd^2 /( 1 + abs(xMean));
    penalty = -tEnd^2/(abs(x) + abs(y) + abs(z) + 1);
    
end

