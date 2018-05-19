P = source.photons(:,1);
scale = 1;
depth = linspace(1,256,10000)*scale;

I_out = photons(P,material.coeffs(:,5),depth);
% ensure it is above zero for log
I_out(I_out<=1) = 1;

mu = -log(sum(I_out)/sum(P))./depth;

figure; plot(mu,depth);

poly = polyfit(mu, depth, 3);

