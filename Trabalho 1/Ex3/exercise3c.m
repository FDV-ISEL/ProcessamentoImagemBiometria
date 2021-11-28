function exercise3c()

image = imread('GrayscaleImages/bird.png');

I = histeq(image);

figure(1)
imshow(image)

figure(2)
imhist(image)

figure(3)
imshow(I)

figure(4)
imhist(I)

C = imhistmatch(image, I);
figure(5)
imshow(C)


end