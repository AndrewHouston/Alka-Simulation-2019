function [muzzleVelocity,Bdistance] = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep)
    velocity = 0;
    distance = 0;
    time = 0;
    pressure = p0Chamber;
    while distance < lBarrel
%       time = time + timeStep;                                         % Increment the time by the timestep, not used currently 
        
        % Calculate the various components of the acceleration vector then combine them
        accel = pressure * aBarrel / mNet;                              % Acceleration is force times area divided by mass
        accelDrag = -0.5 * rho * aBarrel * cdPiston * velocity^2 / mNet;  % Drag equation with assumed coefficiant of friction for the sled
        accelAtmosphere = -pAtmosphere * aBarrel / mNet;                % Account for pressure of the atmosphere
        accelNet = accel + accelDrag + accelAtmosphere + -g;                 % Sum up all the accelerations to come up with a net value
        
        % Use LRAM to estimate the current velocity and position
        velocity = velocity + accelNet * timeStep;
        distance = distance + velocity * timeStep;
        
        % Determine the updated chamber volume and pressure
        volume = aBarrel * distance + v0Chamber;
        pressure = p0Chamber * (v0Chamber / volume);
        
        time = time + 1;
        Bdistance(time) = distance;
        Bvelocity(time) = velocity;
        Bacceleration(time) = accelNet;
        Bpressure(time) = pressure;
                
    end
    
    plot(Bdistance,Bvelocity,'ok');
    figure
    plot(Bdistance,Bacceleration,'ok');
    figure
    plot(Bdistance,Bpressure,'ok');
   
    % Set the velocity at the end of the barrel as the muzzle velocity
    muzzleVelocity = velocity;
end