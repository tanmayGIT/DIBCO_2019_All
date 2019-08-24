 cd C:\Users\Tanmoy\Desktop\DIBCO_2019_Work\OrigImgDataset_2\
 for /R %%f in (*.jpg) do (
	"C:\Users\Tanmoy\Desktop\DIBCO_2019_Work\DocumentBinarizationSSP-master\DocumentBinary_SSP_EXE_v1.1\DocumentBinary_SSP.exe" "%%f" "%%~nf_bin.bmp"
 	)
cmd/k