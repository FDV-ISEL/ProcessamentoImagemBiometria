function exercise3a()

imageName = 'bird.png';
%imageName = 'bubbles.png';
%imageName = 'CT.jpg';
%imageName = 'finger.png';
%imageName = 'iris.png';
%imageName = 'MR.jpg';
%imageName = 'PET.png';
%imageName = 'Sat.png';

path = strcat('../GrayscaleImages/', imageName);

image = imread(path);
negative_image = 255 - image;

figure(1)
imshow(image)

figure(2)
imshow(negative_image)

brigthness_image = mean2(image);
brigthness_negative = mean2(negative_image);

disp("Brilho da imagem original: ")
disp(brigthness_image)

disp("Brilho da imagem negativa: ")
disp(brigthness_negative)


image_constrast = max(image(:)) - min(image(:));
negative_constrast = max(negative_image(:)) - min(negative_image(:));

disp("Contraste da imagem original: ")
disp(image_constrast)

disp("Contraste da imagem negativa: ")
disp(negative_constrast)



H = entropy(image);
H_negative = entropy(negative_image);

disp("Entropia da imagem original: ")
disp(H)

disp("Entropia da imagem negativa: ")
disp(H_negative)

figure(3)
imhist(image)

figure(4)
imhist(negative_image)


end