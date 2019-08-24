function [bimg,c] = binarizeImageAlg1(img,thi,tlo,sigE,clist)

% B = binarizeImageAlg1(I)
% B = binarizeImageAlg1(I,thi,tlo,sigE,clist)
%
% Algorithm 1 from "Document Binarization with Automatic Parameter Tuning"

% choose reasonable values for static parameters if they are not specified
if (nargin < 2)||isempty(thi)
    thi = 0.3;
end;
if (nargin < 3)||isempty(tlo)
    tlo = 0.1;
end;
if (nargin < 4)||isempty(sigE)
    sigE = 0.4;
end;
if (nargin < 5)||isempty(clist)
    clist = exp(linspace(log(20),log(5120),33));
end;

% compute base binarizations and the stability curve
bsd = zeros(1,numel(clist)-1);
bimg = cell(1,numel(clist));
bimg = binarizeImage(img,clist,thi,tlo,sigE);
for ic = 2:numel(clist)
    bsd(ic-1) = sum(bimg{ic}(:)~=bimg{ic-1}(:))./numel(bimg{ic});
end;

% smooth stability curve
filt = fspecial('gaussian',[6,1],1);
d = conv2(bsd(:),filt)';
d = d(3:end-2);  % expand size by 1 since differences fall between c values

% find middle stability point via qrs minimization
scr = -inf;
for i = 1:numel(d)-2
    for j = i+2:numel(d)
        for k = i+1:j-1
            v = d(i)+d(j)-2*d(k);
            if (v>scr)
                q = i;
                r = k;
                s = j;
                scr = v;
            end;
        end;
    end;
end;

% return selected values
bimg = bimg{r};
c = clist(r);
