dir = '/home/noenc-jonatan/workspace/data/2012-05-11/30Hz/gt2/';
data = Files.import([dir 'data.log']);
figures = Figures();

%% Accelerometers
figures.getFigure('Accelerometers');
subplot(3,1,1);
fit_to_normal(data.s_accel_x_raw * 0.00982331);
subplot(3,1,2);
fit_to_normal(data.s_accel_y_raw * 0.00982331);
subplot(3,1,3);
fit_to_normal(data.s_accel_z_raw * 0.00982331);

%% Gyroscopes
figures.getFigure('Gyroscopes');
subplot(3,1,1);
fit_to_normal(data.s_phi_dot * 0.01745329252);
subplot(3,1,2);
fit_to_normal(data.s_theta_dot * 0.01745329252);
subplot(3,1,3);
fit_to_normal(data.s_psi_dot * 0.01745329252);

%% Pressure
figures.getFigure('Pressure');
fit_to_normal(data.s_pressure_hp * 1000);