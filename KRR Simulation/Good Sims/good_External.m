function [altitudeMax] = good_External(aProjectile,cdProjectile,mProjectile,rho,g,muzzleVelocity,lBarrel,timeStep)
    altitude = lBarrel;
    velocity = muzzleVelocity;
    time = 0;
    while velocity > 0
        % time = time + timeStep;                                                   % Increment the time by the timestep, not used currently
        acceleration = -g + (-0.5 * rho * aProjectile * cdProjectile * velocity^2 / mProjectile);     % G + drag equation using an assumed drag coefficient
        velocity = velocity + acceleration * timeStep;             % Calculate the new velocity using LRAM
        altitude = altitude + velocity * timeStep;       % Calculate the new altitude with LRAM
    
        time = time + 1;
        TimeCount(time) = time;
        Aaltitude(time) = altitude;
        Avelocity(time) = velocity;
        Aacceleration(time) = acceleration;
        
    end
    
    altitudeMax = altitude;
    
    figure
    plot(TimeCount*timeStep,Aaltitude,'*');
    figure
    plot(TimeCount,Avelocity,'*');
    figure
    plot(TimeCount,Aacceleration,'*');
    
end
