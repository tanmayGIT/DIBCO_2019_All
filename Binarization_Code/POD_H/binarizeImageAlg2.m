function [bimg,c,thi] = binarizeImageAlg2(img,tlo,sigE,clist,thilist)

% B = binarizeImageAlg2(I)
% B = binarizeImageAlg2(I,tlo,sigE,clist,thilist)
%
% Algorithm 2 from "Document Binarization with Automatic Parameter Tuning"

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
    thilist = .15:.05:.65;
end;

% compute best binarization and c at each thi
bsd = zeros(1,numel(thilist)-1);
bimg = cell(1,numel(thilist));
cbest = zeros(1,numel(thilist));
for ithi = 1:numel(thilist)
    [bimg{ithi},cbest(ithi)] = binarizeImageAlg1(img,thilist(ithi),tlo,sigE,clist);
    if (ithi > 1)
        bsd(ithi-1) = sum(bimg{ithi}(:)~=bimg{ithi-1}(:))./numel(bimg{ithi});
    end;
end;

% smooth stability curve
filt = fspecial('gaussian',[6,1],1);
d = conv2(bsd(:),filt)';
d = d(3:end-2);  % expand size by 1 since differences fall between c values

% take parameter of minimum instability
[~,r] = min(d);

% return selected values
bimg = bimg{r};
c = cbest(r);
thi = thilist(r);

