*To execute IRACE code edit executeIrace.m to set the paths in which results from each tested configurations will be written.  
Then, just run executeIrace and the results will be written in the paths pointed while the algorithm is running.

*To change the objective function or the binarization algorithm used, edit FRace.m file.

*In IRace.m it is necessary to include path to the code of the binarization algorithm  

*FMeasure values of all elite configurations resulted from each execution will be saved in '\tunning\data\IRACE_eliteConfResults.txt' following the pattern: 
param1,param2,..., FMeasureValue
 