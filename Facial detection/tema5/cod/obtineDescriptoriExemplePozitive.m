function descriptoriExemplePozitive = obtineDescriptoriExemplePozitive(parametri)
% descriptoriExemplePozitive = matrice NxD, unde:
%   N = numarul de exemple pozitive de antrenare (fete de oameni) 
%   D = numarul de dimensiuni al descriptorului
%   in mod implicit D = (parametri.dimensiuneFereastra/parametri.dimensiuneCelula)^2*parametri.dimensiuneDescriptorCelula

imgFiles = dir( fullfile( parametri.numeDirectorExemplePozitive, '*.jpg') ); %exemplele pozitive sunt stocate ca .jpg
numarImagini = length(imgFiles);

descriptoriExemplePozitive = zeros(numarImagini,(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG)^2*parametri.dimensiuneDescriptorCelula);
disp(['Exista un numar de exemple pozitive = ' num2str(numarImagini)]);pause(2);
for idx = 1:numarImagini
   % disp(['Procesam exemplul pozitiv numarul ' num2str(idx)]);
    img = imread([parametri.numeDirectorExemplePozitive '/' imgFiles(idx).name]);
    if size(img,3) > 1
        img = rgb2gray(img);
    end   
    descriptor_img = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
    descriptoriExemplePozitive(idx,:) = descriptor_img(:);
    descriptor_img = vl_hog(single(flipdim(img,2)), parametri.dimensiuneCelulaHOG);
    descriptoriExemplePozitive(idx+numarImagini,:) = descriptor_img(:);
end
