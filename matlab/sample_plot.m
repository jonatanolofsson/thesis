A = load('../data/initial_sampling1');
t = 1/500:1/500:19807/500;
%% Acceleration
figure(1);clf;
for i = 1:3
    subplot(3,1,i);
    plot(t, A(:, i+3));
    ylabel('[m/s^2]')
end
xlabel('t [s]');
subplot(3,1,1);
title('Acceleration');
%% Gyro
figure(2);clf;
for i = 1:3
    subplot(3,1,i);
    plot(t, A(:, i+6));
    ylabel('[rad/s]')
end
xlabel('t [s]');
subplot(3,1,1);
title('Gyro');