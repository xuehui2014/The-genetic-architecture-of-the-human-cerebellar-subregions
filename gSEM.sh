R
library(dplyr)
library(tidyr)
require(GenomicSEM)
library(lavaan)
require(Matrix)
require(stats)
library(ggplot2); library(ggrepel)
library(cowplot)

sample.prev <- rep(NA,times=length(traits))
population.prev <- rep(NA,times=length(traits))
hdl.covstruct <- hdl(traits, sample.prev, population.prev, ld, wld, trait.names)

Ssmooth<-as.matrix((nearPD(hdl.covstruct$S, corr = FALSE))$mat)
n_scree_crit<-nFactors::nScree(Ssmooth)
summary(n_scree_crit)
n<-n_scree_crit$Components        

CommonFactor_DWLS<- commonfactor(covstruc = hdl.covstruct, estimation="DWLS")

EFA<-factanal(covmat = Ssmooth, factors = n, rotation = "promax")

Model<-EFA %>% mutate(measures_in_model=
                              model %>% gsub(paste0("F",1:10,collapse="|"),"",.) %>% 
                              gsub(" =\\~ NA\\*","",.) %>% gsub("\\\n"," + ",.) %>% 
                              gsub(" \\+ ",",",.) %>% gsub(",$","",.)
) %>%
  mutate(measures_n_model=measures_in_model %>% strsplit(.,",") %>% sapply(.,function(x) unique(x) %>% length()),
         measures_in_model=measures_in_model %>% strsplit(.,",") %>% sapply(.,function(x) unique(x) %>% paste0(.,collapse=",")))


CFA <-usermodel(hdl.covstruct, estimation = "DWLS", model = Model,  CFIcalc = TRUE, std.lv = TRUE, imp_cov = FALSE)

ref= "genomicSEM/reference.1000G.maf.0.005.txt"
files<-paste0("eur_",idps$V1)
se.logit=rep(FALSE,times=length(traits))
linprob=rep(FALSE,times=length(traits))
OLS=rep(TRUE,times=length(traits))
info.filter=.6
maf.filter=0.01
N=NULL
betas=NULL
all_sumstats <-sumstats(files=files,ref=ref,trait.names=trait.names,se.logit=se.logit,OLS=NULL,linprob=linprob,N=NULL,betas=NULL,info.filter=info.filter,maf.filter=maf.filter,keep.indel=FALSE,parallel=FALSE,cores=NULL)

result${i}<-userGWAS(covstruc = hdl.covstruct, SNPs = all_sumstats, estimation = "DWLS", model = Model, printwarn = TRUE,sub=c("F$i~SNP"),smooth_check=TRUE,Q_SNP=TRUE,cores=10,fix_measurement=TRUE)


                    
