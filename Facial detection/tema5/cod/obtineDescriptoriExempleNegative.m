function descriptoriExempleNegative = obtineDescriptoriExempleNegative(parametri)
% descriptoriExempleNegative = matrice MxD, unde:
%   M = numarul de exemple negative de antrenare (NU sunt fete de oameni),
%   M = parametri.numarExempleNegative
%   D = numarul de dimensiuni al descriptorului
%   in mod implicit D = (parametri.dimensiuneFereastra/parametri.dimensiuneCelula)^2*parametri.dimensiuneDescriptorCelula

imgFiles = dir( fullfile( parametri.numeDirectorExempleNegative , '*.jpg' ));
numarImagini = length(imgFiles);
contor_img_neg =  1;
exemplu_img_neg = zeros(parametri.dimensiuneFereastra, parametri.dimensiuneFereastra);
numarExempleNegative_pe_imagine = round(parametri.numarExempleNegative/numarImagini);
descriptoriExempleNegative = zeros(parametri.numarExempleNegative,(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG)^2*parametri.dimensiuneDescriptorCelula);
disp(['Exista un numar de imagini = ' num2str(numarImagini) ' ce contine numai exemple negative']);
for idx = 1:numarImagini
    disp(['Procesam imaginea numarul ' num2str(idx)]);
    img = imread([parametri.numeDirectorExempleNegative '/' imgFiles(idx).name]);
    if size(img,3) == 3
        img = rgb2gray(img);
    end 
    for i = 1 : numarExempleNegative_pe_imagine
        [latime inaltime] = size(img);
        ind_rand_latime = floor( rand *(latime - parametri.dimensiuneFereastra) + parametri.dimensiuneFereastra/2 +1 );
        ind_rand_inaltime = floor(rand *(inaltime - parametri.dimensiuneFereastra) + parametri.dimensiuneFereastra/2+ 1);
        exemplu_img_neg = img(ind_rand_latime - 18 : ind_rand_latime + 17,ind_rand_inaltime - 18 : ind_rand_inaltime + 17);
        descriptor_img = vl_hog(single(exemplu_img_neg), parametri.dimensiuneCelulaHOG);
        descriptor_img = descriptor_img(:);
        descriptoriExempleNegative(contor_img_neg,:) = descriptor_img;
        contor_img_neg = contor_img_neg + 1;
        
    end
        
    
end