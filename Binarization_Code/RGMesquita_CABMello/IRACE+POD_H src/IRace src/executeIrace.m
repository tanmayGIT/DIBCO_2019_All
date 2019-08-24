%text file with configurations resulted from IRACE search process
camTxt = 'R:\Doutorado\Expert Systems with Applications - IRace DP\test experiments ICAE 2011\tunning\data\IRACE_eliteConfResults.txt';
mkdir('R:\Doutorado\Expert Systems with Applications - IRace DP\test experiments ICAE 2011\tunning\data\');
dlmwrite(camTxt,'FMeasure:\n','-append');

%directory in which results from each tested configurations will be written
writeDir = 'R:\Doutorado\Expert Systems with Applications - IRace DP\test experiments ICAE 2011\';
%directory containing input document images   
dirOriginais = 'R:\Doutorado\Base DIBCO\2011\originais\';
%GROUND-TRUTH directory
dirGT = 'R:\Doutorado\Base DIBCO\2011\GT\';     
tic;
%Only one IRACE execution, just for test purposes. 
for i = 1 : 1
    
    dlmwrite(camTxt,num2str(i),'-append');
    
    confs = IRace(dirOriginais,dirGT,i,writeDir);
    
    confs
    
    
    dlmwrite(camTxt,confs,'-append');
end
toc;



