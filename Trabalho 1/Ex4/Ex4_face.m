function Ex4_face()

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('face.jpg');
noisy = handler.readImage('face_1.jpg');

IMask = double(original) - double(noisy);

k = 0.01;
improved = uint8(double(original) + k*IMask);


handler.show(original, noisy, improved);
handler.brightness(original, noisy, improved);
handler.contrast(original, noisy, improved);
handler.entropy(original, noisy, improved);
handler.mse(original, noisy, improved);
handler.mae(original, noisy, improved);


end