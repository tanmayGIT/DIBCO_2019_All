function [ confs,Ns ] = FRace( w, Nl,confs,curr_iter,dirOriginais,dirGT,execIrace, writeDirectory )

camTxt = [writeDirectory 'IRACE_experimentos_tunning_vICAE2013_10it_execIRace' num2str(execIrace) '_.txt'];
mkdir(writeDirectory);


files = dir(dirOriginais);
filesGT = dir(dirGT);
stop_criterion = 2+round(log2(2));

  Nmin = round(0.5*Nl);
  Nl = round(Nl);
  confs_temp = confs; 
 %Each time you use 'shuffle', it reseeds the generator with a different seed
 rng 'shuffle';
  for n = size(confs_temp,1)+1 : Nl
    [confs(n,1),confs(n,2),confs(n,3)] = getConfiguration(w,curr_iter,confs_temp);
    dlmwrite(camTxt,[confs(n,1) confs(n,2)],'delimiter','\t','-append');
  end
  
  
%   'confs inicio frace'
% confs
fobj = zeros(size(confs,1),1);

for n = 3 : numel(files)
   
    gt = imread([dirGT filesGT(n).name]);
    %img = imread([dirOriginais files(n).name]);
    
    
    
    
    
    
    for configuracao = 1 : size(confs,1)
       mkdir([writeDirectory num2str(confs(configuracao,1)) '_' num2str(confs(configuracao,2)) '_' num2str(confs(configuracao,3))]);
       dirEscritaTemp = [writeDirectory num2str(confs(configuracao,1)) '_' num2str(confs(configuracao,2)) '_' num2str(confs(configuracao,3)) '\' files(n).name];
       %run binarization code only if a previous result from the same
       %configurations does not exist
       if(exist([writeDirectory  num2str(confs(configuracao,1)) '_' num2str(confs(configuracao,2)) '_' num2str(confs(configuracao,3)) '\' files(n).name],'file') == 0)
           res = mainDP(dirOriginais, files(n).name,confs(configuracao,1),confs(configuracao,2)); %binarization execution
       else
           res = imread([writeDirectory num2str(confs(configuracao,1)) '_' num2str(confs(configuracao,2)) '_' num2str(confs(configuracao,3)) '\' files(n).name]);
           res = im2bw(res,0.5);
           
       end
       imwrite(res,dirEscritaTemp);
       fobj(configuracao,n-2) = FMeasure(gt,res,1);    
       
       
    end
    
    %quanto maior o resultado melhor. fmeasure, p-fm e psnr
  
    [worst_confs,dif] = friedman_test(fobj,1);
    
    
    if(numel(worst_confs) == 0)
        continue;
    end

    confs(worst_confs,1) = -1;
    fobj_new = [];
    confs_new = [];
    
    for i = 1 : size(confs,1)
        if(confs(i,1) == -1)
            continue;
        end
        fobj_new = [fobj_new ; fobj(i,:)];
        confs_new = [confs_new ; confs(i,1:3)];
    end
    
    fobj = fobj_new;
    confs = confs_new;
    if(size(fobj,1) <= stop_criterion)
        break;
    end
end

 %put confs in ranking order

 rank = sum(fobj,2);
%  'rank'
%  rank
 rank = abs(rank - max(rank)); %tratamento para colocar em ordem 
 
%  'confs antes exclusao'
%  confs
 %confs = [confs mean(fobj,2)];
 confs(:,4) = mean(fobj,2);
 confs(:,5) = rank;
 
 
 confs = sortrows(confs,size(confs,2));

 confs = confs(:,1:size(confs,2)-1);
 
 Ns = min(Nmin,size(confs,1));
 
 %only the surviving confs will be returned
 confs = confs(1:Ns,:);
%  'confs dps exclusao'
%  confs

end

