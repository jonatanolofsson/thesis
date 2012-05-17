%% 
close all;
figures = Figures();

plot_camera = true;
plot_imu = true;

%% Import data
if plot_imu
    measurements.imu = Files.import('imu_measured.log');
    simulation.imu = Files.import('imu_simulated.log');
end
if plot_camera
    measurements.camera = Files.import('camera_measured.log');
    measurements.camera.roll   = Quaternion.toRoll(measurements.camera.qPTAM0, measurements.camera.qPTAMi, measurements.camera.qPTAMj, measurements.camera.qPTAMk);
    measurements.camera.pitch  = Quaternion.toPitch(measurements.camera.qPTAM0, measurements.camera.qPTAMi, measurements.camera.qPTAMj, measurements.camera.qPTAMk);
    measurements.camera.yaw    = Quaternion.toYaw(measurements.camera.qPTAM0, measurements.camera.qPTAMi, measurements.camera.qPTAMj, measurements.camera.qPTAMk);
    simulation.camera = Files.import('camera_simulated.log');
    simulation.camera.roll   = Quaternion.toRoll(simulation.camera.qPTAM0, simulation.camera.qPTAMi, simulation.camera.qPTAMj, simulation.camera.qPTAMk);
    simulation.camera.pitch  = Quaternion.toPitch(simulation.camera.qPTAM0, simulation.camera.qPTAMi, simulation.camera.qPTAMj, simulation.camera.qPTAMk);
    simulation.camera.yaw    = Quaternion.toYaw(simulation.camera.qPTAM0, simulation.camera.qPTAMi, simulation.camera.qPTAMj, simulation.camera.qPTAMk);
end

observer = Files.import('observer.log');
observer.roll   = Quaternion.toRoll(observer.qwb0, observer.qwbi, observer.qwbj, observer.qwbk);
observer.pitch  = Quaternion.toPitch(observer.qwb0, observer.qwbi, observer.qwbj, observer.qwbk);
observer.yaw    = Quaternion.toYaw(observer.qwb0, observer.qwbi, observer.qwbj, observer.qwbk);

observer.covariance = Files.importMatrix('covariance.log');
reality = Files.import('reality.log');
reality.roll    = Quaternion.toRoll(reality.qwb0, reality.qwbi, reality.qwbj, reality.qwbk);
reality.pitch   = Quaternion.toPitch(reality.qwb0, reality.qwbi, reality.qwbj, reality.qwbk);
reality.yaw     = Quaternion.toYaw(reality.qwb0, reality.qwbi, reality.qwbj, reality.qwbk);

%% State estimation
figures.getFigure('Positioning');

% Position
subplot(4,3,1); plot(observer.time, observer.X, 'b', reality.time, reality.X, 'r'); title('Position, X');
subplot(4,3,2); plot(observer.time, observer.Y, 'b', reality.time, reality.Y, 'r'); title('Position, Y');
subplot(4,3,3); plot(observer.time, observer.Z, 'b', reality.time, reality.Z, 'r'); title('Position, Z');

% Velocity
subplot(4,3,4); plot(observer.time, observer.velX, 'b', reality.time, reality.velX, 'r'); title('Velocity, X');
subplot(4,3,5); plot(observer.time, observer.velY, 'b', reality.time, reality.velY, 'r'); title('Velocity, Y');
subplot(4,3,6); plot(observer.time, observer.velZ, 'b', reality.time, reality.velZ, 'r'); title('Velocity, Z');

% Angle
subplot(4,3,7); plot(observer.time, observer.roll, 'b', reality.time, reality.roll, 'r'); title('Roll');
subplot(4,3,8); plot(observer.time, observer.pitch, 'b', reality.time, reality.pitch, 'r'); title('Pitch');
subplot(4,3,9); plot(observer.time, observer.yaw, 'b', reality.time, reality.yaw, 'r'); title('Yaw');

% Angular velocity
subplot(4,3,10); plot(observer.time, observer.wRoll, 'b', reality.time, reality.wRoll, 'r'); title('\omega_{roll}');
subplot(4,3,11); plot(observer.time, observer.wPitch, 'b', reality.time, reality.wPitch, 'r'); title('\omega_{pitch}');
subplot(4,3,12); plot(observer.time, observer.wYaw, 'b', reality.time, reality.wYaw, 'r'); title('\omega_{yaw}');


%% IMU
if plot_imu
    figures.getFigure('IMU');

    % Accelerometer
    subplot(3,3,1); plot(measurements.imu.time, measurements.imu.accX, 'b', simulation.imu.time, simulation.imu.accX, 'r'); title('Accelerometer, X');
    subplot(3,3,2); plot(measurements.imu.time, measurements.imu.accY, 'b', simulation.imu.time, simulation.imu.accY, 'r'); title('Accelerometer, Y');
    subplot(3,3,3); plot(measurements.imu.time, measurements.imu.accZ, 'b', simulation.imu.time, simulation.imu.accZ, 'r'); title('Accelerometer, Z');

    % Gyroscope
    subplot(3,3,4); plot(measurements.imu.time, measurements.imu.wRoll, 'b', simulation.imu.time, simulation.imu.wRoll, 'r'); title('Gyroscope, roll');
    subplot(3,3,5); plot(measurements.imu.time, measurements.imu.wPitch, 'b', simulation.imu.time, simulation.imu.wPitch, 'r'); title('Gyroscope, pitch');
    subplot(3,3,6); plot(measurements.imu.time, measurements.imu.wYaw, 'b', simulation.imu.time, simulation.imu.wYaw, 'r'); title('Gyroscope, yaw');

    % Presssure sensor
    subplot(3,3,7:9); plot(measurements.imu.time, measurements.imu.Pa, 'b', simulation.imu.time, simulation.imu.Pa, 'r'); title('Pressure');
end

%% Camera
if plot_camera
    figures.getFigure('Camera');

    % Position
    subplot(2,3,1); plot(measurements.camera.time, measurements.camera.XPTAM, 'b', simulation.camera.time, simulation.camera.XPTAM, 'r'); title('XPTAM, X');
    subplot(2,3,2); plot(measurements.camera.time, measurements.camera.YPTAM, 'b', simulation.camera.time, simulation.camera.YPTAM, 'r'); title('XPTAM, Y');
    subplot(2,3,3); plot(measurements.camera.time, measurements.camera.ZPTAM, 'b', simulation.camera.time, simulation.camera.ZPTAM, 'r'); title('XPTAM, Z');

    % Orientation
    subplot(2,3,4); plot(measurements.camera.time, measurements.camera.roll, 'b', simulation.camera.time, simulation.camera.roll, 'r'); title('Orientation, roll');
    subplot(2,3,5); plot(measurements.camera.time, measurements.camera.pitch, 'b', simulation.camera.time, simulation.camera.pitch, 'r'); title('Orientation, pitch');
    subplot(2,3,6); plot(measurements.camera.time, measurements.camera.yaw, 'b', simulation.camera.time, simulation.camera.yaw, 'r'); title('Orientation, yaw');
end

%%
covfigures = Figures();
skip = 30;
for i = 2:length(observer.colheaders)
    %%
    covfigures.getFigure(observer.colheaders{i});clf;
    subplot(2,1,1);
    plot_cov(observer, observer.colheaders{i}, i-1, skip);
    if ~any(i == [8:11 22:28])
        plot(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), 'r');
        rmsval = sqrt(mean((interp1(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), observer.time(1:end-skip), 'cubic', 'extrap')-observer.(observer.colheaders{i})(1:end-skip)).^2));
        external.textbp(['RMS: ' num2str(rmsval)]);
    end
    title(observer.colheaders{i});
    subplot(2,1,2);
    plot(observer.time(1:end-skip), squeeze(observer.covariance(i-1,i-1,1:end-skip)), 'g');
end

if plot_imu
    covfigures.getFigure('wRoll');
    subplot(2,1,1);
    hold all; plot(measurements.imu.time(1:end-skip), measurements.imu.wRoll(1:end-skip), 'k');

    covfigures.getFigure('wPitch');
    subplot(2,1,1);
    hold all; plot(measurements.imu.time(1:end-skip), measurements.imu.wPitch(1:end-skip), 'k');

    covfigures.getFigure('wYaw');
    subplot(2,1,1);
    hold all; plot(measurements.imu.time(1:end-skip), measurements.imu.wYaw(1:end-skip), 'k');
end

covfigures.toPDF('covariance.pdf');
covfigures.closeAll();


%% Residuals
residuals = Figures();
residuals.getFigure('accelerometerresiduals');
subplot(3,1,1); fit_to_normal(measurements.imu.accX - simulation.imu.accX);
title('Accelerometer residuals');
subplot(3,1,2); fit_to_normal(measurements.imu.accY - simulation.imu.accY);
subplot(3,1,3); fit_to_normal(measurements.imu.accZ - simulation.imu.accZ);

residuals.getFigure('gyroscoperesiduals');
subplot(3,1,1); fit_to_normal(measurements.imu.wRoll - simulation.imu.wRoll);
title('Gyroscope residuals');
subplot(3,1,2); fit_to_normal(measurements.imu.wPitch - simulation.imu.wPitch);
subplot(3,1,3); fit_to_normal(measurements.imu.wYaw - simulation.imu.wYaw);

residuals.getFigure('pressureresiduals');
fit_to_normal(measurements.imu.Pa - simulation.imu.Pa);
title('Pressure sensor residuals');

residuals.getFigure('cameraorientationresiduals');
subplot(3,1,1); fit_to_normal(measurements.camera.roll - simulation.camera.roll);
title('Camera orientation residuals');
subplot(3,1,2); fit_to_normal(measurements.camera.pitch - simulation.camera.pitch);
subplot(3,1,3); fit_to_normal(measurements.camera.yaw - simulation.camera.yaw);

residuals.getFigure('camerapositionresiduals');
subplot(3,1,1); fit_to_normal(measurements.camera.XPTAM - simulation.camera.XPTAM);
title('Camera position residuals');
subplot(3,1,2); fit_to_normal(measurements.camera.YPTAM - simulation.camera.YPTAM);
subplot(3,1,3); fit_to_normal(measurements.camera.ZPTAM - simulation.camera.ZPTAM);


residuals.toPDF('residuals.pdf');
residuals.closeAll();