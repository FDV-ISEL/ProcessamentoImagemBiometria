function Ex4_iris()

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('iris.png');
noisy = handler.readImage('iris_4.png');


improved = medfilt2(noisy, [7 7]);


handler.show(1, original, noisy, improved);
handler.brightness(original, noisy, improved);
handler.contrast(original, noisy, improved);
handler.entropy(original, noisy, improved);
handler.mse(original, noisy, improved);
handler.mae(original, noisy, improved);

end