%
% ISEL - Instituto Superior de Engenharia de Lisboa.
% 
% MEIC - Mestrado em Engenharia Informática e de Computadores.

function main()
createImage()
end

function createImage()  
    close all
    clc
    image = 255 * ones(256, 512, 'uint8');
    generatedImg = cat(1, image);
    
    text_str = cell(3,1);
    conf_val = ['1' '2' '3' '4' '5' '6' '7' '8' '9' '0' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'X' 'Y' 'W' 'Z'];
    str=""
    diff_levels = [2,10,20];

    for ii=1:7
        N = randi(length(conf_val));
        text_str{ii} = [num2str(conf_val(N))];
        str = str + [num2str(conf_val(N))];
    end
    
    levelDiff = randi(length(diff_levels));
    disp(levelDiff)
    diff = diff_levels(levelDiff)
    disp(diff);
    
    position = [50 50;100 50;150 50;200 50;250 50;300 50;350 50;]
    colors = {'black','black','black','black','white','cyan','green','yellow','red','blue'}
    N = length(colors)
    colorN = randi(N)
    textColorRandomized = colors(colorN)
    RGB = insertText(generatedImg,position,text_str,'FontSize',72,'BoxColor','white','BoxOpacity',0,'TextColor',textColorRandomized,'Font','arial black');
    H = fspecial('motion',diff,diff); %MOTION
    
    MotionBlur = imfilter(RGB,H,'replicate');
    fh = figure;
    imshow(MotionBlur);
    title = strcat('Concat: ',string(levelDiff))
    set(fh,'Name',title)
    imwrite(MotionBlur,'CaptchaCode.png')
    prompt = {'Type the letters:'};
    dlgtitle = 'Captcha Code';
    dims = [1 35];
    definput = {''};
    answer = upper(inputdlg(prompt,dlgtitle,dims,definput))
    
    disp(str);
    disp(answer);
    
    if str == answer
        msgbox("Código correto!")
        correctAnswer = true;
    else
        msgbox("Código incorreto!")
    end

end




