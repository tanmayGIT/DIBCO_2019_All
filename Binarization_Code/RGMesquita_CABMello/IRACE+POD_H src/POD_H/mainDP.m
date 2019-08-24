function [bw_result] = mainDP_a(img)
    angulo = 22;
    difRaio = 12;
    if(ndims(img) == 3)
        img = rgb2gray(img);
    end
    espes = espessuraDigito(img);
            
    [dp]=distPercep(img,'',espes,0,angulo,difRaio);
           
    bw_result = binarizeImageAlg3(dp);
    bw_result = ~bw_result;
           
end

