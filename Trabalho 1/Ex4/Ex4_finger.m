function Ex4_finger()

% Work in progress

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('finger.png');
noisy = handler.readImage('finger_1.png');


frequencyImage = fftshift(fft2(noisy));

figure(1);
subplot(121);
imagesc( log( 1 + abs(frequencyImage)) );
title(' |F[u,v]| ');

subplot(122); 
imagesc( angle(frequencyImage) );
title( ' arg[F[u,v]] '); 

end