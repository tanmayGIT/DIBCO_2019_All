function sm = gsmooth(m,sigma,radius,method)

% function sm = gsmooth(m,sigma[,radius,method])
%
% Perfoms 2D gaussian smoothing on a matrix.
% Method governs edge treatment:  'none', 'mirror'
%
% See also linsmooth.

if (nargin < 2)|isempty(sigma)
    sigma = 1;
end;

if (nargin < 3)|isempty(radius)
  radius = ceil(2.5*sigma);
else
    radius = ceil(radius);
end;

if (nargin < 4)|isempty(method)
  method='none';
end;

if (sigma == 0)
  sm = m;
else
  hcol = fspecial('gaussian',[2*radius+1,1],sigma);
  hrow = fspecial('gaussian',[1,2*radius+1],sigma);

  [nrow,ncol,nclr] = size(m);
  sm = zeros(nrow,ncol);
  for c = 1:nclr
      switch method
          case 'none'
              sm(:,:,c) = conv2(hcol,hrow,m(:,:,c),'same');
          case 'mirror'
              sm(:,:,c) = conv2(hcol,hrow,padarray(m(:,:,c),[radius radius],'symmetric'),'valid');
      end;
  end;
end;
