phantom_hip = ct_phantom(material.name,256,3,'Titanium');
    hip_scan = ct_scan_method(source.photons(:,1),material,phantom_hip,0.1,256,10000,'nearest');
    calibrated = ct_calibrate(source.photons(:,1),material,hip_scan,0.1);
    figure;
    draw(calibrated);
    
%     hip_scan = ct_scan_method(source.photons(:,1),material,phantom_hip,0.1,256,10000,'linear');
%     calibrated = ct_calibrate(source.photons(:,1),material,hip_scan,0.1);
%     figure;
%     draw(calibrated);
%     
%     hip_scan = ct_scan_method(source.photons(:,1),material,phantom_hip,0.1,256,10000,'cubic');
%     calibrated = ct_calibrate(source.photons(:,1),material,hip_scan,0.1);
%     figure;
%     draw(calibrated);
%     
%     hip_scan = ct_scan_method(source.photons(:,1),material,phantom_hip,0.1,256,10000,'spline');
%     calibrated = ct_calibrate(source.photons(:,1),material,hip_scan,0.1);
%     figure;
%     draw(calibrated);