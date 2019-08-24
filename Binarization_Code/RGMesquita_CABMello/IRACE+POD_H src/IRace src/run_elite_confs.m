addpath('R:\Mestrado\ICAE Distance Perception\codigo');

confs_irace = [

18,21,1,0.9028

22,12,1,0.90027

25,17,1,0.90628

28,19,1,0.89952

27,11,1,0.90116

25,24,1,0.90486

18,20,1,0.89897

25,24,1,0.90486

19,21,1,0.90169

10,22,1,0.90219



    ];


dirOriginais = 'R:\Doutorado\Base DIBCO\2011\originais\';
dirGT = 'R:\Doutorado\Base DIBCO\2011\GT\';
files = dir(dirOriginais);
filesGT = dir(dirGT);

tic;
fms_confs = zeros(size(confs_irace,1),1);
for n = 3 : numel(files)
   
    gt = imread([dirGT filesGT(n).name]);
    for ind_conf = 1 : size(confs_irace,1)
    res = mainDP(dirOriginais, files(n).name,confs_irace(ind_conf,1),confs_irace(ind_conf,2));
    fms_confs(ind_conf) = fms_confs(ind_conf)+FMeasure(gt,res);
    %mkdir(['R:\Doutorado\Expert Systems with Applications - IRace DP\conjunto elite ICAE 2013\' num2str(confs_irace(ind_conf,1)) '_' num2str(confs_irace(ind_conf,2)) '\']);
    %imwrite(res,['R:\Doutorado\Expert Systems with Applications - IRace DP\conjunto elite ICAE 2013\' num2str(confs_irace(ind_conf,1)) '_' num2str(confs_irace(ind_conf,2)) '\' filesGT(n).name]);
    end
    

end
toc;
'min'
confs_irace(find(fms_confs==min(fms_confs)),1)
confs_irace(find(fms_confs==min(fms_confs)),2)
confs_irace(find(fms_confs==min(fms_confs)),3)
'medio'
confs_irace(find(fms_confs==median([0;fms_confs])),1)
confs_irace(find(fms_confs==median([0;fms_confs])),2)
confs_irace(find(fms_confs==median([0;fms_confs])),3)
'max'
confs_irace(find(fms_confs==max(fms_confs)),1)
confs_irace(find(fms_confs==max(fms_confs)),2)
confs_irace(find(fms_confs==max(fms_confs)),3)


