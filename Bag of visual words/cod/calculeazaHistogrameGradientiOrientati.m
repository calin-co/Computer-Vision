function [descriptoriHOG, patchuri] = calculeazaHistogrameGradientiOrientati(img,puncte,dimensiuneCelula)
% calculeaza pentru fiecare punct din de pe caroiaj, histograma de gradienti orientati
% corespunzatoare dupa cum urmeaza:
%  - considera cele 16 celule inconjuratoare si calculeaza pentru fiecare
%  celula histograma de gradienti orientati de dimensiune 8;
%  - concateneaza cele 16 histograme de dimeniune 8 intr-un descriptor de
%  lungime 128 = 16*8;
%  - fiecare celula are dimensiunea dimensiuneCelula x dimensiuneCelula (4x4 pixeli)
%
% Input:
%       img - imaginea input
%    puncte - puncte de pe caroiaj pentru care calculam histograma de
%             gradienti orientati
%   dimensiuneCelula - defineste cat de mare este celula
%                    - fiecare celula este un patrat continand
%                      dimensiuneCelula x dimensiuneCelula pixeli
% Output:
%        descriptoriHOG - matrice #Puncte X 128
%                       - fiecare linie contine histograme de gradienti
%                        orientati calculata pentru fiecare punct de pe
%                        caroiaj
%               patchuri - matrice #Puncte X (16 * dimensiuneCelula^2)
%                       - fiecare linie contine pixelii din cele 16 celule
%                            considerati pe coloana

nBins = 8; %dimensiunea histogramelor fiecarei celule

descriptoriHOG = zeros(0,nBins*4*4); % fiecare linie reprezinta concatenarea celor 16 histograme corespunzatoare fiecarei celule
patchuri = zeros(0,4*dimensiuneCelula*4*dimensiuneCelula); % 

if size(img,3)==3
    img = rgb2gray(img);
end

img = double(img);
f = [-1 0 1];
Ix = imfilter(img,f,'replicate');
Iy = imfilter(img,f','replicate');

orientare = atand(Ix./(Iy+eps)); %unghiuri intre -90 si 90 grade
orientare = orientare + 90; %unghiuri intre 0 si 180 grade
celula = zeros(dimensiuneCelula,dimensiuneCelula);

%completati codul
%pt fiecare punct din reteaua de puncte
for i = 1:size(puncte,1)
    patch = img(puncte(i,1)-(2*dimensiuneCelula-1) : puncte(i,1)+2*dimensiuneCelula, puncte(i,2)-(2*dimensiuneCelula - 1):puncte(i,2)+2*dimensiuneCelula);
    gradient_patch = orientare(puncte(i,1)-(2*dimensiuneCelula-1) : puncte(i,1)+2*dimensiuneCelula, puncte(i,2)-(2*dimensiuneCelula - 1):puncte(i,2)+2*dimensiuneCelula);
    histograma_concatenata = [];
    for j = 1:4
        for k = 1:4
           celula = patch(dimensiuneCelula*(j-1) + 1 :dimensiuneCelula*j, dimensiuneCelula*(k-1) + 1 :dimensiuneCelula*k);
           gradient_celula = gradient_patch(dimensiuneCelula*(j-1) + 1 :dimensiuneCelula*j, dimensiuneCelula*(k-1) + 1 :dimensiuneCelula*k);
           histogram = getHistogram(gradient_celula,nBins);
           histograma_concatenata = [histograma_concatenata, histogram];
%          subplot (4,4,  (j-1)*4 + k), imshow(uint8(gradient_celula), [0 255]);    
%          hold on;
        end
    end
    patchuri(i,:) = uint8(reshape(patch,1,4*dimensiuneCelula*4*dimensiuneCelula));
%   subplot(10,10,i), imshow(uint8(reshape(patchuri(i,:),4*dimensiuneCelula,4*dimensiuneCelula)));
    descriptoriHOG(i,:) = histograma_concatenata;
end
 patchuri = uint8(patchuri);
 descriptoriHOG = uint8(descriptoriHOG);
end
