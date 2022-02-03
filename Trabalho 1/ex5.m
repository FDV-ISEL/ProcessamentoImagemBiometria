%
% ISEL - Instituto Superior de Engenharia de Lisboa.
% 
% MEIC - Mestrado em Engenharia Informática e de Computadores.

function main()
createImage()
%createImage()
%createImage()
%createImage()
%createImage()
end

function createImage()  

redChannel = 135 * ones(512, 1024, 'uint8');
greenChannel = 206 * ones(512, 1024, 'uint8');
blueChannel = 235 * ones(512, 1024, 'uint8');

%generatedImg = cat(1, image);
generatedImg = cat(3, redChannel, greenChannel, blueChannel);

text_str = cell(3,1);
conf_val = ['1' '2' '3' '4' '5' '6' 'A' 'B' 'C' 'D']; 
for ii=1:10
   text_str{ii} = [num2str(conf_val(ii))];
end

for ii=11:34
    n = randi(999)
    lengthN = strlength(num2str(n))
    randCharInN = randi(lengthN)
    strN = num2str(n)
    B = convertStringsToChars(strN)
    text_str{ii} = [strN];
end
position = [150 25;300 25;450 25;600 25;750 25;900 25;50 100;50 200;50 300;50 400;
            150 100;300 100;450 100;600 100;750 100;900 100;
            150 200;300 200;450 200;600 200;750 200;900 200;
            150 300;300 300;450 300;600 300;750 300;900 300;
            150 400;300 400;450 400;600 400;750 400;900 400;

            ]; 

textColor = {}
colors = {'black','black','black','black','white','cyan','green','yellow','red','blue'}
N = length(colors)
for ii=1:34
    colorN = randi(N)
    textColor(ii) = colors(colorN)
    disp(colors(colorN))
end

RGB = insertText(generatedImg,position,text_str,'FontSize',18,'BoxColor','white','BoxOpacity',0,'TextColor',textColor);

figure
imshow(RGB)

figure
I = rgb2gray( RGB ) 
imshow(I)

end




