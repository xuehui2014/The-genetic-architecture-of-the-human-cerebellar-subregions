###mvSuSiE
R
fit_rss <- mvsusie_rss(as.matrix(Z), as.matrix(EUR_cov), n,
prior_variance = prior,
residual_variance = Vest,
estimate_prior_variance = TRUE,
tol = 0.01)

###Sbayes

gctb_2.5.1_Linux/gctb --sbayes S \
 --mldm ukbEURu_hm3_shrunk_sparse/ukbEURu_hm3_sparse_mldm_list.txt \
 --gwas-summary F${i} \
 --exclude-mhc \
 --out F"${i}"_SBayesS

 ##S-LDSC

munge_sumstats.py --sumstats F${i} --out F${i} --merge-alleles w_hm3.snplist --chunksize 500000
ldsc.py --h2 "F${i}.sumstats.gz" --ref-ld-chr eur_w_ld_chr/ --w-ld-chr eur_w_ld_chr/ --out  h2_eur_F${i}

ldsc.py --h2 F${i}.sumstats.gz \
--ref-ld-chr baselineLD_v1.1/baselineLD.  \
--frqfile-chr 1000G_Phase3_frq/1000G.EUR.QC.  \
--w-ld-chr weights_hm3_no_hla/weights.  \
--overlap-annot --print-cov --print-coefficients --print-delete-vals   \
--out F${i}


###hare

hare intersect --gwas /F${i}_result --eoi HARE/reference_assets/harsRichard2020.GRCh37.bed --ref HARE/reference_assets/UCSC.GRCh37.autosomes.annotation.bed --out F${i} --gwas_ref A2 --gwas_p Pval_Estimate --gwas_maf MAF  --gwas_alt  A1 --cache_dir HARE/vep_cache/ 


###seismic

cerebellum_sscore <- calc_specificity(cerebellum_sc, ct_label_col='cell_type')

get_ct_trait_associations(cerebellum_sscore, F${i}_magma)


find_inf_genes(${cell_type_name}, cerebellum_sscore, F${i}_magma)


