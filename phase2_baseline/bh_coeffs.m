function [f, C] = bh_coeffs(P, material, scale)
    % BEAM_HARDENING_CALIBRATE calculates polyfit f coefficients for
    % finding equivalet depth of water, and calculates C for mapping 
    % equivalent depth to corrected mu value.
    
    narginchk(3,3);
    
    depth = linspace(1,256,10000)*scale;

    I_out = photons(P,material.coeffs(:,5),depth);
    mu = -log(sum(I_out)/sum(P));

    poly_order = 5;
    f = polyfit(mu, depth, poly_order);
    
    mu_range = linspace(0,max(mu),10000)';
    poly_mu_range = ones(size(mu_range));
    
    for i=1:poly_order
        poly_mu_range = [mu_range.^i poly_mu_range];
    end
    pred_depth = poly_mu_range*f';

    mu_thresh = 2;
    C = regress(mu_range(mu_range<mu_thresh), pred_depth(mu_range<mu_thresh));
end