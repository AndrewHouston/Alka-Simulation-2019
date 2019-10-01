%Constants we are using, T is arbritrary
R= 8.314;         %J/mol
T=294.3;          %Kelvin
%Calculations for PV Constant
n= 30 / 44.0095;
P = 689476;
V=(n*R*T)/P;
PV = P * V;
p0Chamber = 689476;
v0Chamber = V;
for h = 1:1:10
    velocity = 0;
    distance = 0;
    time = 0;
    pressure = p0Chamber;
    while distance < lBarrel
  %     time = time + timeStep;                                         % Increment the time by the timestep, not used currently 
        % Calculate the various components of the acceleration vector then combine them
        accel = pressure * aBarrel / mNet;                              % Acceleration is force times area divided by mass
        accelDrag = -0.5 * rho * aBarrel * cdPiston * velocity / mNet;  % Drag equation with assumed coefficiant of friction for the sled
        accelAtmosphere = -pAtmosphere * aBarrel / mNet;                % Account for pressure of the atmosphere
        accelNet = accel + accelDrag + accelAtmosphere;                 % Sum up all the accelerations to come up with a net value
        
        % Use LRAM to estimate the current velocity and position
        velocity = velocity + accelNet * timeStep;
        distance = distance + velocity * timeStep;
        
        % Determine the updated chamber volume and pressure
        volume = aBarrel * distance + v0Chamber;
        pressure = p0Chamber * (v0Chamber / volume);
   end
    
    % Set the velocity at the end of the barrel as the muzzle velocity
    muzzleVelocity(h) = velocity;
    
   p0Chamber = p0Chamber + 137895;
   v0Chamber = PV / p0Chamber;
end
