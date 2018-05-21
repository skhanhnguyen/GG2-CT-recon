function [Y] = ct_detect(P, coeffs, depth, mas)

% CT_DETECT return detector photons for given material depths.
%
%  Y = CT_DETECT(P, coeffs, depth, mas) takes a source energy
%  distribution P (energies x 1), a set of material linear attenuation
%  coefficients coeffs (energies x materials), and a set of material depths
%  in depth (materials x samples) and returns the detections at each sample
%  in Y (1 x samples).
%
%  mas defines the current-time-product which affects the noise distribution
%  for the linear attenuation

% check inputs
narginchk(3, 4);
if (nargin<4)
  mas = 10000;
end


% extend source photon array so it covers all samples
Y = poissrnd(P*ones(1,size(depth,2)));
source = Y;

% Squash nans
depth(depth<0) = 0;

% calculate array of residual mev x samples for each material in turn
% This is the product in equation (3)
for m=1:size(coeffs,2)
  Y = photons(Y, coeffs(:,m), depth(m,:), mas);
end

% sum over energy
% This is the sum in equation (3)
Y = sum(Y);

% add in detection noise model
bg_coeff = 1e6;
bg_noise = poissrnd(bg_coeff*ones(size(Y)));
scat_coeff = 0.001;
scatter_noise = sum(poissrnd(source*scat_coeff));

Y = Y + bg_noise + scatter_noise;
% ensure it is above zero for log
Y(Y<=1) = 1;

