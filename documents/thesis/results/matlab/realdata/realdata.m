% addpath('/home/shared/projects/mattools', '/home/jonatan/skola/texciv/matlab');
if ~exist('figures', 'var')
    figures = Figures();
else
    figures.closeAll();
end

skipsec = 3/20;

%% Import data
measurements.imu = Files.import('imu_measured.log');
simulation.imu = Files.import('imu_simulated.log');

measurements.camera = Files.import('camera_measured.log');
measurements.camera.roll   = Quaternion.toRoll(measurements.camera.qPTAM0, measurements.camera.qPTAMi, measurements.camera.qPTAMj, measurements.camera.qPTAMk);
measurements.camera.pitch  = Quaternion.toPitch(measurements.camera.qPTAM0, measurements.camera.qPTAMi, measurements.camera.qPTAMj, measurements.camera.qPTAMk);
measurements.camera.yaw    = Quaternion.toYaw(measurements.camera.qPTAM0, measurements.camera.qPTAMi, measurements.camera.qPTAMj, measurements.camera.qPTAMk);
simulation.camera = Files.import('camera_simulated.log');
simulation.camera.roll   = Quaternion.toRoll(simulation.camera.qPTAM0, simulation.camera.qPTAMi, simulation.camera.qPTAMj, simulation.camera.qPTAMk);
simulation.camera.pitch  = Quaternion.toPitch(simulation.camera.qPTAM0, simulation.camera.qPTAMi, simulation.camera.qPTAMj, simulation.camera.qPTAMk);
simulation.camera.yaw    = Quaternion.toYaw(simulation.camera.qPTAM0, simulation.camera.qPTAMi, simulation.camera.qPTAMj, simulation.camera.qPTAMk);


observer = Files.import('observer.log');
observer.roll   = Quaternion.toRoll(observer.qwb0, observer.qwbi, observer.qwbj, observer.qwbk);
observer.pitch  = Quaternion.toPitch(observer.qwb0, observer.qwbi, observer.qwbj, observer.qwbk);
observer.yaw    = Quaternion.toYaw(observer.qwb0, observer.qwbi, observer.qwbj, observer.qwbk);

observer.covariance = Files.importMatrix('covariance.log');
reality = Files.import('reality.log');
reality.roll    = Quaternion.toRoll(reality.qwb0, reality.qwbi, reality.qwbj, reality.qwbk);
reality.pitch   = Quaternion.toPitch(reality.qwb0, reality.qwbi, reality.qwbj, reality.qwbk);
reality.yaw     = Quaternion.toYaw(reality.qwb0, reality.qwbi, reality.qwbj, reality.qwbk);

% measurements.imu.time = measurements.imu.time/2;
% measurements.camera.time = measurements.camera.time/2;
% simulation.imu.time = simulation.imu.time/2;
% simulation.camera.time = simulation.camera.time/2;
% observer.time = observer.time/2;
% reality.time = reality.time/2;

raw = Files.import('data.log');

%%
% angle_unit = 'rad';
angle_unit = 'deg';
if strcmp(angle_unit, 'deg')
    reality.roll        = reality.roll * 180/pi;
    reality.pitch       = reality.pitch * 180/pi;
    reality.yaw         = reality.yaw * 180/pi;
    observer.roll       = observer.roll * 180/pi;
    observer.pitch      = observer.pitch * 180/pi;
    observer.yaw        = observer.yaw * 180/pi;
    measurements.camera.roll   = measurements.camera.roll * 180/pi;
    measurements.camera.pitch  = measurements.camera.pitch * 180/pi;
    measurements.camera.yaw    = measurements.camera.yaw * 180/pi;
    simulation.camera.roll     = simulation.camera.roll * 180/pi;
    simulation.camera.pitch    = simulation.camera.pitch * 180/pi;
    simulation.camera.yaw      = simulation.camera.yaw * 180/pi;

    reality.wRoll            = reality.wRoll * 180/pi;
    reality.wPitch           = reality.wPitch * 180/pi;
    reality.wYaw             = reality.wYaw * 180/pi;
    
    reality.driftRoll        = reality.driftRoll * 180/pi;
    reality.driftPitch       = reality.driftPitch * 180/pi;
    reality.driftYaw         = reality.driftYaw * 180/pi;
    
    observer.wRoll           = observer.wRoll * 180/pi;
    observer.wPitch          = observer.wPitch * 180/pi;
    observer.wYaw            = observer.wYaw * 180/pi;
    observer.driftRoll       = observer.driftRoll * 180/pi;
    observer.driftPitch      = observer.driftPitch * 180/pi;
    observer.driftYaw        = observer.driftYaw * 180/pi;
    measurements.imu.wRoll   = measurements.imu.wRoll * 180/pi;
    measurements.imu.wPitch  = measurements.imu.wPitch * 180/pi;
    measurements.imu.wYaw    = measurements.imu.wYaw * 180/pi;
    simulation.imu.wRoll     = simulation.imu.wRoll * 180/pi;
    simulation.imu.wPitch    = simulation.imu.wPitch * 180/pi;
    simulation.imu.wYaw      = simulation.imu.wYaw * 180/pi;

    observer.covariance(4,4,:) = observer.covariance(4,4,:)*((180/pi)^2);
    observer.covariance(5,5,:) = observer.covariance(5,5,:)*((180/pi)^2);
    observer.covariance(6,6,:) = observer.covariance(6,6,:)*((180/pi)^2);
end
%%
sensors
filtering

%%
% A = [0.941844 0.320703  -0.1004;
% -0.324889   0.945334 -0.0281195;
% 0.0858934 0.059103  0.99455]';

A = [-0.324889   0.945334 -0.0281195;
0.941844 0.320703  -0.1004;
-0.0858934 -0.059103  -0.99455]';

E = eye(3);
figures.getFigure('camerainitframe');clf;
draw_coordinate_system(A);
draw_coordinate_system(E);
xlabel('X'); ylabel('Y'); zlabel('Z');
text(1.1,0,0,'X'); text(0,1.1,0,'Y'); text(0,0,1.1,'Z');
text('Position', 1.1*A(1,:), 'String', 'x^{PTAM}');
text('Position', 1.1*A(2,:), 'String', 'y^{PTAM}');
text('Position', 1.1*A(3,:), 'String', 'z^{PTAM}');
view([120 25]);
set(gca,'XDir','reverse'); set(gca,'ZDir','reverse');