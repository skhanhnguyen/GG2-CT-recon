phantom_hip = ct_phantom(material.name,256,3,'Titanium');
hip_scan = ct_scan(source.photons(:,1),material,phantom_hip,0.1,256);
calibrated = ct_calibrate(source.photons(:,1),material,hip_scan,0.1);
draw(calibrated);