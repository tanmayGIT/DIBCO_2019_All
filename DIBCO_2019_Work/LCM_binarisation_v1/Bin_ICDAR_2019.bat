 cd C:\Users\Tanmoy\Desktop\DIBCO_2019_Work\OrigImgDataset_2\
 for /R %%f in (*.jpg) do (
	"C:\Users\Tanmoy\Desktop\DIBCO_2019_Work\LCM_binarisation_v1\LCM_binarisation_v1.exe" "%%f" "%%~nf_bin.bmp"
 	)
cmd/k