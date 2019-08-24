function fClusteredOrigImg = OnlyApplyClustering(NormImag)


fn = NormImag;  % imnoise(f_ori,'gaussian',0.03);
% parameters
cluster = 5; % the number of clustering centers
se = 3; % the parameter of structuing element used for morphological reconstruction
w_size = 3; % the size of fitlering window
% segment an image corrupted by noise
tic
[center1,U1,~,~] = FRFCM(double(fn),cluster,se,w_size);
Time1=toc;
disp(strcat('running time of clustering is: ',num2str(Time1)))
f_seg = fcm_image(NormImag,U1,center1);


uniqueVals = unique(f_seg, 'sorted');  

fClusteredOrigImg = f_seg;

for iRw = 1:1:size(f_seg,1)
    for jCol = 1:1:size(f_seg,2)
        if(  (f_seg(iRw,jCol) == uniqueVals(4)) || (f_seg(iRw,jCol) == uniqueVals(5)) ) % the third and fourth values are made white/background       
            fClusteredOrigImg(iRw,jCol) = uniqueVals(4);   
        end
    end
end
return;
end