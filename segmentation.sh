#Segement cerebellum into different subregion by CerebNet
run_fastsurfer.sh --t1 $datadir/${sub}.nii       --sd $fastsurferdir     --threads 10  --sid ${sub}        --seg_only  --viewagg_device 'cpu'
