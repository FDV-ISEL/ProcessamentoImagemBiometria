function Ex4_squares()

% TODO Erro aumenta nesta ._.
% TODO N�o consigo calcular MSE nem MAE
% Problemas acima ^ devem-se � rota��o da imagem que aumenta os pixeis preto (aumenta o erro)
% e modifica as dimens�es da imagem (imposs�vel calcular MSE e MAE) 

handler = ImageHandler('../NoisyImages/');


original = handler.readImage('squares.gif');
noisy = handler.readImage('squares_1.gif');

improved = medfilt2(noisy);

handler.show(original, noisy, improved);
handler.brightness(original, noisy, improved);
handler.contrast(original, noisy, improved);
handler.entropy(original, noisy, improved);
% must have the same size to calculate mse and mae
% handler.mse(original, noisy, improved);
% handler.mae(original, noisy, improved);

end