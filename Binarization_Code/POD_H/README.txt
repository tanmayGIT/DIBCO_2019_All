To execute each version of our code just call


[bw]=mainDP(img);


where img is the image (previously read in MatLab).

*****
In case of any incompatibility you may need to recompile the mex files. To do so, please execute the following Matlab's mex commands:

>> mex imgcut3.cpp graph.cpp maxflow.cpp 
>> mex imgcutmulti.cpp graph.cpp maxflow.cpp 

Please note that if you have not a supported compiler installed on your
system, you can download one of the options listed at the Mathworks web site at
http://www.mathworks.com/support/compilers. Thus, before calling the mex commands
you just need to select the desired compiler by the following command:
>> mex -setup
*****



 