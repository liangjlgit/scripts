library(foreach)
rarefy_gene_sample <- function(geneXsample, from = 1, to = NA, step = 1, reps = 500, cores = 5){
  library(foreach)
  library(doParallel)
  num_sample <- ncol(geneXsample)
  if (is.na(to) || to > num_sample){
    to = num_sample
  }
  size_seq <- seq(from, to, by = step)
  
  rarefy_res <- matrix(NA, nrow = reps, ncol = length(size_seq))
  colnames(rarefy_res) <- paste("resample", size_seq, sep = "")
  
  cl <- makeCluster(cores)
  registerDoParallel(cl)
  
  for(i in size_seq){
    null_gene_num <- foreach(j = 1:reps, .combine = "c", .export = c("i")) %dopar% {
      null_table <- geneXsample[,sample(1:num_sample, i), drop =F]
      null_gene_num <- (sum(rowSums(null_table) > 0))
      return(null_gene_num)
    }
    rarefy_res[,paste("resample", i, sep = "")] <- null_gene_num
  }
  
  stopCluster(cl)
  return(rarefy_res)
}
