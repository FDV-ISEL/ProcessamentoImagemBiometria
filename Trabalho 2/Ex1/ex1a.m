function ex1a()

image = imread('image.png');
txt = ocr(image);

disp(txt.Text);

end