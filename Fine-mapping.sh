####MESuSiE

R
MESuSiE_res<-meSuSie_core(LD_list_n,summ_stat_list_n,L=10)

magma   \
	--annotate window=0,0   \
	--snp-loc g1000_eur.bim   \
	--gene-loc hgnc_NCBI37.3.gene.loc   \
	--out step1_EUR 
 
magma \
 --bfile g1000_eur \
 --gene-annot step1_EUR.genes.annot \
 --pval eur_"$phenotype" ncol=N \
 --gene-model snp-wise=mean \
 --out magma_"$phenotype" 


magma \
--gene-results magma_"$phenotype".genes.raw \
--gene-covar gtex_v8_ts_avg_log2TPM.txt \
--out gtex_magma_"$phenotype"


pops.py \
--gene_annot_path pops_features_pathway_naive/gene_annot.txt \
--feature_mat_prefix pops_features_pathway_naive/munged_features/pops_features \
--num_feature_chunks 99 \
--magma_prefix magma_"$phenotype" \
--out_prefix pops_"$phenotype"

python FLAMES.py annotate \
-o "$phenotype" \
-a Annotation_data/ \
-p pops_"$phenotype".preds \
-m magma_"$phenotype".genes.out \
-pc prob1 \
-sc cred1 \
-mt gtex_magma_"$phenotype".gsa.out \
-id "$loci"

python FLAMES.py FLAMES \
-id $loci \
-o $phenotype




