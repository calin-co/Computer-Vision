function puncteCaroiaj = genereazaPuncteCaroiaj(img,nrPuncteX,nrPuncteY,margine)
% genereaza puncte pe baza unui caroiaj
% un caroiaj este o retea de drepte orizontale si verticale de forma urmatoare:
%
%        |   |   |   |
%      --+---+---+---+--
%        |   |   |   |
%      --+---+---+---+--
%        |   |   |   |
%      --+---+---+---+--
%        |   |   |   |
%      --+---+---+---+--    
%        |   |   |   |
%
% Input:
%       img - imaginea input
%       nrPuncteX - numarul de drepte verticale folosit la constructia caroiajului
%                 - in desenul de mai sus aceste drepte sunt identificate cu simbolul |
%       nrPuncteY - numarul de drepte orizontale folosit la constructia caroiajului
%                 - in desenul de mai sus aceste drepte sunt identificate cu simbolul --
%         margine - numarul de pixeli de la marginea imaginii (sus, jos, stanga, dreapta) pentru care nu se considera puncte
% Output:
%       puncteCaroiaj - matrice (nrPuncteX * nrPuncteY) X 2
%                     - fiecare linie reprezinta un punct (y,x) de pe caroiaj aflat la intersectia dreptelor orizontale si verticale
%                     - in desenul de mai sus aceste puncte sunt idenficate cu semnul +

puncteCaroiaj = zeros(nrPuncteX*nrPuncteY,2);

%completati codul
dimImg = size(img,2);
dimX = size(img,2) - (margine *2);
dimY = size(img,1) - (margine *2);

pasX = round(dimX / (nrPuncteX + 1));
pasY = round(dimY / (nrPuncteY + 1));
% disp('_________');
% disp(pasX);
% disp(pasY);
% disp('__________');

contor = 1;
for i =1:nrPuncteY
    for j = 1:nrPuncteX
        puncteCaroiaj(contor,:) = [margine + (pasY * i), margine+ (pasX * j)];
        contor = contor + 1;
    end
end
 
% imshow(img,[0 1]);
% hold on ;
% plot(puncteCaroiaj(:,2), puncteCaroiaj(:,1), 'r+', 'MarkerSize',10);   

end