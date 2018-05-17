% START DEFINITIONS
phantom_hip = ct_phantom(material.name,256,3,'Titanium');
phantom_impulse = ct_phantom(material.name,256,2,'Titanium');
phantom_disc = ct_phantom(material.name,256,1,'Titanium');
phantom_pelvic_pins = ct_phantom(material.name,256,7,'Titanium');
% END DEFINITIONS
P = source.photons(:,1);
selected_phantom = phantom_hip;

% ATTENUATION FIELD OF PHANTOM
% calculates an average (expected) value of the attenuation ceofficient
% of each material based on the proportion of each energy in the source
% mu = sum_E {mu_E * P_E/P_tot}
% The assumption here is that there is no beam hardening, so the proportion
% of each energy remains constant throughout the slice.
phantom_mu_field = reshape(sum(material.coeffs(:,selected_phantom).*repmat(P, [1 size(selected_phantom,1)*size(selected_phantom,2)])/sum(source.photons(:,1)),1), size(selected_phantom,1), size(selected_phantom,2));


angles = 64; alpha = 0.5; interp = 'nearest'; scale = 0.1; 
str = sprintf('#Angles = %d, alpha = %d, interpolation = %s, scale = %.02g', angles, scale, interp, alpha);
y = scan_and_reconstruct(P, material, selected_phantom, scale, angles, 100, alpha);
figure;
draw(selected_phantom);
title('Phantom')
figure;
draw(y);
title(str)
caxis([0 1]);

percentage_error = 100*abs(y-phantom_mu_field)./phantom_mu_field;
figure;
draw(percentage_error);
title('Percentage Error')
caxis([0 100])