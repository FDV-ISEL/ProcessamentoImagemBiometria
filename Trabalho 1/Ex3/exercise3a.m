function exercise3a()

image = imread('GrayscaleImages/bird.png');
negative_image = 255 - image;

figure(1)
imshow(image)

figure(2)
imshow(negative_image)

brigthness_image = mean2(image);
brigthness_negative = mean2(negative_image);

disp("Brightness original: ")
disp(brigthness_image)

disp("Brightness negative: ")
disp(brigthness_negative)


image_constrast = max(image(:)) - min(image(:));
negative_constrast = max(negative_image(:)) - min(negative_image(:));

disp("Contrast original: ")
disp(image_constrast)

disp("Contrast negative: ")
disp(negative_constrast)



H = entropy(image);
H_negative = entropy(negative_image);

disp("Entropy original: ")
disp(H)

disp("Entropy negative: ")
disp(H_negative)

figure(3)
imhist(image)

figure(4)
imhist(negative_image)


end