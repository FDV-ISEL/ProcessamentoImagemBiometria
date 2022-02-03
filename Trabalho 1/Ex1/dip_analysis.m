function dip_analysis()

%image = imread('bird.tif');
%image = imread('boat.tif');
image = imread('lena.tif');

histogram = imhist(image);

count = 0;
max_value = -1;
min_value = histogram(1);
index_max = 0;
index_min = 0;
for i=1:length(histogram)
    if histogram(i) > 0
        count=count+1;
    end
    
    if histogram(i) > max_value
        max_value = histogram(i);
        index_max = i;
    end
    
    if histogram(i) < min_value
        min_value = histogram(i);
        index_min = i;
    end
end

disp('distinct pixels:')
disp(count);

[M, N] = size(image);
total_pixels = M*N;

disp('total number of pixels:')
disp(total_pixels);

disp('most frequent pixel');
disp(index_max);

disp('least frequent pixel');
disp(index_min)

brightness = mean2(image);

disp('brightness');
disp(brightness)

image_contrast = max(image(:)) - min(image(:));

disp('contrast');
disp(image_contrast)

H = entropy(image);

disp('entropy');
disp(H)

end
