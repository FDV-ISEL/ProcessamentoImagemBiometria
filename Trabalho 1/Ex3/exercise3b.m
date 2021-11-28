function exercise3b()

image = imread('GrayscaleImages/bird.png');

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

disp("Brightness outAdjust: ")
disp(brigthness_outAdjust)

outAdjust_constrast = max(outAdjust(:)) - min(outAdjust(:));

disp("Contrast outAdjust: ")
disp(outAdjust_constrast)

H_outAdjust = entropy(outAdjust);

disp("Entropy outAdjust: ")
disp(H_outAdjust)

end