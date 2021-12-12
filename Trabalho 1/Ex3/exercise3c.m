function exercise3c()

%imageName = 'bird.png';
%imageName = 'bubbles.png';
%imageName = 'CT.jpg';
%imageName = 'finger.png';
%imageName = 'iris.png';
%imageName = 'MR.jpg';
%imageName = 'PET.png';
imageName = 'Sat.png';

path = strcat('../GrayscaleImages/', imageName);

image = imread(path);

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

figure(6)
imhist(C)


end