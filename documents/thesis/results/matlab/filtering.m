headers = {'time','Velocity, X', 'Velocity, Y', 'Velocity, Z', '\omega_{roll}', '\omega_{pitch}', '\omega_{yaw}', 'Rotor 1', 'Rotor 2', 'Rotor 3', 'Rotor 4', 'Orientation, q^{bw}_{i}', 'Orientation, q^{bw}_{j}', 'Orientation, q^{bw}_{k}', 'Orientation, q^{bw}_{0}', 'Position, X', 'Position, Y', 'Position, Z', 'Gyro bias, roll', 'Gyro bias, pitch', 'Gyro bias, yaw', 'Wind, X', 'Wind, Y', 'Wind, Z'};
units = {'time','m/s','m/s','m/s','rad/s','rad/s','rad/s','rad/s','rad/s','rad/s','rad/s','','','','','m','m','m','rad/s','rad/s','rad/s','m/s','m/s','m/s'};
for i = 2:length(observer.colheaders)
    %%
    figures.getFigure(observer.colheaders{i});clf;
    subplot(2,1,1);
    [h1 h2] = plot_cov(observer, observer.colheaders{i}, i-1, skip);
    if ~any(i == [5:11 22:28])
        h3 = plot(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), 'r');
        rmsval = sqrt(mean((interp1(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), observer.time(1:end-skip), 'cubic', 'extrap')-observer.(observer.colheaders{i})(1:end-skip)).^2));
        external.textbp(['RMS: ' num2str(rmsval)]);
        legend([h1 h2 h3], 'Observer', 'Covariance', 'Ground truth');
    else
        legend([h1 h2], 'Observer', 'Covariance');
    end
    
    m = mean(observer.(observer.colheaders{i})(1:end-skip));
    if any(i-1 == 1:2)
        ylim(m + 3*[-1 1]);
    elseif any(i-1 == 4:6)
        ylim(m + 1*[-1 1]);
    elseif any(i-1 == 15:16)
        ylim(m + 3*[-1 1]);
%     elseif any(i-1 == 7:10)
%         ylim(m + 20*[-1 1]);
    end
    title(headers{i});
    ylabel(units{i});
    subplot(2,1,2);
    plot(observer.time(1:end-skip), squeeze(observer.covariance(i-1,i-1,1:end-skip)), 'g');
    title('Covariance');
end

figures.getFigure('wRoll');
subplot(2,1,1);
hold all; plot(measurements.imu.time(1:end-skip), measurements.imu.wRoll(1:end-skip), 'k');

figures.getFigure('wPitch');
subplot(2,1,1);
hold all; plot(measurements.imu.time(1:end-skip), measurements.imu.wPitch(1:end-skip), 'k');

figures.getFigure('wYaw');
subplot(2,1,1);
hold all; plot(measurements.imu.time(1:end-skip), measurements.imu.wYaw(1:end-skip), 'k');
