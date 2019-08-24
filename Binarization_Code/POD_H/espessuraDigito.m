function [ ret ] = espessuraDigito( img )

if(ndims(img)==3)
    img = rgb2gray(img);
end;

img = edge(img,'sobel','vertical');

[h,w] = size(img);
indiceAtual = 1;
borda = [,];
limiar = 50;

for i = 1:h
    for j = 1:w
        if(img(i,j) == 1)
           borda(indiceAtual,1) = i;
           borda(indiceAtual,2) = j;
           indiceAtual = indiceAtual+1;
        end;
    end;
end;

espessura = [];
for i = 1:size(borda)
  l = borda(i,1);
  c = borda(i,2);
  %procura pixel mais proximo a direita
  firstDir = -1;
  
  %tratamento para que não pegue pixels vizinhos em cadeia
  for proxViz = c+1 : w
      if(img(l,proxViz) == 1)
          continue;
      else
          break;
      end;
  end;
  
  %procura próximo vizinho a direita
  for direita = proxViz : w
      if(direita - proxViz > limiar)
        break;
      end;
      if(img(l,direita) == 1)
          firstDir = direita-proxViz;
        break;
      end;
  end;
 
  %trata para que não pegue pixels vizinhos em cadeia
  for proxViz = c-1 : -1: 1 
      if(img(l,proxViz) == 1)
          continue;
      else
          break;
      end;
  end;
  firstEsq = -1;
  %procura próximo vizinho a esquerda
  for esquerda = proxViz : -1 : 1
      if( (proxViz - esquerda > firstDir && firstDir ~= -1 )) %|| (proxViz - esquerda > limiar))
        break;
      end;
      if(img(l,esquerda) == 1)
          firstEsq = proxViz - esquerda;
        break;
      end;
  end;
  
  %armazena a menor distancia
  if(firstDir == -1 && firstEsq == -1)
      continue;
  elseif(firstDir == -1 && firstEsq ~= -1)
          menorDistancia = firstEsq;
  elseif(firstDir ~= -1 && firstEsq == -1)
          menorDistancia = firstDir;
  elseif(firstDir < firstEsq)
      menorDistancia = firstDir;
  else
      menorDistancia = firstEsq;
  end;
  
  espessura = [espessura menorDistancia];
  
end

%mode(espessura)
ret = median(espessura);
%mean(espessura)


