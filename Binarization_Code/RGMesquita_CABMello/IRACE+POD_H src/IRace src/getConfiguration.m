function [ ang_new, raio_new,drd ] = getConfiguration(w,i,confs)
 drd = 1;
 std = 1-2*i/10;
 if std < 0.1
     std = 0.1;
 end
 
 if(size(confs) == [0,0])
   wang = [1:1:30];
   wraio = [1:1:30];
   
 else
 c = randsample(900,1,1,w);
  
  ang = confs(c,1);
  raio = confs(c,2);
  
  
 wang = normpdf(ang,[1:1:30],std);
 wraio = normpdf(raio,[1:1:30],std);
 
 end
 
 numang = [1 : 1 : 30];
 ang_new = randsample(numang,1,1,wang);
 
 numraio = [1 : 1 : 30];
 raio_new = randsample(numraio,1,1,wraio);
 
 

end

% %  numang = [1 : 1 : 30];
% %  ang = randsample(numang,1,1,wang);
% %  numraio = [1 : 1 : 30];
% %  raio = randsample(numraio,1,1,wraio);
% %  numdrd = [1 : 1 : 1];
% %  drd = randsample(numdrd,1,1,wdrd);
%  c = randsample(900,1,1,w);
%  ang = floor(c/30)+1;
%  raio = mod(c,30);
%  if(raio == 0)
%      ang = ang-1;
%      raio = 30;
%  end
%  wang = normpdf(ang/10,[0.1:0.1:3],std);
%  wraio = normpdf(raio/10,[0.1:0.1:3],std);
% 
%  numang = [1 : 1 : 30];
%  ang_new = randsample(numang,1,1,wang);
%  
%  numraio = [1 : 1 : 30];
%  raio_new = randsample(numraio,1,1,wraio);
 
%end

