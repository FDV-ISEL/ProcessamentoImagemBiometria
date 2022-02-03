function ex1a()

image = imread('captcha_4.png');
txt = ocr(image);

disp(txt.Text);

end