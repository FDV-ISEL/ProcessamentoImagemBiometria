function ex3c()

clc;
clf;

extractor = FingerprintExtraction();

% true for capacitive images; false for optical images

extractor.extract('thumb_capacitive.png', true);
extractor.extract('index_capacitive.png', true);
extractor.extract('thumb_optical.png', false);
extractor.extract('index_optical.png', false);
extractor.extract('little_capacitive.png', true);

disp(" ");

name = extractor.identify('index_capacitive.png', true);
disp("Identified:");
disp(name);

disp(" ");

exists = extractor.authenticate('index_capacitive.png', 'index_capacitive.png', true);
disp("Authenticated:");
disp(exists);

end