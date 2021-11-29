function Ex4_face()

image_original = imread('../NoisyImages/face.jpg');
image = imread('../NoisyImages/face_1.jpg');

image_improv = imsharpen(image, "Radius", 1.5, "Amount", 2);

%
% Imagens
%
figure(1)
imshow(image_original)

figure(2)
imshow(image)

figure(3)
imshow(image_improv)

%
% Brightness
%
b_original = mean2(image_original);
b_image = mean2(image);
b_improv = mean2(image_improv);

disp("Brightness original - noisy: ")
disp(b_original - b_image)

disp("Brightness original - improved: ")
disp(b_original - b_improv)

disp("Brightness noisy - improved: ")
disp(b_image - b_improv)

%
% Contrast
%
c_original = 20*log10(double(max((image_original(:)) + 1)/(min(image_original(:)) + 1)));
c_noisy = 20*log10(double(max((image(:)) + 1)*1.0/(min(image(:)) + 1)));
c_improv = 20*log10(double(max((image_improv(:)) + 1)*1.0/(min(image_improv(:)) + 1)));

disp("Contrast original - noisy: ")
disp(c_original - c_noisy)

disp("Contrast original - improved: ")
disp(c_original - c_improv)

disp("Contrast noisy - improved: ")
disp(c_noisy - c_improv)

%
% Entropia
%
H_og = entropy(image_original);
H_noisy = entropy(image);
H_imp = entropy(image_improv);

disp("Entropy original - noisy: ")
disp(H_og - H_noisy)

disp("Entropy original - improved: ")
disp(H_og - H_imp)

disp("Entropy noisy - improved: ")
disp(H_noisy - H_imp)

%
% MSE
%
disp("MSE original - noisy: ")
disp(immse(image_original, image))

disp("MSE original - improved: ")
disp(immse(image_original, image_improv))

disp("MSE noisy - improved: ")
disp(immse(image, image_improv))

%
% MAE
%
disp("MAE original - noisy: ")
disp(mae(image_original - image))

disp("MAE original - improved: ")
disp(mae(image_original - image_improv))

disp("MAE noisy - improved: ")
disp(mae(image - image_improv))

end