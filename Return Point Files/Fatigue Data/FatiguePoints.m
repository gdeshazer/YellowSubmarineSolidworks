%% Machine Design Lab 2 - Daniil Tashlykov
%  Fatigue Analysis
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
    f_motion = @(t) 1*sin(w.*t)*W;
    
    % Completed system will operate a minimum of 12 hours per day,
    % 365 days per year with approx. 10 rides per hour. 
    
    THRC = 600; % [persons] Theoretical Hourly Capacity
    ride_duration = 6; % [min] Average ride duration
    
    t_10 = 3.154E8; % [s] 10 years in seconds
    
    % Nyquist Sampling Theorem: fs >= 2*fc
    % Will use 10 points per cycle for accuracy
    ns = 10;
    ts_hcf = ((2*pi)/w)/ns;
    t_hcf = 5000 * ts_hcf;  % [s] Total time for 5,000 SW points
    
    t1 = linspace(0, t_hcf, 5000); % [s] Max SW allowable X/Y Pairs
    y1 = f_motion(t1);
    
    % Plot only 2 periods
    interval = t1(2)-t1(1);
    T = (2*pi)/w; % [s] Period
    t2_per = linspace(0, 2*T, 1000);
    
%     plot(t2_per, f_motion(t2_per));
%     title('HCF Show Operation Loading (Force Input Waveform Over 2 Periods)');
%     xlabel('Time (s)');
%     ylabel('Force (lbf)');
%     grid on;
    
    % Save all x/y pairs
    save('showop_pts.mat', 't1', 'y1', '-mat');
    
    %% Part 2: Failure Mode Effects Loading / Seismic (LCF)
    % An impact event (e.g. actuator fails and floor platform hits ground)
    % a_seismic = [3 - exp(-wn*t)*(1+wn*t)]*g;
    
    g = 9.81; % [m/s^2] Acceleration due to gravity
    k = 100000; % [N/m] Spring constant
    m = 3600; % [kg] Mass of interest
    wn = sqrt(k/m); % [rad/s] Natural frequency (undamped system)
    
    t2 = linspace(0, 10, 100); % [s] 0 to 10 seconds per seismic event
    
    a_seismic = @(t) (3 - exp(-wn.*t).*(1+wn.*t))*g;
    
    y2 = a_seismic(t2);
    
    % Plot seismic graph
%     plot(t2, y2, 'LineWidth', 1.5, 'Color', 'r');
%     title('LCF Failure Mode Effects Loading (Seismic Plot)');
%     xlabel('Time (s)');
%     ylabel('Acceleration (m/s^2)');
%     grid on;

    % Save all x/y pairs
    save('seismic_pts.mat', 't2', 'y2', '-mat');
    
end
