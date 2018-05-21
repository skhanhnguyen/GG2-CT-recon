P = source.photons(:,1);
scale = 1;
depth = linspace(1,256,10000)*scale;

I_out = photons(P,material.coeffs(:,5),depth);
% ensure it is above zero for log
%I_out(I_out<=1) = 1;

% mu = -log(sum(I_out)/sum(P))./depth;
mu = -log(sum(I_out)/sum(P));

figure; plot(mu,depth);

poly_order = 5;
f = polyfit(mu, depth, poly_order);
hold on;
mu_range = linspace(0,max(mu),10000)';
poly_mu_range = [ones(size(mu_range))];
for i=1:poly_order
    poly_mu_range = [mu_range.^i poly_mu_range];
end
pred_depth = poly_mu_range*f';
plot(mu_range,pred_depth);
grid on
mu_thresh = 2;
C = regress(mu_range(mu_range<mu_thresh), pred_depth(mu_range<mu_thresh));
plot(mu_range,1/C*mu_range);
[f, C] = bh_coeffs(P, material, scale);
plot(bh_correction(f, C, mu_range),pred_depth+1)
