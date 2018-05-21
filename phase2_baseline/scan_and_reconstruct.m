function [Y] = scan_and_reconstruct(P, material, X, scale, angles, mas, alpha)

% SCAN_AND_RECONSTRUCT Simulation of the CT scanning process
%
%  Y = SCAN_AND_RECONSTRUCT(P, material, X, scale, angles, mas, alpha)
%  takes the phantom data in X (samples x samples), scans it using the
%  source P and material information given, as well as the scale (in cm),
%  number of angles, time-current product in mas, and raised-cosine power
%  alpha for filtering. The output Y is the same size as X.

% check inputs
narginchk(5,7);
if (nargin<7)
  alpha = 0.001;
end
if (nargin<6)
  mas = 100;
end
% create sinogram from phantom data, with received detector values
sinogram = ct_scan(P,material,X,scale,angles,mas);

% correct sinogram's beam hardening
[f, C] = bh_coeffs(P, material, scale);
corrected_sinogram = bh_correction(f, C, sinogram);


% convert detector values into attenuation values
calibrated = ct_calibrate(P,material,corrected_sinogram,scale);

% Filter
filtered = ramp_filter(calibrated, scale, alpha);

% Back-projection
Y = back_project(filtered);