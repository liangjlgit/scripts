
Metagenomic reads were quality filtered and trimmed using the three Perl scripts

Usage

perl 1_reads_with_duplication_filter.pl -fq1 input_1.fq -fq2 input_2.fq -out output

perl 2_reads_with_excess_of_N_filter.pl output_1.fq output_2.fq output_1_1.fq output_2_2.fq 5

perl 3_reads_with_trimm_low_quality.pl output_1_1.fq output_2_2.fq output_1_1_1.fq output_2_2_2.fq 30
###################################################################

Accumulative curves for normal coverage table using the R script

Usage

source("C:\\Users\\fengsw\\Desktop\\liangjl\\NC_P_vOTUs\\vOTU_coverage\\depth\\rarefy_sample.R")

resample_df_normal_coverage  <- rarefy_gene_sample(df_normal_coverage, step = 1, reps = 500)  # resample

resample_df_normal_coverage_Mean <- data.frame(colMeans(data.frame(resample_df_normal_coverage)))  # Mean for accumulative curves

Special, df_normal_coverage: Columns are samples and rows represent sequences. 
