function [Y] = ct_calibrate(P, material, X, scale)

% CT_CALIBRATE convert CT detections to linearised attenuation
%
%  Y = CT_CALIBRATE(P, material, X, scale) takes the CT detection sinogram
%  in X (angles x samples) and returns a linear attenuation sinogram in Y
%  (angles x samples). P is the source energy distribution, material is the
%  material structure containing names, linear attenuation coefficients and
%  energies in mev, and scale is the size of each pixel in X, in cm.

% check inputs
narginchk(4,4);

% find coeffs corresponding to air
air = (strcmp(material.name,{'Air'}));

% Get dimensions - air in ct_scan has depth 2*n*scale
n = size(X, 2);

% Perform calibration
% Source energy = air CT scan
% I_0 = sum(P);
I_air = sum(photons(P, material.coeffs(:, air), n*2*scale));
Y = -log(X/I_air);