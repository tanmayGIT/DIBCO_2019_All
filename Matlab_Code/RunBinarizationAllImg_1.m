function L_p_ForeGround_Image = RunBinarizationAllImg_1(origImg, fullFilePath)

[~,NameOnly,extOnly] = fileparts(fullFilePath);
edgImgpath = 'Dataset/All_Results_Grad/';
getEdgeImgFullpath = strcat(edgImgpath,NameOnly, extOnly);


% origImg = imread(imgPath);
if(size(origImg,3)==3)
    origImg = rgb2gray(origImg);
end

origImg = OnlyApplyClustering(origImg); % obtained after clustering 
strokeWidth = CalculateStrokeWidth(origImg);

% [~, fSure_and_ConfusedTextPixels] = SeperateClustersCreateImageForBin(origImg);
fSure_and_ConfusedTextPixels = origImg;

 allUniqueVals = unique(fSure_and_ConfusedTextPixels); % get the unique values
% [~, thetaGradImage] = GradientComputation(origImg); % do gradient computation on full image

% Applly otsu binarization
% level = graythresh(origImg);
% binGrad_Complete_Img = imbinarize(origImg,level); % binarize full image
% binGrad_Complete_Img = imread(getEdgeImgFullpath);
% binGrad_Complete_Img = logical((binGrad_Complete_Img/255));



% After the above processing, the potential SSP is extracted: the binarized gradient image (binGrad_Complete_Img)
% indicates its positions and the  original image I (origImg) indicates the intensities.
tic;
% S_p = binGrad_Complete_Img;
% featureMatOrig = MultipleThresholdVoteBinarization(S_p, origImg, strokeWidth, strokeWidth);
% featureMatOrig = MultipleThresholdVoteBinarization(S_p, origImg, strokeWidth, strokeWidth);



winX = round(strokeWidth/2);
winY = round(strokeWidth/2);

% Judging the density of potential SSP
% S_p_Padded = padarray(S_p,[ winX winY],'replicate');
% thetaGradImage_Padded = impad(thetaGradImage, winX,'replicate');
% featureMatOrig_Padded = impad(featureMatOrig, winX,'replicate');
% NormImag_Padded = impad(origImg, winX,'replicate');

fSureConfusedTextPixelsPadded = impad(fSure_and_ConfusedTextPixels, winX, 'replicate');




% Assume that all pixels of the image are foreground pixels (1s)
L_p_ForeGround_Image = zeros(size(origImg));
for ii = 1:1:(size(origImg,1))
    for jj = 1:1:(size(origImg,2))
        if (  (fSureConfusedTextPixelsPadded(ii,jj) == allUniqueVals(1)) )% for the sure pixels
            L_p_ForeGround_Image(ii,jj) = 1; % make it foreground pixels
        end
    end
end



% checkingVal = allUniqueVals(2);
% [L_p_ForeGround_Image_1, S_p_Padded] = PerformSymmetryOperation_3(S_p_Padded, ...
%                         thetaGradImage_Padded, NormImag_Padded, ...
%                             fSureConfusedTextPixelsPadded, L_p_ForeGround_Image, checkingVal, winX, winY,strokeWidth, featureMatOrig_Padded );
% 
% 
% checkingVal = allUniqueVals(3);
% strongPixels = L_p_ForeGround_Image_1;
% [L_p_ForeGround_Image, S_p_Padded] = PerformSymmetryOperation_4(S_p_Padded, ...
%                         thetaGradImage_Padded, NormImag_Padded, ...
%                             fSureConfusedTextPixelsPadded, strongPixels, checkingVal, winX, winY,strokeWidth, featureMatOrig_Padded );

% L_p_ForeGround_Image = L_p_ForeGround_Image((winY+1):(size(S_p_Padded,1)-winY), (winX+1):(size(S_p_Padded,2)-winX));

refinedImage = CleanImageFinally (L_p_ForeGround_Image, strokeWidth);
Time3=toc;
disp(strcat('running time of remaining is: ',num2str(Time3)))

L_p_ForeGround_Image = imcomplement(refinedImage);
% figure, imshow(L_p_ForeGround_Image);

return;
end