for material_index=[1,4,8]
    for source_index=1:9
        if (source_index==9)
            y=ct_detect(ideal_source, material.coeffs(:,material_index), [0:0.1:10], 1);
            subplot(1,2,1);plot(source.mev,ideal_source);hold on;
            subplot(1,2,2);plot([0:.1:10],log(y));hold on;
        continue
        end
        y=ct_detect(source.photons(:,source_index), material.coeffs(:,material_index), [0:0.1:10], 1);
        figure(material_index);
        subplot(1,2,1);plot(source.mev,source.photons(:,source_index));hold on;
        subplot(1,2,2);plot([0:.1:10],log(y));hold on;
    end
    subplot(1,2,1);
    title('Source energy distribution');
    xlabel('Energy, MeV');
    ylabel('Photons, millions per cm^2');
    subplot(1,2,2);
    title(['Residual energy vs depth for',material.name(material_index)])
    xlabel('Depth, cm');
    ylabel('Log energy');
    legend(source.name,'ideal')
end
