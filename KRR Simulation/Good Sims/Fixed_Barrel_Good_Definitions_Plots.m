clear,clc
for i = 1:1:1000                    %Initialize the for loop
    rBarrel = i * 0.0001 + 0.000124;      %Meters, converted to the minimum radius requested
    aBarrel = rBarrel^2 * 3.14;         %Meters^2
    lBarrel = 2.3;                      %Meters
    cdPiston = 1;                       %Unitless drag
    p0Chamber = 100;                     %Atmospheres
    p0Chamber = 101325 * p0Chamber;     %Convert pressure to pascals
    v0Chamber = 2.264*10^-4;                      %Litres
    v0Chamber = v0Chamber / 1000;       %Convert volume to cubic meters

    rProjectile = 0.015;                %Meters
    aProjectile = rProjectile^2 * 3.14; %Meters^2
    cdProjectile = 0.04;                %Unitless drag
    mProjectile = .4;                  %Kilograms
    mSled = 0.025;                      %Kilograms
    mNet = mProjectile + mSled;         %Kilograms



    g = 1;                              %Gees
    g = g * 9.81;                       %Meters / Second^2
    rho = 1.21;                         %kg/m^3
    pAtmosphere = 101325;               %Pascals

    timeStep = 0.0001;                  %Seconds



    muzzleVelocity(i) = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep);
    altitudeMax(i) = good_External(aProjectile,cdProjectile,mProjectile,rho,g,muzzleVelocity(i),lBarrel,timeStep);
    
    math(i) = rBarrel * 100;
end

plot(math, altitudeMax)
xlabel('Barrel Radius (Centimeters)')
ylabel('Maximum Height of Rocket')
title('Changing Barrel Radius affect on Height')







