
if strcmp(angle_unit, 'rad')
    conversion = pi/180;
else 
    conversion = 1;
end

headers = {'time','Velocity, X', 'Velocity, Y', 'Velocity, Z', 'Roll rate', 'Pitch rate', 'Yaw rate', 'Rotor 1', 'Rotor 2', 'Rotor 3', 'Rotor 4', 'Orientation, q^{bw}_{i}', 'Orientation, q^{bw}_{j}', 'Orientation, q^{bw}_{k}', 'Orientation, q^{bw}_{0}', 'Position, X', 'Position, Y', 'Position, Z', 'Gyro bias, roll', 'Gyro bias, pitch', 'Gyro bias, yaw', 'Wind, X', 'Wind, Y', 'Wind, Z'};
units = {'time','m/s','m/s','m/s',[angle_unit '/s'],[angle_unit '/s'],[angle_unit '/s'],'rad/s','rad/s','rad/s','rad/s','','','','','m','m','m',[angle_unit '/s'],[angle_unit '/s'],[angle_unit '/s'],'m/s','m/s','m/s'};
skip = floor(length(observer.time)*skipsec);
for i = 2:length(observer.colheaders)
    %%
    figures.getFigure(observer.colheaders{i});clf;
    subplot(3,1,[1 2]);
    [h1 h2] = plot_cov(observer, observer.colheaders{i}, i-1, skip);
    if ~any(i == [5:11 22:28])
        h3 = plot(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), 'r');
        rmsval = sqrt(mean((interp1(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), observer.time(1:end-skip), 'cubic', 'extrap')-observer.(observer.colheaders{i})(1:end-skip)).^2));
        external.textbp(['RMS: ' num2str(rmsval)]);
        if i == 18
            t = (raw.s_time-raw.s_time(1))/(raw.s_time(end)-raw.s_time(1)) * max(observer.time);
            skip2 = floor(length(t)*skipsec);
            hold all; 
            h4 = plot(t(1:end-skip2), -(raw.s_alt_cf(1:end-skip2)-raw.s_alt_cf(1))+observer.Z(1), 'k');
            legend([h1 h2 h3 h4], 'Observer', 'Covariance', 'Ground truth', 'Complementary filter');
        else
            legend([h1 h2 h3], 'Observer', 'Covariance', 'Ground truth');
        end
    elseif any(i == [5:7])
        hold all; h3 = plot(measurements.imu.time(1:end-skip), measurements.imu.(observer.colheaders{i})(1:end-skip), 'k');
        legend([h1 h2 h3], 'Observer', 'Covariance', 'Gyroscope');
    else
        legend([h1 h2], 'Observer', 'Covariance');
    end
    
    m = mean(observer.(observer.colheaders{i})(1:end-skip));
    if any(i-1 == 1:2)
        ylim(m + 3*[-1 1]);
    elseif any(i-1 == 4:6)
        ylim(m + conversion*[-1 1]*180/pi);
%     elseif any(i-1 == 15:16)
%         ylim(m + 3*[-1 1]);
%     elseif any(i-1 == 7:10)
%         ylim(m + 20*[-1 1]);
    end
    title(headers{i});
    ylabel(units{i});
    subplot(3,1,3);
    plot(observer.time(1:end-skip), squeeze(observer.covariance(i-1,i-1,1:end-skip)), 'g');
    ylabel(['(' units{i} ')^2']);
    xlabel('Time');
    title('Covariance');
end

%% Heading comparison
figures.getFigure('headings');clf;
skip = floor(length(observer.time)*skipsec);
h1 = plot(observer.time(1:end-skip), observer.yaw(1:end-skip), 'b');
hold all;
skip = floor(length(reality.time)*skipsec);
h2 = plot(reality.time(1:end-skip), reality.yaw(1:end-skip), 'r');
t = (raw.s_time-raw.s_time(1))/(raw.s_time(end)-raw.s_time(1)) * max(observer.time);
skip = floor(length(t)*skipsec);
h3 = plot(t(1:end-skip), (raw.s_heading_cf(1:end-skip)-raw.s_heading_cf(1))*conversion+observer.yaw(1), 'g');
legend([h1 h2 h3], 'Observer', 'Ground truth', 'Complementary filter');
xlabel('Time');
ylabel(angle_unit);
title('Heading comparison')