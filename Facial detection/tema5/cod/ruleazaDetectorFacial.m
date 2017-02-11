function [detectii, scoruriDetectii, imageIdx] = ruleazaDetectorFacial(parametri)
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i
%               (nu punem intregul path, ci doar numele imaginii: 'albert.jpg')

% Aceasta functie returneaza toate detectiile ( = ferestre) pentru toate imaginile din parametri.numeDirectorExempleTest
% Directorul cu numele parametri.numeDirectorExempleTest contine imagini ce
% pot sau nu contine fete. Aceasta functie ar trebui sa detecteze fete atat pe setul de
% date MIT+CMU dar si pentru alte imagini (imaginile realizate cu voi la curs+laborator).
% Functia 'suprimeazaNonMaximele' suprimeaza detectii care se suprapun (protocolul de evaluare considera o detectie duplicata ca fiind falsa)
% Suprimarea non-maximelor se realizeaza pe pentru fiecare imagine.

% Functia voastra ar trebui sa calculeze pentru fiecare imagine
% descriptorul HOG asociat. Apoi glisati o fereastra de dimeniune paremtri.dimensiuneFereastra x  paremtri.dimensiuneFereastra (implicit 36x36)
% si folositi clasificatorul liniar (w,b) invatat poentru a obtine un scor. Daca acest scor este deasupra unui prag (threshold) pastrati detectia
% iar apoi mporcesati toate detectiile prin suprimarea non maximelor.
% pentru detectarea fetelor de diverse marimi folosit un detector multiscale

imgFiles = dir( fullfile( parametri.numeDirectorExempleTest, '*.jpg' ));
%initializare variabile de returnat
detectii = zeros(0,4);
aux_detectii = detectii;
scoruriDetectii = zeros(0,1);
dimensiuneImagine = zeros(0,2);
aux_scoruriDetectii = scoruriDetectii;
imageIdx = cell(0,1);
aux_imageIdx = imageIdx;
img_test = zeros(parametri.dimensiuneFereastra,parametri.dimensiuneFereastra);
contor_detectii = 1;
x_min = 0;
x_max = 0;
y_min = 0;
y_max = 0;
descriptor_img = zeros(6,6,31);
scor = 0;
dim_resize = [1 0.8 0.6 0.4 0.2];

for i = 1:length(imgFiles)      
    fprintf('Rulam detectorul facial pe imaginea %s\n', imgFiles(i).name)
    img = imread(fullfile( parametri.numeDirectorExempleTest, imgFiles(i).name ));    
    if(size(img,3) > 1)
        img = rgb2gray(img);
    end    
    cpy_img = img ;
    im_detectii = zeros(0,4);
    im_scoruriDetectii = zeros(0,1);
    im_imageIdx = cell(0,1);
    dimensiuneImagine = zeros(0,2);
    contor_detectii = 1;
    for d = 1:length(dim_resize)
       img = imresize(cpy_img,dim_resize(d));
       descriptor_img = vl_hog(single(img),parametri.dimensiuneCelulaHOG);
       nr_celule = parametri.dimensiuneFereastra / parametri.dimensiuneCelulaHOG;
       [celule_x celule_y celule_hist] = size(descriptor_img);
       for j = 1: celule_x - nr_celule
            for k = 1: celule_y - nr_celule
                descriptor_img_test = descriptor_img(j:j+nr_celule-1, k:k+nr_celule-1,:);
                descriptor_img_test = descriptor_img_test(:);
                scor = (parametri.w)'*descriptor_img_test + parametri.b;
                if scor > parametri.threshold
                    x_min = (j-1) * parametri.dimensiuneCelulaHOG / dim_resize(d);
                    x_max = x_min + parametri.dimensiuneFereastra / dim_resize(d);
                    y_min = (k-1) * parametri.dimensiuneCelulaHOG / dim_resize(d);
                    y_max = y_min + parametri.dimensiuneFereastra / dim_resize(d);
                    im_detectii(contor_detectii,:) = [y_min x_min y_max x_max];
                    im_scoruriDetectii(contor_detectii) = scor;
                    im_imageIdx(contor_detectii) = {imgFiles(i).name};
                    dimensiuneImagine(contor_detectii,:) = size(img);
                    contor_detectii = contor_detectii + 1;
                end
            end
        end   
    end
    esteMaxim = eliminaNonMaximele(im_detectii, im_scoruriDetectii, dimensiuneImagine);
    im_detectii = im_detectii(esteMaxim ==1,:);
    im_scoruriDetectii = im_scoruriDetectii(esteMaxim==1);
    im_imageIdx = im_imageIdx(esteMaxim == 1);
    detectii = [detectii; im_detectii];
    scoruriDetectii = [ scoruriDetectii  im_scoruriDetectii];
    imageIdx = [imageIdx  im_imageIdx];
      
end





