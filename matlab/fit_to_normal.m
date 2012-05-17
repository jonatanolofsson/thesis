function fit_to_normal(data)
[mu, sd] = normfit(data);
ix = (-3*sd:1e-3:3*sd) + mu; %covers more than 99% of the curve
iy = pdf('norm', ix, mu, sd);
plot(ix,iy/max(iy), 'r');
hold all;
[h,hx] = hist(data, min(data):0.001:max(data));
bar(hx,h/max(h));
external.textbp([{['Mean: ' num2str(mu)]},{'Variance: ' num2str(sd^2)}])
% text(ix(1), 0.8, [{['Mean: ' num2str(mu)]},{'Variance: ' num2str(sd^2)}])