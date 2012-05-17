function plot_residual(sensor, measurement, simulation, skip)
delta = measurement.(sensor)(1:end-skip)-simulation.(sensor)(1:end-skip);
rmsval = sqrt(mean(delta.^2));
plot(measurement.time(1:end-skip), delta, 'r');
external.textbp(['RMS: ' num2str(rmsval)]);