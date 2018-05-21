function [mu_c] = bh_correction(P, material, scale, mu)
    narginchk(4,4);
    [f, C] = bh_coeffs(P, material, scale);
    t=zeros(size(mu));
    for i = 1:length(f)
       t = t + f(i)*mu.^(length(f)-i); 
    end
    mu_c = C*t;