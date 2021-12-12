function exercise3b()

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

outAdjust = imadjust(image, [0.2 0.8], []);

figure(1)
imshow(image)

figure(2)
imshow(outAdjust)

figure(3)
imhist(image)

figure(4)
imhist(outAdjust)

brigthness_outAdjust = mean2(outAdjust);

disp("Brilho: ")
disp(brigthness_outAdjust)

outAdjust_constrast = max(outAdjust(:)) - min(outAdjust(:));

disp("Contraste: ")
disp(outAdjust_constrast)

H_outAdjust = entropy(outAdjust);

disp("Entropia: ")
disp(H_outAdjust)

end