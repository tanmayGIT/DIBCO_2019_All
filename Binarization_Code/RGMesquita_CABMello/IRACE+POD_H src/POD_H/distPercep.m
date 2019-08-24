function [ final_eq, im_resize] = distPercep( im, nome, espes, flagSalvar,angulo,difRaio)
raio2 = round(espes/2)+difRaio;
raio1 = round(espes/2); 
if(ndims(im) == 3)
    im = rgb2gray(im);
end;

[linhas colunas] = size(im);
imeq = im;
im_close = imclose(imclose(imeq,strel('disk',raio1)),strel('disk',raio2));

new_size_h = novaAlturaImgResize(espes,linhas,angulo);

if(new_size_h <= 0)
    new_size_h = 1;
end;

new_size_w = (colunas*(new_size_h/linhas));
im_downsize = imresize(im_close,[new_size_h new_size_w], 'bilinear');
im_resize = imresize(im_downsize,[linhas colunas], 'bilinear');
dif = abs(im_resize - imeq);



smaller_to_white = dif;
for i=1:linhas
    for j=1:colunas
        if(smaller_to_white(i,j)==0)
            smaller_to_white(i,j)=255;
        end;
    end;
end;


negate = smaller_to_white;
for i=1:linhas
    for j=1:colunas
        
        if(negate(i,j)~=255)
            negate(i,j)=255-negate(i,j);
        end;
    end;
end;

        



final_eq=imadjust(negate);

if(flagSalvar == 1)
    
    mkdir(nome);
    imwrite(imeq,strcat(nome,'\\1res_im.bmp'));
    imwrite(im_close,strcat(nome,'\\2res_im_close.bmp'));
    imwrite(im_downsize,strcat(nome,'\\3res_im_down.bmp'));
    imwrite(im_resize,strcat(nome,'\\4res_im_resize.bmp'));
    imwrite(dif,strcat(nome,'\\5res_dif.bmp'));
    imwrite(smaller_to_white,strcat(nome,'\\6res_smaller_to_white.bmp'));
    imwrite(negate,strcat(nome,'\\7res_negate.bmp'));
    imwrite(final_eq,strcat(nome,'\\8res_final_eq.bmp'));

end






end

function [hi] = novaAlturaImgResize(espes,ho,angulo)
    %distancia focal cornea-lente
    f = 0.017;
    %espessura, em metros, do TRAÇO do caractere
    alturaTracoCaracter = (espes*0.001)/4;% 4px ~= 0.001m
    %distancia do objeto - MAR utilizado = 1' ~= 0,01666º
    do = alturaTracoCaracter / tand(angulo/60);
    %distancia da imagem projetada
    di = (f*do)/(do-f);
    %altura da imagem convertida para metros
    ho = ho*0.001/4;
    %altura da imagem na retina
    hi = (di*ho/do);
    %altura da imagem convertida para pixels
    hi = round(hi*4/0.001);
end

