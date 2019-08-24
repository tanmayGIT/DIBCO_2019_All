function bimg = binarizeImage(img,varargin)

% B = binarizeImage(I,c,thi,tlo,sigE)
%
% Base binarization routine.
%
% Any of the parameter arguments may be omitted or left empty to use
% defaults of 160, 0.4, 0.1, and 0.6 respectively.

% Read arguments
if (nargin < 2)||isempty(varargin{1})
    wgt = 160;
else
    wgt = varargin{1};
end;
if (nargin < 3)||isempty(varargin{2})
    thi = 0.4;
else
    thi = varargin{2};
end;
if (nargin < 4)||isempty(varargin{3})
    tlo = 0.1;
else
    tlo = varargin{3};
end;
if (nargin < 5)||isempty(varargin{4})
    sigE = 0.6;
else
    sigE = varargin{4};
end;

if (size(img,3)==3)
    img = rgb2gray(img);
end;

% Do Canny edge detection
cannyargs = {[tlo thi],sigE};
v = ver('images');
% Canny implementation changed with Image Processing Toolbox v7.2
% This binarization is optimized to work with the older version
if (sscanf(v.Version,'%f')>=7.2)
    eimg = edge(img,'canny_old',cannyargs{:});
else
    eimg = edge(img,'canny',cannyargs{:});
end;
if isa(img,'uint8')
    img = double(img);
else
    img = 255.*img; % numbers are set for 255 scale
end;

% This somewhat unusual way of computing the Laplacian is an artifact of
% the algorithm's development.  It is taken unchanged from the
% implementation used in the conference paper that describes the base
% algorithm.  As I was preparing this code for release following the 
% paper's acceptance, I considered changing to a more standard method, i.e.,
% convolution by a Laplacian filter.  But that changes the results from
% those reported in the paper, so instead I am leaving things as they are.
dx = img(1:end-1,2:end)-img(1:end-1,1:end-1);  % X component of gradient (forward difference)
dy = img(2:end,1:end-1)-img(1:end-1,1:end-1);  % Y component of gradient (forward difference)
lap = divergence(dx,dy);  % Laplacian is divergence of gradient

% Bias high-confidence background pixels
sr = 20;  % no need found to vary this parameter
img2 = (img-gsmooth(img,sr,3*sr,'mirror'));
rms = sqrt(gsmooth(img2.^2,sr));
himask = (img2./(rms+eps)>2);
lap(himask(1:end-1,1:end-1)) = -500;

% Assemble matrices of edge connections -- horizontal and vertical
hc = ~((eimg(1:end-1,1:end-1)&(dy>0))|(eimg(2:end,1:end-1)&(dy<=0)));
vc = ~((eimg(1:end-1,1:end-1)&(dx>0))|(eimg(1:end-1,2:end)&(dx<=0)));
hc = hc(1:end-1,:);
vc = vc(:,1:end-1);

% Use graph cuts to minimize the energy
if (numel(wgt)>1)
    % use imgcutmulti for speedup
    bimg = imgcutmulti(1500-lap,1500+lap,double(hc),double(vc),sort(wgt));
    for i = 1:numel(bimg)
        bimg{i} = logical(bimg{i}([1:end end],[1:end end]));
        % The operation below was also used and described in the original 
        % paper presenting the base algorithm.
        nw = bimg{i}&~bimg{i}([1 1:end-1],:)&~bimg{i}(:,[1 1:end-1]);
        bimg{i} = bimg{i}&~nw;
    end;
else
    bimg = logical(imgcut3(1500-lap,1500+lap,wgt.*hc,wgt.*vc));
    bimg = bimg([1:end end],[1:end end]);
    % The operation below was also used and described in the original
    % paper presenting the base algorithm.
    nw = bimg&~bimg([1 1:end-1],:)&~bimg(:,[1 1:end-1]);
    bimg = bimg&~nw;
end;
end

