function ex3b()

clc;
clf;

extractor = FingerprintExtraction();

% true for capacitive images; false for optical images
extractor.extract('thumb_capacitive.png', true);

end