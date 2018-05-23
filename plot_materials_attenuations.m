load ct_data;
close all;
figure;
log_mev_range = linspace(min(log(material.mev)/log(10)),max(log(material.mev)/log(10)),100000);
log_coeff_range = interp1(log(material.mev)/log(10),log(material.coeffs)/log(10), log_mev_range, 'cubic');
loglog(10.^log_mev_range, 10.^log_coeff_range)
% figure;
% loglog(material.mev,material.coeffs)
xlabel('Energy, Mev')
ylabel('Attenuation, cm^{-1}')
title('Linear Attenuation Coefficients')
grid on
legend(material.name)