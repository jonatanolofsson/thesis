
%% Accelerometers
figures.getFigure('accelerometers');clf;
subplot(3,1,1); plot_sensor('accX', measurements.imu, simulation.imu, skip); title('X'); ylabel('m/s^2'); legend('Measured', 'Predicted');
subplot(3,1,2); plot_sensor('accY', measurements.imu, simulation.imu, skip); title('Y'); ylabel('m/s^2');
subplot(3,1,3); plot_sensor('accZ', measurements.imu, simulation.imu, skip); title('Z'); ylabel('m/s^2'); xlabel('Time');

figures.getFigure('accelerometersresiduals');clf;
subplot(3,1,1); plot_residual('accX', measurements.imu, simulation.imu, skip); title('X'); ylabel('m/s^2');
subplot(3,1,2); plot_residual('accY', measurements.imu, simulation.imu, skip); title('Y'); ylabel('m/s^2');
subplot(3,1,3); plot_residual('accZ', measurements.imu, simulation.imu, skip); title('Z'); ylabel('m/s^2'); xlabel('Time');

figures.getFigure('accelerometersnormalfit');clf;
subplot(3,1,1); fit_to_normal(measurements.imu.accX(1:end-skip) - simulation.imu.accX(1:end-skip)); title('X'); legend('Theoretical fit', 'Numerical density', 'Location', 'Best');
subplot(3,1,2); fit_to_normal(measurements.imu.accY(1:end-skip) - simulation.imu.accY(1:end-skip)); title('Y');
subplot(3,1,3); fit_to_normal(measurements.imu.accZ(1:end-skip) - simulation.imu.accZ(1:end-skip)); title('Z'); xlabel('Time');

%% Gyroscopes
figures.getFigure('gyroscopes');clf;
subplot(3,1,1); plot_sensor('wRoll', measurements.imu, simulation.imu, skip);   title('Roll rate'); ylabel('rad/s'); legend('Measured', 'Predicted', 'Location', 'Best');
subplot(3,1,2); plot_sensor('wPitch', measurements.imu, simulation.imu, skip);  title('Pitch rate'); ylabel('rad/s');
subplot(3,1,3); plot_sensor('wYaw', measurements.imu, simulation.imu, skip);    title('Yaw rate'); ylabel('rad/s'); xlabel('Time');

figures.getFigure('gyroscopesresiduals'); clf;
subplot(3,1,1); plot_residual('wRoll', measurements.imu, simulation.imu, skip);     title('Roll rate'); ylabel('rad/s');
subplot(3,1,2); plot_residual('wPitch', measurements.imu, simulation.imu, skip);    title('Pitch rate'); ylabel('rad/s');
subplot(3,1,3); plot_residual('wYaw', measurements.imu, simulation.imu, skip);      title('Yaw rate'); ylabel('rad/s'); xlabel('Time');

figures.getFigure('gyroscopesnormalfit');clf;
subplot(3,1,1); fit_to_normal(measurements.imu.wRoll(1:end-skip) - simulation.imu.wRoll(1:end-skip));   title('Roll rate'); legend('Theoretical fit', 'Numerical density', 'Location', 'NorthEast');
subplot(3,1,2); fit_to_normal(measurements.imu.wPitch(1:end-skip) - simulation.imu.wPitch(1:end-skip)); title('Pitch rate');
subplot(3,1,3); fit_to_normal(measurements.imu.wYaw(1:end-skip) - simulation.imu.wYaw(1:end-skip));     title('Yaw rate'); xlabel('Time');

%% Pressure sensor
figures.getFigure('pressure');clf;
plot_sensor('Pa', measurements.imu, simulation.imu, skip); xlabel('Time'); ylabel('Pa'); legend('Measured', 'Predicted', 'Location', 'Best');

figures.getFigure('pressureresiduals');clf;
plot_residual('Pa', measurements.imu, simulation.imu, skip); xlabel('Time'); ylabel('Pa');

figures.getFigure('pressurenormalfit');clf;
fit_to_normal(measurements.imu.Pa(1:end-skip) - simulation.imu.Pa(1:end-skip)); legend('Theoretical fit', 'Numerical density', 'Location', 'Best'); xlabel('Time');


%% Camera
figures.getFigure('camera');clf;
subplot(3,2,1); plot_sensor('roll', measurements.camera, simulation.camera, skip);  title('Roll'); ylabel('rad');
subplot(3,2,3); plot_sensor('pitch', measurements.camera, simulation.camera, skip); title('Pitch'); ylabel('rad');
subplot(3,2,5); plot_sensor('yaw', measurements.camera, simulation.camera, skip);   title('Yaw'); ylabel('rad');  xlabel('Time');
subplot(3,2,2); plot_sensor('XPTAM', measurements.camera, simulation.camera, skip); legend('Measured', 'Predicted', 'Location', 'Best'); 
subplot(3,2,4); plot_sensor('YPTAM', measurements.camera, simulation.camera, skip); title('Y'); ylabel('m/scale');
subplot(3,2,6); plot_sensor('ZPTAM', measurements.camera, simulation.camera, skip); title('Z'); ylabel('m/scale'); xlabel('Time');

figures.getFigure('cameraresiduals');clf;
subplot(3,2,1); plot_residual('roll', measurements.camera, simulation.camera, skip);  title('Roll'); ylabel('rad');
subplot(3,2,3); plot_residual('pitch', measurements.camera, simulation.camera, skip); title('Pitch'); ylabel('rad');
subplot(3,2,5); plot_residual('yaw', measurements.camera, simulation.camera, skip);   title('Yaw'); ylabel('rad'); xlabel('Time');
subplot(3,2,2); plot_residual('XPTAM', measurements.camera, simulation.camera, skip); title('X'); ylabel('m/scale');
subplot(3,2,4); plot_residual('YPTAM', measurements.camera, simulation.camera, skip); title('Y'); ylabel('m/scale');
subplot(3,2,6); plot_residual('ZPTAM', measurements.camera, simulation.camera, skip); title('Z'); ylabel('m/scale'); xlabel('Time');

figures.getFigure('cameranormalfit');clf;
subplot(3,2,1); fit_to_normal(measurements.camera.roll(1:end-skip) - simulation.camera.roll(1:end-skip));   title('Roll');
subplot(3,2,3); fit_to_normal(measurements.camera.pitch(1:end-skip) - simulation.camera.pitch(1:end-skip)); title('Pitch');
subplot(3,2,5); fit_to_normal(measurements.camera.yaw(1:end-skip) - simulation.camera.yaw(1:end-skip));     title('Yaw');
subplot(3,2,2); fit_to_normal(measurements.camera.XPTAM(1:end-skip) - simulation.camera.XPTAM(1:end-skip)); title('X'); legend('Theoretical fit', 'Numerical density','Location', 'Best');
subplot(3,2,4); fit_to_normal(measurements.camera.YPTAM(1:end-skip) - simulation.camera.YPTAM(1:end-skip)); title('Y');
subplot(3,2,6); fit_to_normal(measurements.camera.ZPTAM(1:end-skip) - simulation.camera.ZPTAM(1:end-skip)); title('Z'); 