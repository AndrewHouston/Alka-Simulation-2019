clear,clc
for i = 1:1:1000                   %Initialize the for loop
rBarrel = i * 0.0001 + 0.0124;      %Meters, converted to the minimum radius requested
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

muzzleVelocity(i) = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep);
altitudeMax(i) = good_External(aProjectile,cdProjectile,mProjectile,rho,g,muzzleVelocity(i),lBarrel,timeStep);

% for n = 1:1:200
%     p0Chamber = n / 20 + 7.95;
%     p0Chamber = 101325 * p0Chamber;
%     muzzleVelocity(n) = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep);
% end
end
subplot(2,1,1)
yyaxis left
plot(1:1:1000,muzzleVelocity)
xlabel('Iteration of the For-Loop')
ylabel('Muzzle Velocity [m/s]')
hold on
yyaxis right
plot(1:1:1000,altitudeMax)
ylabel('Altitude Max [m]')
title('Changing Barrel Radius and the Impacts on Altitude and Muzzle Velocity')
hold on
plot(660,1:1:1000,'.k')

%Iteration 660 gives the maximum Muzzle Velocity and Altitude, so Optimal
%Barrel radius should be 0.0784 m, 78.4 mm. Diameter would be 0.1568 m or
%156.8 mm

long = 39;
d = 2.2;    % 1.746;
n = 1;
rBarrel = 0.0784;
aBarrel = rBarrel^2 * 3.14;         %Meters^2

for rProjectile = .01:.001:.3
    aProjectile = rProjectile^2 * 3.14;
    mProjectile = aProjectile * long * d;
    mNet = mProjectile + mSled;
    radius(n) = rProjectile;
    MUzzleVelocity(n) = good_Internal(aBarrel,lBarrel,cdPiston,mNet,g,rho,p0Chamber,pAtmosphere,v0Chamber,timeStep);
    ALtitudeMax(n) = good_External(aProjectile,cdProjectile,mProjectile,rho,g,MUzzleVelocity(n),lBarrel,timeStep);
    n = n + 1;
end
subplot(2,1,2)
yyaxis left
plot(radius,MUzzleVelocity)
xlabel('radius')
ylabel('Muzzle Velocity')
hold on
yyaxis right
plot(radius,ALtitudeMax)
ylabel('Altitude Max')
title('Changing Rocket Radius and the impact on Muzzle Velocity and Altitude')