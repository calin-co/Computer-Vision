function histogram = getHistogram(gradients, nBins)
prag = 180/nBins;
gradients(gradients == 0) = 1;
gradientIndexBin = ceil (gradients/prag);
histogram = zeros(1,nBins);
for i = 1:nBins
    histogram(i) = sum(sum(gradientIndexBin == i));
end
if sum(histogram) ~= 16 
    display('ALERT');
    pause(10);
end
end