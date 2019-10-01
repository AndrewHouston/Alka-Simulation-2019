function [altitudeMax] = good_External(aProjectile,cdProjectile,mProjectile,rho,g,muzzleVelocity,lBarrel,timeStep)
    altitude = lBarrel;
    velocity = muzzleVelocity;
    time = 0;
    while velocity > 0
        % time = time + timeStep;                                                   % Increment the time by the timestep, not used currently
        acceleration = -g -0.5 * rho * aProjectile * cdProjectile * velocity^2;     % G + drag equation using an assumed drag coefficient
        velocity = velocity + acceleration * timeStep / mProjectile;                % Calculate the new velocity using LRAM
        altitude = altitude + velocity * timeStep;                                  % Calculate the new altitude with LRAM
    end
    altitudeMax = altitude;
end
