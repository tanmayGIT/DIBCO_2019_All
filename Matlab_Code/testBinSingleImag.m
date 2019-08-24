clear 
% close
clc
addpath 'FRFCM/';    
origImg = imread('/Users/tmondal/Documents/MATLAB/DIBCO_2019_All/DIBCO_2019_Work/OrigImgDataset_2/P. Laur. IV 128 r.jpg');

L_p_ForeGround_Image = RunBinarizationAllImg_1(origImg, '/Users/tmondal/Documents/MATLAB/DIBCO_2019_All/DIBCO_2019_Work/OrigImgDataset_2/P. Laur. IV 128 r.jpg');
figure, imshow(L_p_ForeGround_Image);