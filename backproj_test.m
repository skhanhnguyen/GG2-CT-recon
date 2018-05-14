phantom_hip = ct_phantom(material.name,256,3,'Titanium');
phantom_impulse = ct_phantom(material.name,256,2,'Titanium');
phantom_disc = ct_phantom(material.name,256,1,'Titanium');
selected_phantom = phantom_hip;
y = scan_and_reconstruct_week1(source.photons(:,1), material, selected_phantom, 0.001, 256, 100, 1);
figure;
draw(selected_phantom);
figure;

% sinogram = ct_scan(source.photons(:,1),material,selected_phantom,0.1,256,100);
% % convert detector values into attenuation values
% calibrated = ct_calibrate(source.photons(:,1),material,sinogram,0.1);
% % Filter
% filtered = ramp_filter(calibrated, 0.1, 0.01);
% 
% y = iradon(filtered', linspace(0,180,256));
draw(y);
