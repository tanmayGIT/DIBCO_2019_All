# DIBCO-2019 Competetion # 

 **The folder named as "Binarization_Code" is containing the implementation of the following paper :**

```
Mesquita, R. G., Silva, R. M. A., Mello, C. A. B., & Miranda, P. B. C. (2015). Parameter tuning for document image binarization using a racing algorithm. Expert Systems with Applications, 42(5), 2593–2603.
```
This paper is an updated version of Howe binarization. 


To run the code, simply run the program "Binarize_ICDAR_2019_Dataset.m". In line 
5 and 7 the path of image folder and the result saving folder is mentioned. Change 
these paths accordingly. The image folder can contain several images together of various possible 
extensions e.g. .jpg, .bmp, .png etc. 

**To run the "Niblack", "Savoula" and "WolfJolin" binarization **

To run the "Niblack", "Savoula" and "WolfJolin" binarization and to save them in 
corresponding result folders, simply uncomment the line 9-12 and 31-41 and comment 
the line 28-29 (if you don't like to have Howe binarization result.). The function to be called to get 
these binarization results, we need to call the "LocalWindowBasedBinarization.m" function. Moreover, 
this function also contains another binarization which I call here **Dynamic Window Based Binarization**
This is the implementation of the following paper : 

```
Bataineh, B., Abdullah, S. N. H. S., & Omar, K. (2011). An adaptive local binarization method for document images based on a novel thresholding method and 
dynamic windows. Pattern Recognition Letters, 32(14), 1805–1813. 
```
Where only part of these paper is implemented i.e. Equation 4, 5, 6, 7, 8 and 9. 
Please have a look at the paper. 

# The Folder DIBCO_2019_Work #

In the following section, I have mentioend the description of each folders 

*  DIBCO_2019_Work
     * All_Images_DIBCO_2019
         (All the 15 images selected for DIBCO-2019 competetion)
     * OrigImgDataset_2  
       (The dataset of original 10 remaining images)    
     * BinImages
        *  dynamic_window  
             (Results of Dynamic Window based method for the images in folder **OrigImgDataset_2**)
        *  Howe  
             (Results of Howe method for the images in folder **OrigImgDataset_2**)
        *  niblack  
             (Results of niblack method for the images in folder **OrigImgDataset_2**)
        *  savoula  
             (Results of savoula method for the images in folder **OrigImgDataset_2**)
        *  wolf_jolin  
             (Results of wolf-jolin method for the images in folder **OrigImgDataset_2**)
     * DIBCO_2019_Dataset_1st_part
        *  original  
           (The original 5 images which is sent to Greece team as the initial dataset )
        *  ground_truth_png  
           (Corresponding binarized .png images of these 5 original images)
        *  ground_truth_tif  
          (Corresponding binarized .tif images of these 5 original images)
     * Document_Binarization_SSP
        *  DocumentBinary_SSP_EXE_v1.1  
             (This folder contains the executable file of the algorithm mentioned in the following reference [1]. 
              To run this executable, you can simply double click on either **test.bat** or **test2.bat** file. But if you want to run the code 
                on many images all together then double click on the file **Bin_ICDAR_2019.bat** file. Please note that before that don't 
                forget to edit this file and change the path of your images and the path of executable DocumentBinary_SSP.exe)
     * LCM_binarisation_v1  
        (This is the executable file of the algorithm mentioned in the following reference [2]. To run this executable you can simply double click 
        on **LCM_binarization_v1.exe** file. It will open up a GUI and then you can choose your **image** followed by the button 
        **Remove Back** followed by the button **Binarise**). Please note that this algorithm takes bit long time so please have patience ... ). 

# Reference #  
1.  Jia, F., Shi, C., He, K., Wang, C., & Xiao, B. (2018). Degraded document image binarization using structural symmetry of strokes. Pattern Recognition, 74, 225–240. 
2.  Mitianoudis, N., & Papamarkos, N. (2015). Document image binarization using local features and Gaussian mixture modeling. IMAVIS, 38, 33–51.
