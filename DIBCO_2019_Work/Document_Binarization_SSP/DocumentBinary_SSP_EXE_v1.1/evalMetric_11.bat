 cd C:\Users\Tanmoy\Desktop\Seperated_Final_Result\DIBCO_11\GT_2\
 for /R %%f in (*.bmp) do (
	"C:\Users\Tanmoy\Desktop\Seperated_Final_Result\DIBCO_metrics\DIBCO_metrics.exe" "%%f" C:\Users\Tanmoy\Desktop\Seperated_Final_Result\DIBCO_11\AlgoResult\%%~nf.png "%%~nf_RWeights.dat" "%%~nf_PWeights.dat"
 	)
cmd/k