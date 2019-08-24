function featureMatNiblackOrig = MultipleThresholdVoteBinarization(S_s_pOriginal, imagGray_Original, winY, winX)
% contrastImgOrig = BolaSuTextPixel(S_s_pOriginal, imagGray_Original, winY, winX);

% featureMatSavoulaOrig = SavoulaSuTextPixel(S_s_pOriginal, imagGray_Original,  winY, winX);
% featureMatNiblackOrig = NiblackJustFeatureTextPixel(S_s_pOriginal, imagGray_Original,  winY, winX);

featureMatNiblackOrig = GetOnlySimpleNiBlackFeatures(imagGray_Original);
end


function outputNiblack = GetOnlySimpleNiBlackFeatures(image, varargin)
% Initialization
numvarargs = length(varargin);      % only want 4 optional inputs at most
if numvarargs > 4
    error('myfuns:somefun2Alt:TooManyInputs', ...
     'Possible parameters are: (image, [m n], k, offset, padding)');
end
 
optargs = {[3 3] -0.2 0 'replicate'};   % set defaults
 
optargs(1:numvarargs) = varargin;   % use memorable variable names
[window, k, offset, padding] = optargs{:};

if ndims(image) ~= 2
    error('The input image must be a two-dimensional array.');
end

% Convert to double
image = double(image);

% Mean value
mean = averagefilter(image, window, padding);

% Standard deviation
meanSquare = averagefilter(image.^2, window, padding);
deviation = (meanSquare - mean.^2).^0.5;

% Initialize the output
outputNiblack = zeros(size(image));

% Niblack .    th = m + k*s;
outputNiblack =  mean + ((k * deviation) - offset);

end

function contrastImg = BolaSuTextPixel(S_s_pOriginal, imagGray_Original, windowYFull, windowXFull)

winX = floor(windowXFull/2);
winY = floor(windowYFull/2);

S_s_p_Padded = padarray(S_s_pOriginal,[ winX winY],'replicate');
imagGray_Padded = padarray(imagGray_Original,[ winX winY],'replicate');

epsilonSU = 0.001;
contrastImg = zeros(size(S_s_p_Padded));

for ii = (winY+1):1:(size(S_s_p_Padded,1)-winY)
    for jj = (winX+1):1:(size(S_s_p_Padded,2)-winX)
        if( (S_s_p_Padded(ii, jj) == 1) )
            keepAllEle = zeros(8,1);
            cnt = 1;
            for k = -winY:1:winY % go in surround
                for j = -winX:1:winX % go in surround
                    if ((k ~= 0) || (j ~= 0) ) % To avoid the center pixel
                        tempVal = imagGray_Padded(ii+k,jj+j);
                        keepAllEle(cnt,1) = tempVal;
                        cnt = cnt +1;
                    end
                end
            end
            minVal = min(keepAllEle);
            maxVal = max(keepAllEle);
            
            C_ij = (maxVal - minVal) / ((maxVal + minVal) + epsilonSU);
            contrastImg(ii,jj) = C_ij;
        end
        
    end
end
contrastImg = contrastImg((winY+1):(size(S_s_p_Padded,1)-winY), (winX+1):(size(S_s_p_Padded,2)-winX));
end


function featureMat = SavoulaSuTextPixel(S_s_pOriginal, imagGray_Original,  windowYFull, windowXFull)
S_savoula = 128;
winX = floor(windowXFull/2);
winY = floor(windowYFull/2);

S_s_p_Padded = padarray(S_s_pOriginal,[ winX winY],'replicate');
imagGray_Padded = padarray(imagGray_Original,[ winX winY],'replicate');

featureMat  = zeros(size(imagGray_Padded,1), size(imagGray_Padded,2));

for ii = (winY+1):1:(size(S_s_p_Padded,1)-winY)
    for jj = (winX+1):1:(size(S_s_p_Padded,2)-winX)
        if( (S_s_p_Padded(ii, jj) == 1) )
            
            
            %% get the mean and std from neighborhood
            keepAllEle = zeros(8,1);
            cnt = 1;
            for k = -winY:1:winY
                for j = -winX:1:winX
                    if ((k ~= 0) || (j ~= 0) )
                        tempVal = imagGray_Padded(ii+k,jj+j);
                        keepAllEle(cnt,1) = tempVal;
                        cnt = cnt +1;
                    end
                end
            end
            meanVal = mean(keepAllEle);
            makeSquareDiv = std(keepAllEle);
            %%
            
            
            
            
            
            tempVal = ((imagGray_Padded(ii,jj) / meanVal) -1 ) / ((makeSquareDiv / S_savoula) - 1);
            exponentialNiblack = exp(double(-tempVal));
            if (makeSquareDiv > S_savoula)
                featureMat(ii,jj) = 0 ;
            else
                denoVal = double((1.0 + exponentialNiblack));
                tempValGoFor = power(denoVal,(-1));
                featureMat(ii,jj) = tempValGoFor;
            end
        end
    end
end
featureMat = featureMat((winY+1):(size(S_s_p_Padded,1)-winY), (winX+1):(size(S_s_p_Padded,2)-winX));
end

function [featureMat] = NiblackJustFeatureTextPixel(S_s_pOriginal, imagGray_Original,  windowYFull, windowXFull)
windowXFull = 2 * windowXFull;
windoYFull = 2 * windowYFull;

winX = floor(windowXFull/2);
winY = floor(windoYFull/2);

S_s_p_Padded = padarray(S_s_pOriginal,[ winX winY],255,'replicate');
imagGray_Padded = padarray(imagGray_Original,[ winX winY],'replicate');

featureMat  = zeros(size(imagGray_Padded,1), size(imagGray_Padded,2));
kParam = 0.6;

for ii = (winY+1):1:(size(S_s_p_Padded,1)-winY)
    for jj = (winX+1):1:(size(S_s_p_Padded,2)-winX)
        if( (S_s_p_Padded(ii, jj) == 0) )
            
            % get the mean and std from neighborhood
            keepAllEle = zeros(8,1);
            cnt = 1;
            for k = -winY:1:winY
                for j = -winX:1:winX
                    if ((k ~= 0) || (j ~= 0) )
                        tempVal = imagGray_Padded(ii+k,jj+j);
                        keepAllEle(cnt,1) = tempVal;
                        cnt = cnt +1;
                    end
                end
            end
            meanVal = mean(keepAllEle);
            makeSquareDiv = std(keepAllEle);
         
            featureMat(ii,jj) = meanVal + (kParam * makeSquareDiv); % threshold value
            
        end
    end
end
featureMat = featureMat((winY+1):(size(S_s_p_Padded,1)-winY), (winX+1):(size(S_s_p_Padded,2)-winX));

end



function [featureMat, I_binImage] = NiblackTextPixel(S_s_pOriginal, imagGray_Original,  windowYFull, windowXFull)
windowXFull = 2 * windowXFull;
windoYFull = 2 * windowYFull;

winX = floor(windowXFull/2);
winY = floor(windoYFull/2);

S_s_p_Padded = padarray(S_s_pOriginal,[ winX winY],'replicate');
imagGray_Padded = padarray(imagGray_Original,[ winX winY],'replicate');


binImage_N = zeros(size(imagGray_Padded,1), size(imagGray_Padded,2));
featureMat  = zeros(size(imagGray_Padded,1), size(imagGray_Padded,2));
kParam = 0.6;
I_binImage = zeros(size(imagGray_Padded,1), size(imagGray_Padded,2));

for ii = (winY+1):1:(size(S_s_p_Padded,1)-winY)
    for jj = (winX+1):1:(size(S_s_p_Padded,2)-winX)
        if( (S_s_p_Padded(ii, jj) == 1) )
            
            %% get the mean and std from neighborhood
            keepAllEle = zeros(8,1);
            cnt = 1;
            for k = -winY:1:winY
                for j = -winX:1:winX
                    if ((k ~= 0) || (j ~= 0) )
                        tempVal = imagGray_Padded(ii+k,jj+j);
                        keepAllEle(cnt,1) = tempVal;
                        cnt = cnt +1;
                    end
                end
            end
            meanVal = mean(keepAllEle);
            makeSquareDiv = std(keepAllEle);
            %%
            
            featureMat(ii,jj) = meanVal + (kParam * makeSquareDiv); % threshold value
            
            for k = -winY:1:winY
                for j = -winX:1:winX
                   if( imagGray_Padded(ii+k,jj+j) < featureMat(ii,jj))
                       binImage_N(ii+k,jj+j) = binImage_N(ii+k,jj+j) +1;
                   else
                       binImage_N(ii+k,jj+j) = binImage_N(ii+k,jj+j) -1;
                   end
                end
            end
            
        end
    end
end

I_binImage(binImage_N > 0) = 1;

I_binImage = I_binImage((winY+1):(size(S_s_p_Padded,1)-winY), (winX+1):(size(S_s_p_Padded,2)-winX));
featureMat = featureMat((winY+1):(size(S_s_p_Padded,1)-winY), (winX+1):(size(S_s_p_Padded,2)-winX));

end
