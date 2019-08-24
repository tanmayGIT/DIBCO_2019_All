function [ imgDP ] = combinacao_bin( imgDP,imgNib, raio )

if(nargin == 2)
    raio = 1;
end;
if(size(imgDP) ~= size(imgNib))
 error('imagens com dimensoes diferentes!');
 return;
end

if(ndims(imgDP) == 3)
    imgDP = rgb2gray(imgDP);
end

if(ndims(imgNib) == 3)
    imgNib = rgb2gray(imgNib);
end



imgNib = ~imgNib;
imgDPoriginal = imgDP;
imgDP = ~imgDP;

while(1)

    imgCmp = imgDP;
    imgDP = imdilate(imgDP,strel('disk',raio));
    %imgDP(e == 1)= 0;
    imgDP = imgDP & imgNib;
    

    if(imgDP == imgCmp)

        break;
    end
end
imgDPoriginal = ~imgDPoriginal;
imgDP = imgDP | imgDPoriginal;

imgDP = ~imgDP;

end

