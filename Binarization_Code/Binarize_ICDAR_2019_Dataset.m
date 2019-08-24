clear;
close all
clc

allImgFolderPath = 'C:\Users\Tanmoy\Desktop\Tanmoy_Selection_Cropped\OrigImgDataset_2\';

savingDir = 'C:\Users\Tanmoy\Desktop\Tanmoy_Selection_Cropped\BinImages\Howe\';

% savingDir1 = 'C:\Users\Tanmoy\Desktop\Tanmoy_Selection_Cropped\BinImages\niblack\';
% savingDir2 = 'C:\Users\Tanmoy\Desktop\Tanmoy_Selection_Cropped\BinImages\savoula\';
% savingDir3 = 'C:\Users\Tanmoy\Desktop\Tanmoy_Selection_Cropped\BinImages\dynamic_window\';
% savingDir4 = 'C:\Users\Tanmoy\Desktop\Tanmoy_Selection_Cropped\BinImages\wolf_jolin\';

addpath('.\RGMesquita_CABMello\IRACE+POD_H src\POD_H');

S = [dir(fullfile(allImgFolderPath,'*.tiff'));dir(fullfile(allImgFolderPath,'*.tif'));...
    dir(fullfile(allImgFolderPath,'*.jpg'));dir(fullfile(allImgFolderPath,'*.png'));
    dir(fullfile(allImgFolderPath,'*.bmp'))]; % pattern to match filenames.

% use parfor instead for -- for parallel processing
for k = 1:numel(S)
    fullFilePath = fullfile(allImgFolderPath,S(k).name);  % read the image file from GT
    origImg = imread(fullFilePath);
    if(size(origImg,3)== 3)
        origImg = rgb2gray(origImg);
    end
    
    [binImg] = mainDP(origImg);
    savingFullNm = strcat(savingDir, S(k).name);
    
%     [outputNiblack, outputSavoula, outputWolfJolin, outputDynamicWindow] = ...
%                     LocalWindowBasedBinarization(origImg, [5 5], -0.2, 0, 'replicate');
%     savingFullNm1 = strcat(savingDir1, S(k).name);
%     savingFullNm2 = strcat(savingDir2, S(k).name);
%     savingFullNm3 = strcat(savingDir3, S(k).name);
%     savingFullNm4 = strcat(savingDir4, S(k).name);
%     
%     imwrite(outputNiblack, savingFullNm1);
%     imwrite(outputSavoula, savingFullNm2);
%     imwrite(outputWolfJolin, savingFullNm3);
%     imwrite(outputDynamicWindow, savingFullNm4);
end
