function Ex4_XRay()

% TODO Erro praticamente igual ._.

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('XRay.png');
noisy = handler.readImage('XRay_1.jpg');


improved = medfilt2(noisy);


handler.show(original, noisy, improved);
handler.brightness(original, noisy, improved);
handler.contrast(original, noisy, improved);
handler.entropy(original, noisy, improved);
handler.mse(original, noisy, improved);
handler.mae(original, noisy, improved);

end