function Ex4_faceThermogram()

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('face_thermogram.png');
noisy = handler.readImage('face_thermogram_4.png');


improved = medfilt2(noisy);

% utilizar com as imagens _2 e _4
improved = imhistmatch(improved, original);


handler.show(1, original, noisy, improved);
handler.brightness(original, noisy, improved);
handler.contrast(original, noisy, improved);
handler.entropy(original, noisy, improved);
handler.mse(original, noisy, improved);
handler.mae(original, noisy, improved);


end