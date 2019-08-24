function [ m ] = tmap( img )

    [h w] = size(img);
    d = floor(2*(0.15*w));
    acc = 0;
    map = double(img);
    
    for i = 2 : h
        for j = 1 :w
            acc = 0;
            
            for jan = -d : d
               
               if(j+jan-1 >= 1 && j+jan <= w)
                  if(img(i,j+jan-1) ~= img(i,j+jan)) 
                  acc = acc + 1;
                  end
               end
            end;
            map(i,j) = acc;
        end;
    end
  o = otsu(map,-1);
  m = o;
  for n = 1 : 20
    m = imfilter(m,fspecial('average',7));
  end
    

end

