classdef FingerprintExtraction
    
    properties
        NOT_MINUTIE
        TERMINATION
        BIFURCATION
        dataset
    end
    
    methods
        function obj = FingerprintExtraction()
            obj.NOT_MINUTIE = 0;
            obj.TERMINATION = 1;
            obj.BIFURCATION = 2;
            obj.dataset = containers.Map('KeyType','char','ValueType','any');
        end
        
        function image = readImage(~, imageName)
            image = imread(imageName);
        end
        
        function enhanced = enhanceCapacitive(~, image)

            P = size(image,1) * 2;
            Q = size(image,2) * 2;

            imagePadded = padarray(image,[P/2 Q/2], 0, 'post');
            frequencyImage = fftshift(fft2(imagePadded));

            H = ones( P, Q );
            for u=1 : P
                for v=1 : Q
                    d = sqrt( (u - P/2)^2 + (v - Q/2)^2);
                    if d > 30 && d < 60
                        H(u,v)=0;
                    end
                end
            end 

            G = frequencyImage.*H;

            enhancedPadded = ifft2(ifftshift(G));
            enhancedPadded = uint8(real(enhancedPadded));

            enhanced = enhancedPadded(1:P/2, 1:Q/2);
        end
        
        function enhanced = enhanceOptical(~, image)

            P = size(image,1) * 2;
            Q = size(image,2) * 2;

            imagePadded = padarray(image,[P/2 Q/2], 0, 'post');
            frequencyImage = fftshift(fft2(imagePadded));

            H = ones( P, Q );
            for u=1 : P
                for v=1 : Q
                    d = sqrt( (u - P/2)^2 + (v - Q/2)^2);
                    if d > 60 && d < 90
                        H(u,v)=0;
                    end
                end
            end 

            G = frequencyImage.*H;

            enhancedPadded = ifft2(ifftshift(G));
            enhancedPadded = uint8(real(enhancedPadded));

            enhanced = enhancedPadded(1:P/2, 1:Q/2);
            
            se = strel('square', 2);
            enhanced = imdilate(enhanced, se);
            
        end
        
        function enhanced = enhance(obj, image, isCapacitive)
            if isCapacitive
                enhanced = obj.enhanceCapacitive(image);
            else
                enhanced = obj.enhanceOptical(image);
            end
        end
        
        function imageBin = binarize(~, image)
            imageBin = imbinarize(image);
        end
        
        function roi = roi(~, image)
            
            se = strel('square',7);
            roi = imclose(~image, se);
            
            roi = imfill(roi,'holes');
            roi=bwareaopen(roi,5);
            roi([1 end],:)=0;
            roi(:,[1 end])=0;
            
            se = strel('disk',17);
            roi = imerode(roi, se);
            
        end
        
        function imageThin = thin(~, imageBin)
            imageThin = ~bwmorph(imageBin,'thin', Inf);
        end
        
        function minutiae = minutiae(obj, window)
            
            % contar o numero de uns menos o pixel central
            numberOfOnes = sum(window(:) == 1) - 1;
            
            if (window(2, 2) ~= 1)
                minutiae = obj.NOT_MINUTIE;
            elseif (numberOfOnes == 1)
                minutiae = obj.TERMINATION;
            elseif (numberOfOnes == 3)
                minutiae = obj.BIFURCATION;
            else
                minutiae = obj.NOT_MINUTIE;
            end
            
        end
        
        function minutiaeTypes = minutiaeTypes(obj, imageThin)
            minutiaeTypes = nlfilter(imageThin, [3 3], @obj.minutiae);
        end
        
        function [terminations, bifurcations] = compareTermWithBif(~, terminations, bifurcations, D)
            
            [rowsT, columnsT, ~] = find(terminations == 1);
            [rowsB, columnsB, ~] = find(bifurcations == 1);
            
            for indexT = 1 : length(rowsT)
                rowT = rowsT(indexT);
                columnT = columnsT(indexT);
                
                for indexB = 1 : length(rowsB)
                    rowB = rowsB(indexB);
                    columnB = columnsB(indexB);
                  
                    distance = sqrt(power(columnB - columnT, 2) + power(rowB - rowT, 2));
                    if distance < D
                        terminations(rowsT, columnT) = 0;
                        bifurcations(rowB, columnB) = 0;
                    end
                end
            end
        end
        
        function minutiae = compareMinutiaeSameType(~, minutiae, Dmin, Dmax)
            [rows, columns, ~] = find(minutiae == 1);
            
            for index1 = 1 : length(rows)
                row1 = rows(index1);
                column1 = columns(index1);
                
                for index2 = 1 : length(rows)
                    row2 = rows(index2);
                    column2 = columns(index2);
                    
                    if row1 == row2 && column1 == column2
                        continue
                    end
                    
                    distance = sqrt(power(column2 - column1, 2) + power(row2 - row1, 2));
                    if distance > Dmin && distance < Dmax
                        minutiae(row1, column1) = 0;
                    end
                end
            end
        end
        
        function [terminations, bifurcations] = cleanMinutiae(obj, terminations, bifurcations)
           
            Dmax = 8;
            
            [terminations, bifurcations] = obj.compareTermWithBif(terminations, bifurcations, Dmax);
            
            Dmin = 0; Dmax = 10;
            terminations = obj.compareMinutiaeSameType(terminations, Dmin, Dmax);
            
            Dmin = 3;
            bifurcations = obj.compareMinutiaeSameType(bifurcations, Dmin, Dmax);
        end
        
        function [t, b] = process(obj, imageName, isCapacitive)
            
            % image process
            image = obj.readImage(imageName);
            enhanced = obj.enhance(image, isCapacitive);
            imageBin = obj.binarize(enhanced);
            imageThin = obj.thin(~imageBin);
            
            % minutiae
            minutiaeTypes = obj.minutiaeTypes(~imageThin);
            terminations = (minutiaeTypes == obj.TERMINATION);
            bifurcations = (minutiaeTypes == obj.BIFURCATION);
            
            [terminations, bifurcations] = obj.cleanMinutiae(terminations, bifurcations);
            [rowsT, columnsT, ~] = find(terminations == 1);
            [rowsB, columnsB, ~] = find(bifurcations == 1);
            
            roi = obj.roi(imageBin);
            [rowsRoi, columnsRoi, ~] = find(roi == 1);
            
            index = inpolygon(columnsT,rowsT,columnsRoi,rowsRoi);
            columnsT = columnsT(index);
            rowsT = rowsT(index);
            
            index = inpolygon(columnsB,rowsB,columnsRoi,rowsRoi);
            columnsB = columnsB(index);
            rowsB = rowsB(index);
            
            t = cat(2, rowsT, columnsT);
            b = cat(2, rowsB, columnsB);
            
%             figure(1);
%             imshow(imageThin);
% 
%             hold on
%             plot(columnsT,rowsT,'ro')
%             plot(columnsB,rowsB,'go')
        end
        
        function extract(obj, imageName, isCapacitive)
            
            [t, b] = obj.process(imageName, isCapacitive);
            
            keySet = {'terminations', 'bifurcations'};
            valueSet = {t, b};
            
            obj.dataset(imageName) = containers.Map(keySet, valueSet);
            disp(strcat('> Registered: ', imageName));
            
        end
        
        function imageNameFound = identify(obj, imageName, isCapacitive)
            imageNameFound = 'Unknown';
            
            [t, b] = obj.process(imageName, isCapacitive);
            termSize = size(t); bifSize = size(b);
            
            k = keys(obj.dataset);
            v = values(obj.dataset);
            
            for i = 1:length(obj.dataset)
                minutiaeMap = v{i};
                
                terminations = minutiaeMap('terminations');
                bifurcations = minutiaeMap('bifurcations');
                
                if ~isequal(size(terminations), termSize) || ~isequal(size(bifurcations), bifSize)
                    continue;
                end
                
                if isequal(terminations, t) && isequal(bifurcations, b)
                    imageNameFound = k{i};
                    break;
                end
                
            end
        end
        
        function userExists = authenticate(obj, imageRegistered, imageInput, isCapacitive)
            userExists = false;
            
            [t, b] = obj.process(imageInput, isCapacitive);
            termSize = size(t); bifSize = size(b);
            
            if ~isKey(obj.dataset, imageRegistered)
                return;
            end
            
            registeredImage = obj.dataset(imageRegistered);
            terminations = registeredImage('terminations');
            bifurcations = registeredImage('bifurcations');
            
            if ~isequal(size(terminations), termSize) || ~isequal(size(bifurcations), bifSize)
                return;
            end
                
            if isequal(terminations, t) && isequal(bifurcations, b)
                userExists = true;
            end
        end
    end
end

