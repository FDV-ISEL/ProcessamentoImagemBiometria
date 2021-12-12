classdef ImageHandler
    properties
        path 
    end
    methods
        function obj = ImageHandler(path)
            obj.path = path;
        end
        
        function res = readImage(obj, imageName)
            res = imread(strcat(obj.path, imageName));
        end
        
        
    end
    
    methods (Static)
        
        function show(figureNumber, original, noisy, improved)
            figure(figureNumber)
            imshow(original)

            figure(figureNumber + 1)
            imshow(noisy)

            figure(figureNumber + 2)
            imshow(improved)
        end
        
        function brightness(original, noisy, improved)
            b_original = mean2(original);
            b_noisy = mean2(noisy);
            b_improved = mean2(improved);

            disp("Brightness original - noisy: ")
            disp(b_original - b_noisy)

            disp("Brightness original - improved: ")
            disp(b_original - b_improved)
        end
        
        function contrast(original, noisy, improved)
            c_original = 20*log10(double(max((original(:)) + 1)/(min(original(:)) + 1)));
            c_noisy = 20*log10(double(max((noisy(:)) + 1)*1.0/(min(noisy(:)) + 1)));
            c_improved = 20*log10(double(max((improved(:)) + 1)*1.0/(min(improved(:)) + 1)));
            
            disp("Contrast original - noisy: ")
            disp(c_original - c_noisy)

            disp("Contrast original - improved: ")
            disp(c_original - c_improved)
        end
        
        function entropy(original, noisy, improved)
            H_original = entropy(original);
            H_noisy = entropy(noisy);
            H_improved = entropy(improved);

            disp("Entropy original - noisy: ")
            disp(H_original - H_noisy)

            disp("Entropy original - improved: ")
            disp(H_original - H_improved)
        end
        
        function mse(original, noisy, improved)
            disp("MSE original - noisy: ")
            disp(immse(original, noisy))

            disp("MSE original - improved: ")
            disp(immse(original, improved))
        end
        
        function mae(original, noisy, improved)
            disp("MAE original - noisy: ")
            disp(mae(original - noisy))

            disp("MAE original - improved: ")
            disp(mae(original - improved))
        end
    end
end