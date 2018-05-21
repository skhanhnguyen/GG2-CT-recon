function [mu_c] = bh_correction(f, C, mu)
    narginchk(3,3);
    t=zeros(size(mu));
    for i = 1:length(f)
       t = t + f(i)*mu.^(length(f)-i); 
    end
    mu_c = C*t;
    mu_c(mu_c<=1) = 1;