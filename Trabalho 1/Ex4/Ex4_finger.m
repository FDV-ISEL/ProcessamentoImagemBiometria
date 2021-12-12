function Ex4_finger()

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('finger.png');
noisy = handler.readImage('finger_5.png');

P = size(original,1) * 2;
Q = size(original,2) * 2;

originalPadded = padarray(original,[P/2 Q/2], 0, 'post');
noisyPadded = padarray(noisy,[P/2 Q/2], 0, 'post');

frequencyImageOriginal = fftshift(fft2(originalPadded));

figure(1);
imagesc( log( 1 + abs(frequencyImageOriginal)) );
title(' |F[u,v]| ');

frequencyImageNoisy = fftshift(fft2(noisyPadded));

figure(2);
imagesc( log( 1 + abs(frequencyImageNoisy)) );
title(' |F[u,v]| ');

radius = 50;

H = zeros( P, Q );
for u=1 : P
    for v=1 : Q
        d = sqrt( (u - P/2)^2 + (v - Q/2)^2);
        if d > radius
            H(u,v)=1;
        end
    end
end 

difference = abs(abs(frequencyImageOriginal) - abs(frequencyImageNoisy));

figure(3)
imagesc(difference)

G = frequencyImageNoisy.*H;

improvedPadded = ifft2(ifftshift(G));
improvedPadded = uint8(real(improvedPadded));

improved = improvedPadded(1:P/2, 1:Q/2);

improved = histeq(improved);

handler.show(4, original, noisy, improved);
handler.brightness(original, noisy, improved);
handler.contrast(original, noisy, improved);
handler.entropy(original, noisy, improved);
handler.mse(original, noisy, improved);
handler.mae(original, noisy, improved);

end