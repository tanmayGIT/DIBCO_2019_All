usage:
There are five input parameters in our binarization function: 
the storage path of the input image; 
the storage path of the binarized image ;
alpha;
k;
Rthre.

DocumentBinary_SSP.exe	PR5.bmp	PR5_bin.bmp	% default parameters: alpha = 2, k = 0.6, Rthre = 0.05
DocumentBinary_SSP.exe	PR5.bmp	PR5_bin2.bmp	2.5	0.5	0.05	% parameters: alpha = 2.5, k = 0.5, Rthre = 0.05

//********************* v1.1 description*********************//
We add a function that can tell if the input image is a binary image or not.
The binarization algorithm is only performed when the image is not a binary image.
Otherwise, the output image is a copy of the input image.