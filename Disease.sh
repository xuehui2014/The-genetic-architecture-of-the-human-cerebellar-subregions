####PGS

python PRScs.py --ref_dir=ldblk_ukbb_eur --bim_prefix=eur_ld --sst_file=input_F"$i" --n_gwas=71048 --out_dir=F"$i"  --chrom=$CHR

plink2 \
    --pfile ukb  --chr "$CHR" \
    --scoreF"$i"_pst_eff_a1_b0.5_phiauto_chr"$CHR".txt 2 4 6 ignore-dup-ids list-variants cols=+scoresums \
    --out prs_"$i"_chr$CHR

###PHEWAS

Rscript phenomeScan.r \
--phenofile="output_y_PRS" \
--traitofinterestfile="input_phewas_F$i" \
--variablelistfile="outcome-info.tsv" \
--datacodingfile="data-coding-ordinal-info.txt" \
--traitofinterest="exposure" \
--resDir="result_F$i/"  \
--userId="IID"  \
--sensitivity \
--genetic=TRUE \
--confounderfile="final_phewas_cov_qc"

####Genetic correlation

Rscript /pubbak/xuehui/mt/HDL/HDL.run.R \
gwas1.df=F${i}_result.hdl.rds \
gwas2.df="$disease".hdl.rds \
LD.path=HDL/hapmap3/ \
output.file=F${i}_"$diseasee".Rout


####coloc
result <- coloc.abf(dataset1=list(snp=merge$SNP,pvalues=merge$P, type="quant", N=mean(merge$N)), dataset2=list(snp=merge$SNP,pvalues=merge$Pval_Estimate, type="quant", N=71048), MAF=merge$MAF) 
result <- coloc.abf(dataset1=list(snp=merge$SNP,pvalues=merge$P, type="cc", s=q,N=t), dataset2=list(snp=merge$SNP,pvalues=merge$Pval_Estimate, type="quant", N=71048), MAF=merge$MAF) 



