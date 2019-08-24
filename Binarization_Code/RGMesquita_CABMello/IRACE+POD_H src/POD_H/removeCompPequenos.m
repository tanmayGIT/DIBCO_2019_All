function [ img ] = removeCompPequenos( img, n )

img = ~img;
labels = bwlabel(img);

for i = 1 : max(max(labels))

 numOcorrencias = numel(find(labels == i));
 
 if(numOcorrencias <= n)
    
    img(find(labels == i)) =  0;
     
 end
 
 
end

img = ~img;

end
