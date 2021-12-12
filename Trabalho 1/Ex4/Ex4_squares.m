function Ex4_squares()

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('squares.gif');
noisy = handler.readImage('squares_4.gif');

angle = -20;

rotated = imrotate(noisy, angle);

cropSize = (size(rotated, 1) - size(original, 1)) / 2;
cropped = rotated(cropSize+1:end-cropSize, cropSize+1:end-cropSize);

improved = medfilt2(255 - cropped);

handler.show(1, original, noisy, improved);
handler.brightness(original, noisy, improved);
handler.contrast(original, noisy, improved);
handler.entropy(original, noisy, improved);

disp("MSE original - improved: ")
disp(immse(original, improved))

disp("MAE original - improved: ")
disp(mae(original - improved))

end