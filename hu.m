function [Y] = hu(P, material, X, scale)

% HU convert CT reconstruction output to Hounsfield Units
%
%  Y = HU(P, material, X, scale) converts the output in X into Hounsfield
%  Units, using the material coefficients, photon energy P and scale given.

% check inputs
narginchk(4,4);

% find coeffs for water
water = find(strcmp(material.name,{'Water'}));

% convert to HU
E = photons(P, material.coeffs(:,water), [1]);
mu_w = -log(sum(E)/sum(P));
HU = 1000*(X-mu_w)/mu_w;
% limit to normal DICOM range
c=0; w=200;
Y = (HU - c)*128/w +128;
