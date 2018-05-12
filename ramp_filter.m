function [Y] = ramp_filter(X, scale, alpha)

% RAMP_FILTER Ram-Lak filter with raised-cosine for CT reconstruction
%
%  Y = RAMP_FILTER(X) filters the input in X (angles x samples)
%  using a Ram-Lak filter.
%
%  Y = RAMP_FILTER(X, alpha) can be used to modify the Ram-Lak filter by a
%  cosine raised to the power given by alpha.

% check inputs
narginchk(2,3);
if (nargin<3)
  alpha = 0.001;
end

% get input dimensions
n = size(X,2);
angles = size(X,1);

% Set up filter length m to be a power of 2, and at least twice as long as input
% to prevent spatial domain aliasing and to speed up the FFT
m = floor(log(n)/log(2)+2);
m = 2^m;


% apply filter to all angles
% Pad X with zeros to bring it up to the same size as the filter, i.e. angles x m
% (so that element-wise multiplication works later)
X = [X zeros(angles,m-n)];
X_f = fft(X');

% Creating the Ram-Lak filter
filter_f = ifftshift(abs((-m/2:m/2-1)'));
filter_f(1) = 1/(4);
filter_f = filter_f .* ifftshift(cos((-m/2:m/2-1)'/(m/2) * pi/2).^alpha);
filter_f = repmat(filter_f, [1 angles]);

% Element-wise multiplication for application of filter
filtered_X_f = X_f.*filter_f;

Y = abs(ifft(filtered_X_f)');
Y = Y(:,1:n);