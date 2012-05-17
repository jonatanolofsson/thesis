function [hobs, hcov] = plot_cov(observer, field, fieldnum,skip)
if ~exist('skip','var')
    skip = 0;
end
%%
% clf
lower = observer.(field)(1:end-skip) - squeeze(observer.covariance(fieldnum,fieldnum,1:end-skip));
lowest = min(lower);
hcov = area(observer.time(1:end-skip), observer.(field)(1:end-skip) + squeeze(observer.covariance(fieldnum,fieldnum,1:end-skip)), lowest);
set(hcov,'FaceColor',[0.9 1 0.9]);
hold all;
h = area(observer.time(1:end-skip), lower, lowest);
set(h,'FaceColor','w');
hobs = plot(observer.time(1:end-skip), observer.(field)(1:end-skip), 'b');