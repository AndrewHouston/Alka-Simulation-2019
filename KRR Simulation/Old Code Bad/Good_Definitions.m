clear,clc

rBarrel = .100;                     %Meters
aBarrel = rBarrel^2 * 3.14;         %Meters^2
lBarrel = 2.3;                      %Meters
cdPiston = 1;                       %Unitless drag
p0Chamber = 10;                     %Atmospheres
p0Chamber = 100000 * p0Chamber;     %Convert pressure to pascals
v0Chamber = 5;                      %Litres
v0Chamber = v0Chamber / 1000;       %Convert volume to cubic meters

rProjectile = 0.015;                %Meters
aProjectile = rProjectile^2 * 3.14; %Meters^2
cdProjectile = 0.04;                %Unitless drag
mProjectile = 1.2;                  %Kilograms
mSled = 0.025;                      %Kilograms
mNet = mProjectile + mSled;         %Kilograms

g = 1;                              %Gees
g = g * 9.81;                       %Meters / Second^2
rho = 1.21;                         %kg/m^3
pAtmosphere = 101325;               %Pascals

timeStep = 0.0001;                  %Seconds

% molarMassCO2 = 44.01;               %Grams/mole
% temp = 295.15;                      %Kelvin
% r = 8.314;                          %J/mol*K
% 
% gasMass = input('How much gas is being generated?: ');
% n = gasMass / molarMassCO2;

long = 39;
d = 2.2;    % 1.746;
n = 1;

for rProjectile = .01:.001:.3
    aProjectile = rProjectile^2 * 3.14;
    mProjectile = aProjectile * long * d;
    mNet = mProjectile + mSled;
    radius(n) = rProjectile;
    muzzleVelocity(n) = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep);
    altitudeMax(n) = good_External(aProjectile,cdProjectile,mProjectile,rho,g,muzzleVelocity(n),lBarrel,timeStep);
    n = n + 1;
end

plot(radius,muzzleVelocity)
hold on
plot(radius,altitudeMax)
% muzzleVelocity = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep)
% altitudeMax = good_External(aProjectile,cdProjectile,mProjectile,rho,g,muzzleVelocity,lBarrel,timeStep)

% for n = 1:1:200
%     p0Chamber = n / 20 + 7.95;
%     p0Chamber = 101325 * p0Chamber;
%     muzzleVelocity(n) = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep);
% end