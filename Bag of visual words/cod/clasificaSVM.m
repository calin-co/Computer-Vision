function eticheta = clasificaSVM( histogramaBOVW_test, histogrameBOVW_exemplePozitive, histogrameBOVW_exempleNegative)
% eticheta = eticheta dedusa folosind un SVM liniar: http://www.vlfeat.org/matlab/vl_svmtrain.html
%
% Input: 
%       histogramaBOVW_test - matrice 1 x K, histograma BOVW a unei imagini test
%       histogrameBOVW_exemplePozitive - matrice #ImaginiExemplePozitive x K, fiecare linie reprezinta histograma BOVW a unei imagini pozitive
%       histogrameBOVW_exempleNegative - matrice #ImaginiExempleNegative x K, fiecare linie reprezinta histograma BOVW a unei imagini negative
% Output: 
%     eticheta - eticheta dedusa a imaginii test

trainFeat = [histogrameBOVW_exemplePozitive; histogrameBOVW_exempleNegative]';
trainLabels =[ ones(size(histogrameBOVW_exemplePozitive,1),1) ; ones(size(histogrameBOVW_exempleNegative,1),1) * -1];
lambda = 0.03;
[W B] = vl_svmtrain(trainFeat,trainLabels,lambda);

if histogramaBOVW_test * W + B > 1
    eticheta = 1;
else
    eticheta = 0;
end;

