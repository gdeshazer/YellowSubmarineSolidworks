function FatiguePoints()

    %% Fatigue Specifications
    %  Mean Time Before Failure (MTBF): 500 Hours
    %  Mean Time to Restore (MTTR): 24 Hours
    %  Minimum System Life: 10 Years
    
    %% Part 1: Regular Show Operating Conditions (HCF)
    % The "show" is a sinusodial force input to the structure:
    % f_motion = 1*sin(w*t)*W
    
    w = 1/pi; % [rad/s] Forcing frequency
    W = 25000; % [lbf] Dead load only
    f_motion = @(t) 1*sin(w*t)*W;
    
    %% Part 2: Failure Mode Effects Loading / Seismic (LCF)
    % An impact event (e.g. actuator fails and floor platform hits ground)
    % a_seismic = [3 - exp(-wn*t)*(1+wn*t)]*g;
    
    g = 9.81; % [m/s^2] Acceleration due to gravity
    k = 100000; % [N/m] Spring constant
    m = 3600; % [kg] Mass of interest
    wn = sqrt(k/m); % [rad/s] Natural frequency (undamped system)
    
    t2 = linspace(0, 10, 1000); % [s] 0 to 10 seconds per seismic event
    
    a_seismic = @(t) (3 - exp(-wn.*t).*(1+wn.*t))*g;
    
    plot(t2, a_seismic(t2), 'LineWidth', 1.5, 'Color', 'r');
    title('LCF Failure Mode Effects Loading (Seismic Plot)');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    grid on;
end
