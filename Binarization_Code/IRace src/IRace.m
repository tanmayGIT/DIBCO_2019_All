function [ confs ] = IRace( dirOriginais,dirGT,execIrace,writeDir )
addpath('R:\Mestrado\ICAE Distance Perception\codigo');
n_confs=900;
w = ones(1,n_confs);
num_iter = 2+round(log2(2));
curr_iter = 0;
Nl = 30;
confs = [];
while(curr_iter <= num_iter)

   [confs] = FRace( w, Nl, confs,curr_iter,dirOriginais,dirGT,execIrace,writeDir);
   
   curr_iter = curr_iter + 1;
   [w] = update_weights(confs,n_confs);

end

end

function [w] = update_weights(confs,n_confs)
 w = zeros(n_confs,1 );
    for i = size(confs,1) : -1 : 1
        %Eq(3) FRace and Iteradetd Frace - an overview
        w(i) = (size(confs,1) - i + 1)/(size(confs,1)*(size(confs,1) + 1)/2);
        
    end
    
    
end
