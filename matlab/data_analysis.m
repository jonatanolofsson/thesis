%% Accelerometer
figure(1);clf;
IND = 6000:10000;
subplot(3,1,1);
plot(s_accel_x_raw, 'b'); hold all;
data = s_accel_x_raw(IND);
plot(IND, data, 'r');
var(data * 0.00982331)

subplot(3,1,2)
plot(s_accel_y_raw, 'b'); hold all;
data = s_accel_y_raw(IND);
plot(IND, data, 'r');
var(data * 0.00982331)

subplot(3,1,3)
plot(s_accel_z_raw, 'b'); hold all;
data = s_accel_z_raw(IND);
plot(IND, data, 'r');
var(data * 0.00982331)

%% Gyro
figure(2);clf;
IND = 6000:10000;
subplot(3,1,1);
plot(s_phi_dot, 'b'); hold all;
data = s_phi_dot(IND) * 0.0174533;
plot(IND, data, 'r');
var(data)

subplot(3,1,2)
plot(s_theta_dot, 'b'); hold all;
data = s_theta_dot(IND) * 0.0174533;
plot(IND, data, 'r');
var(data)

subplot(3,1,3)
plot(s_psi_dot, 'b'); hold all;
data = s_psi_dot(IND) * 0.0174533;
plot(IND, data, 'r');
var(data)

%% Pressure
figure(3);clf;
IND = 1:6000;
plot(s_pressure_hp, 'b'); hold all;
data = s_pressure_hp(IND);
plot(IND, data, 'r');
var(data * 1000)

%% 
figure(4);clf;
plot(s_psi_dot*pi/180, 'b');
hold all;
plot([0 diff(c_state_heading)'], 'r');