function histogramaBOVW = calculeazaHistogramaBOVW(descriptoriHOG, cuvinteVizuale)
  % calculeaza histograma BOVW pe baza descriptorilor si a cuvintelor
  % vizuale, gasind pentru fiecare descriptor cuvantul vizual cel mai
  % apropiat (in sensul distantei Euclidiene)
  %
  % Input:
  %   descriptori: matrice MxD, contine M descriptori de dimensiune D
  %   cuvinteVizuale: matrice NxD, contine N centri de dimensiune D 
  % Output:
  %   histogramaBOVW: vector linie 1xN 
  
 % completati codul
 histogramaBOVW = zeros(1,size(cuvinteVizuale,1));
 for i = 1:size(descriptoriHOG,1)
    descriptorHOG = repmat(descriptoriHOG(i,:), size(cuvinteVizuale,1),1);
    distEuclid =sum ( ((cuvinteVizuale - double(descriptorHOG)) .^ 2)'  );
    closestWord = distEuclid == min(distEuclid);
    histogramaBOVW = histogramaBOVW + closestWord;
 end
     
end