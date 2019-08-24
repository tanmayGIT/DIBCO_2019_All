function refinedImage = CleanImageFinally (binImage, strokeWidth)
% SE = strel('square',3);
% binImage = imopen(binImage,SE);

limitParam = round(strokeWidth);
binarisedImg = binImage;
CC = bwconncomp(binarisedImg);
L = labelmatrix(CC);

totalComponent = max(max(L));

HoldConnecCom  = cell(totalComponent, 1);
HoldConnecComRefined = cell(totalComponent, 1);
for Ini = 1:totalComponent
    HoldConnecCom{Ini,1}(1,1) = 0;
    HoldConnecCom{Ini,1}(1,2) = 0;
    
    HoldConnecComRefined{Ini,1}(1,1) = 0;
    HoldConnecComRefined{Ini,1}(1,2) = 0;
    
end

for ConnComX = 1:1:size(L,1)
    for ConnComY = 1:1:size(L,2)
        if (L(ConnComX,ConnComY)~=0)
            s = L(ConnComX,ConnComY);
            if(HoldConnecCom{s,1}(1,1)==0)
                HoldConnecCom{s,1}(1,1) = ConnComX;
                HoldConnecCom{s,1}(1,2) = ConnComY;
            else
                HoldConnecCom{s,1}(end+1,1) = ConnComX;
                HoldConnecCom{s,1}(end,2) = ConnComY;
            end
        end
    end
end


refinedImage = zeros(size(binImage));
for AccesEachCell = 1:1:totalComponent  
%     cntNoSSP = 0;
%     for nSz = 1:1:size(HoldConnecCom{AccesEachCell,1})
%         rwVal = HoldConnecCom{AccesEachCell,1}(nSz,1);
%         colVal = HoldConnecCom{AccesEachCell,1}(nSz,2);
%         if(sspImage(rwVal, colVal) > 0)
%             cntNoSSP = cntNoSSP +1;
%         end
%     end   
    if ( ((size((HoldConnecCom{AccesEachCell,1}),1)>= limitParam)) )
        for nSz = 1:1:size(HoldConnecCom{AccesEachCell,1})
            rwVal = HoldConnecCom{AccesEachCell,1}(nSz,1);
            colVal = HoldConnecCom{AccesEachCell,1}(nSz,2);
            refinedImage(rwVal, colVal) = 1;
        end
    end
    
end
return;
end