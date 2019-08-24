function [bimg,c,thi] = binarizeImageAlg3(img,tlo,sigE,clist)

% B = binarizeImageAlg3(I)
% B = binarizeImageAlg3(I,tlo,sigE,clist,thilist)
%
% Algorithm 3 from "Document Binarization with Automatic Parameter Tuning"

% choose reasonable values for static parameters if they are not specified
if (nargin < 2)||isempty(tlo)
    tlo = 0.1;
end;
if (nargin < 3)||isempty(sigE)
    sigE = 0.6;
end;
if (nargin < 4)||isempty(clist)
    clist = exp(linspace(log(20),log(5120),33));
end;
if (nargin < 5)||isempty(thilist)
    thilist = [.25 .5];
end;

% compute best binarization and c at selected thi
[blo,clo] = binarizeImageAlg1(img,thilist(1),tlo,sigE,clist);
[bmid,cmid] = binarizeImageAlg1(img,mean(thilist(1:2)),tlo,sigE,clist);
[bhi,chi] = binarizeImageAlg1(img,thilist(2),tlo,sigE,clist);
dlo = sum(blo(:)~=bmid(:))./numel(bmid);
dhi = sum(bhi(:)~=bmid(:))./numel(bmid);

% return selected values
if (dlo < dhi)
    bimg = blo;
    c = clo;
    thi = thilist(1);
else
    bimg = bhi;
    c = chi;
    thi = thilist(2);
end;
