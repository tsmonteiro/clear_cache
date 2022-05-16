library(tercen)
library(dplyr, warn.conflicts = FALSE)
library(tim)
#http://127.0.0.1:5402/test-team/w/8ef9012b2d2f050214e16189ba0406b4/ds/3a384786-103c-4f71-a4fc-81da01db627a
#options("tercen.workflowId" = "8ef9012b2d2f050214e16189ba0406b4")
#options("tercen.stepId"     = "3a384786-103c-4f71-a4fc-81da01db627a")


ctx = tercenCtx()

colNames <- ctx$cnames
# grepl( needle, haystack, fixed = TRUE)
# Checking for documentId columns
docIdCols <- unname(unlist(colNames[unlist(lapply(colNames, function(x){
  return(grepl("documentId", x, fixed = TRUE))
} ))]))

if (length(docIdCols) == 0 ) stop("At least 1 documentId column expected.") 

for( docIdCol in docIdCols ){
  docId <- ctx$cselect(unique(unlist(docIdCol)))

  print(paste0("[documentId] ", docId[[1]]))
  
  f.names <- tim::load_data(ctx, docId[[1]], force_load=FALSE)
  
  
  # Files saved in /tmp/docId/docId
  if( length(f.names) > 0){
    dpath <- f.names[1]
    
    for(i in range(1,2) ){
      dpath <- dirname(dpath)
      if( dpath != '/tmp' ){
        print(paste0("Deleting: ", dpath ) )
        unlink(dpath, recursive = TRUE)
      }
    }
  }
  
  #for( fname in f.names ){
  #  print(fname)
  #  unlink(fname)
  #}
}

ctx$save(ctx$select())
