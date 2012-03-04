% Linkquad linear dynamic model
% FOR HOVERING CONDITION ONLY

%     dx/dt = A*x(t) + B*u_quad(t)
%      y(t) = C*x(t) 

% state vector x = [u v w phi theta p q r T1 T2 T3 T4]'
%      u,v,w = body axis velocities [m/s]
%      phi,theta = roll and pitch angle [deg]
%      p,q,r = roll, pitch and yaw rate [deg/s]
%      T1, T2, T3, T4 = incremental thrust around hovering condition for each rotor

% input vector u_quad = [roll pitch rud thr]'

function [m] = linkquadDyn

g   = 9.81;         %Gravity constant
m   = 1.2;          %Mass [kg]
Ixx = 0.009561;     %Moment of inertia around the x-body axis [kg*m^2]
Iyy = 0.009855;     %Moment of inertia around the y-body axis
Izz = 0.0152;       %Moment of inertia around the z-body axis
l   = 0.215;        %Horizontal dispacement for each rotor centre to COG [meter]
T0  = g*m/4;        %Thrust needed for hover for a single rotor [N]
Am  = -9.55749;     %The A-value from the motor identification  dT/dt = Am*T(t) + Bm*u_eng(t)
Bm  = 6*10^7*10^-6; %8.49*10^7*10^-6; %The B-value from the motor identification
a   = 1.4517*10^-5*(2*pi/60)^2; %Propeller thrust constant T = a*omega^2
d   = 2.93*10^-9;   % Propeller drag constant Q = d*omega^2
Iprop = 2.4*10^-6;  % Propeller moment of inertia
omega0 = sqrt(T0/a);% Propeller RPM at hover

k1 = d/(a*Izz) + (Am*Iprop/(2*a*omega0*Izz));
k2 = Iprop*Bm/Izz;
k3 = 2*Bm*sqrt(a*T0);

% Aerodynamic derivatives
Kuu = -0.1;
Kvv = -0.1;
Kww = -0.2;
Kuq = 6;
Kvp = -6;
Kpp = -3;
Kqq = -3;

% Channel mixer
MIX = [0  1  0 -1;...
      -1  0  1  0;...
       1 -1  1 -1;...
       1  1  1  1];
    
MIX_INV = inv(MIX);

NOR = [2 0 0 0;...
         0 2 0 0;...
         0 0 4 0;...
         0 0 0 4];

A = [... 
       Kuu  0   0   0   -g   0   0   0   0   0   0   0;...       %u
        0  Kvv  0   g    0   0   0   0   0   0   0   0;...       %v
        0   0   Kww 0    0   0   0   0 1/m 1/m 1/m 1/m;...       %w
        0   0   0   0    0   1   0   0   0   0   0   0;...       %phi
        0   0   0   0    0   0   1   0   0   0   0   0;...       %theta
        0  Kvp  0   0    0  Kpp  0   0   0 -l/Ixx 0 l/Ixx;...    %p
       Kuq  0   0   0    0   0  Kqq  0 l/Iyy 0 -l/Iyy 0;...      %q
        0   0   0   0    0   0   0   0  -k1  k1  -k1 k1;...      %r
        0   0   0   0    0   0   0   0   Am  0   0   0;...       %T1
        0   0   0   0    0   0   0   0   0   Am  0   0;...       %T2
        0   0   0   0    0   0   0   0   0   0   Am  0;...       %T3
        0   0   0   0    0   0   0   0   0   0   0   Am];        %T4
        
  
B = [...
        0   0   0   0;...
        0   0   0   0;...
        0   0   0   0;...
        0   0   0   0;...
        0   0   0   0;...
        0   0   0   0;...
        0   0   0   0;...
       -k2  k2 -k2  k2;...
        k3  0   0   0;...
        0   k3  0   0;...
        0   0   k3  0;...
        0   0   0   k3];

    
B = B*MIX_INV*NOR;    
C = eye(8,12);
rad2deg = 180/pi;
C(4,4) = rad2deg;
C(5,5) = rad2deg;
C(6,6) = rad2deg;
C(7,7) = rad2deg;
C(8,8) = rad2deg;
D = zeros(8,4);
m = ss(A,B,C,D);
