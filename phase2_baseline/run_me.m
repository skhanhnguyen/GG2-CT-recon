% START DEFINITIONS
phantom_hip = ct_phantom(material.name,256,3,'Titanium');
phantom_impulse = ct_phantom(material.name,256,2,'Titanium');
phantom_disc = ct_phantom(material.name,256,1,'Titanium');
phantom_pelvic_pins = ct_phantom(material.name,256,7,'Titanium');
t = [1 0.75 0.75 0.0 0.0 0];
X = phantom(t,256);
X(X>=1) = 5; % water
X(X<1) = 1; % air
water_phantom  = X;
% END DEFINITIONS

P = source.photons(:,1);
% P = fake_source(source.mev,0.12,material.coeffs(:,15),1,'ideal');

% selected_phantom = phantom_hip;
selected_phantom = water_phantom;
% ATTENUATION FIELD OF PHANTOM
% calculates an average (expected) value of the attenuation ceofficient
% of each material based on the proportion of each energy in the source
% mu = sum_E {mu_E * P_E/P_tot}
% The assumption here is that there is no beam hardening, so the proportion
% of each energy remains constant throughout the slice.
s1 = size(selected_phantom,1); s2 = size(selected_phantom,2);
phantom_mu_field = reshape(-log(sum(exp(-material.coeffs(:,selected_phantom)).* ...
    repmat(P, [1 s1*s2])/sum(P),1)), s1, s2);


angles = 256; alpha = 0.01; interp = 'linear'; scale = 0.1; mas = 100;
% add Poisson model for source
P = (P*mas*scale^2);
str = sprintf('#Angles = %d, alpha = %d, interpolation = %s, scale = %.02g', angles, alpha, interp, scale);
y = scan_and_reconstruct(P, material, selected_phantom, scale, angles, mas, alpha);
figure;
draw(selected_phantom);
title('Phantom')
figure;
draw(y);
title(str)
caxis([0 1]);

% percentage_error = 100*abs(y-phantom_mu_field)./phantom_mu_field;
% figure;
% draw(percentage_error);
% title('Percentage Error')
% caxis([0 100])