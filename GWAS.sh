###Multi-ancestry autosomal and X-chromosomal GWAS

ldak6.1.linux  --linear chimgen  --bfile chimgen --pheno chimgen_cere_phenotype --covar chimgen_cere_qcov   --factors chimgen_cere_cov  --mpheno ALL --exclude-long-alleles YES --exclude-same-names YES


ldak6.1.linux --kvik-step1 abcd_step1_$phenotype --bfile abcd_step1 --pheno abcd_cere_phenotype --covar abcd_cere_qcov  --factors abcd_cere_cov   --mpheno $i  
ldak6.1.linux --kvik-step2 abcd_step1_$phenotype --bfile abcd_autosome  --pheno abcd_cere_phenotype  --covar abcd_cere_qcov  --factors abcd_cere_cov  --mpheno $i --exclude-long-alleles YES --exclude-same-names YES


gcta --bfile abcd_autosome    \
--fastGWA-mlm  --pheno X_abcd_cere_phenotype  \
--model-only \
--qcovar X_abcd_cere_qcov        --covar X_abcd_cere_cov     --nofilter  --mpheno $i   \
--grm-sparse  abcd_grm     --threads 50      \
--out abcd_$phenotype


gcta --bfile abcd_X  --chr 23 \
--pheno X_abcd_cere_phenotype --covar X_abcd_cere_cov \
--qcovar X_abcd_cere_qcov       --nofilter       --mpheno $i     \
--threads 50             \
--load-model abcd_$phenotype.fastGWA   \
--out X_abcd_$phenotype


ldak6.1.linux --kvik-step1 ukb_step1_$phenotype --bfile ukb_step1 --pheno ukb_cere_phenotype --covarukbb_cere_qcov  --factors ukb_cere_cov  --mpheno $i  
ldak6.1.linux --kvik-step2 ukb_step1_$phenotype --bfile ukb_autosome  --pheno ukb_cere_phenotype  --covar ukb_cere_qcov  --factors ukb_cere_cov  --mpheno $i --exclude-long-alleles YES --exclude-same-names YES


gcta --bfile ukb_autosome    \
--fastGWA-mlm  --pheno X_ukb_cere_phenotype  \
--model-only \
--qcovar X_ukb_cere_qcov        --covar X_ukb_cere_cov     --nofilter  --mpheno $i   \
--grm-sparse  ukb_grm     --threads 50      \
--out ukb_$phenotype


gcta --bfile ukb_X  --chr 23 \
--pheno X_ukb_cere_phenotype --covar X_ukb_cere_cov \
--qcovar X_ukb_cere_qcov       --nofilter       --mpheno $i     \
--threads 50             \
--load-model ukb_$phenotype.fastGWA   \
--out X_ukb_$phenotype


metal meta_"$phenotype".txt


###Autosomal AFR-GWAS 

run_tractor.R \
--hapdose ABCD-AFR-biallelicSNPs-CHR${CHR}-AC-phased \
--phenofile tractor_used \
--covarcollist Age,Sex,genetic_pc_1,genetic_pc_2,genetic_pc_3,genetic_pc_4,genetic_pc_5,genetic_pc_6,genetic_pc_7,genetic_pc_8,genetic_pc_9,genetic_pc_10,,genetic_pc_11,genetic_pc_12,genetic_pc_13,genetic_pc_14,genetic_pc_15,genetic_pc_16,genetic_pc_17,genetic_pc_18,genetic_pc_19,genetic_pc_20,genetic_pc_21,genetic_pc_22,genetic_pc_23,genetic_pc_24,genetic_pc_25,genetic_pc_26,genetic_pc_27,genetic_pc_28,genetic_pc_29,genetic_pc_30,genetic_pc_31,genetic_pc_32,smri_vol_scs_intracranialv \
--method linear \
--output abcd_${phenotype}_chr${CHR} \
--sampleidcol sample_id \
--phenocol ${phenotype} 



