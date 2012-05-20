headers = {'time','Velocity, X', 'Velocity, Y', 'Velocity, Z', '\omega_{roll}', '\omega_{pitch}', '\omega_{yaw}', 'Rotor 1', 'Rotor 2', 'Rotor 3', 'Rotor 4', 'Orientation, q^{bw}_{i}', 'Orientation, q^{bw}_{j}', 'Orientation, q^{bw}_{k}', 'Orientation, q^{bw}_{0}', 'Position, X', 'Position, Y', 'Position, Z', 'Gyro bias, roll', 'Gyro bias, pitch', 'Gyro bias, yaw', 'Wind, X', 'Wind, Y', 'Wind, Z'};
units = {'time','m/s','m/s','m/s','rad/s','rad/s','rad/s','rad/s','rad/s','rad/s','rad/s','','','','','m','m','m','rad/s','rad/s','rad/s','m/s','m/s','m/s'};
observer        = Files.import('observer.log');
reality         = Files.import('reality.log');

observer.covariance = Files.importMatrix('covariance.log');

if ~exist('figures', 'var')
    figures = Figures();
end


%%
skip = 0;
for i = [22:24]
    figures.getFigure(['sim' observer.colheaders{i}]);clf;
    [h1 h2] = plot_cov(observer, observer.colheaders{i}, i-1, skip);
%     if ~any(i == [5:11 22:28])
        h3 = plot(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), 'r');
%         rmsval = sqrt(mean((interp1(reality.time(1:end-skip), reality.(observer.colheaders{i})(1:end-skip), observer.time(1:end-skip), 'cubic', 'extrap')-observer.(observer.colheaders{i})(1:end-skip)).^2));
%         external.textbp(['RMS: ' num2str(rmsval)]);
        legend([h1 h2 h3], 'Observer', 'Covariance', 'Ground truth');
%     else
    title(headers{i});
    ylabel(units{i});
    xlabel('Time');
end