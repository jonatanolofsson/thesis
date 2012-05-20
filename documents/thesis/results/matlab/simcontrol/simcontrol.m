controlstates   = Files.import('controlstate.log');
controlsignal   = Files.import('controlsignal.log');
reference       = Files.import('reference.log');
observer        = Files.import('observer.log');
reality         = Files.import('reality.log');

observer.covariance = Files.importMatrix('covariance.log');

if ~exist('figures', 'var')
    figures = Figures();
end

%%
figures.getFigure('referencefollowing');
subplot(4,1,1); plot(reference.time, reference.velX, 'r', controlstates.time, controlstates.velX, 'b'); title('Velocity, X'); ylabel('m/s'); legend('Reference', 'Observer estimate');
subplot(4,1,2); plot(reference.time, reference.velY, 'r', controlstates.time, controlstates.velY, 'b'); title('Velocity, Y'); ylabel('m/s');
subplot(4,1,3); plot(reference.time, reference.velZ, 'r', controlstates.time, controlstates.velZ, 'b'); title('Velocity, Z'); ylabel('m/s');
subplot(4,1,4); plot(reference.time, reference.wYaw, 'r', controlstates.time, controlstates.wYaw, 'b'); title('Yaw rate'); xlabel('time'); ylabel('rad/s');

%%
figures.getFigure('windbump');
N = 2000;
plot(observer.time(end-N:end), observer.windZ(end-N:end));