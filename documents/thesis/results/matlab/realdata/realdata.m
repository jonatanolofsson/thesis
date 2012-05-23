% addpath('/home/shared/projects/mattools', '/home/jonatan/skola/texciv/matlab');
if ~exist('figures', 'var')
    figures = Figures();
else
    figures.closeAll();
end

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

measurements.imu.time = measurements.imu.time/2;
measurements.camera.time = measurements.camera.time/2;
simulation.imu.time = simulation.imu.time/2;
simulation.camera.time = simulation.camera.time/2;
observer.time = observer.time/2;
reality.time = reality.time/2;

raw = Files.import('data.log');

reality.time(980) = reality.time(980)+0.0001;
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