library(tercen)
library(dplyr, warn.conflicts = FALSE)
library(tim)

ctx = tercenCtx()


colNames <- ctx$cnames
# grepl( needle, haystack, fixed = TRUE)
# Checking for documentId columns
docIdCols <- unname(unlist(colNames[unlist(lapply(colNames, function(x){
  return(grepl("documentId", x, fixed = TRUE))
} ))]))

if (length(docIdCols) == 0 || length(docIdCols) > 2) stop("Either 1 or 2 documentId columns expected.") 
ctx$cselect(unique(unlist(docIds[1])))
for( docIdCol in docIds ){
  docId <- ctx$cselect(unique(unlist(docIdCol)))
  
  
  f.names <- tim::load_data(ctx, docId, force_load=FALSE)
  
  
  if( length(f.names) > 0){
    baseDir   <- dirname( f.names[1] )
    baseDirUp <- dirname( baseDir ) # This is where the locks will be for a zip file
    
    if( file.exists(file.path(baseDir, '.downloaded') ) ){
      unlink(file.path(baseDir, '.downloaded'))
    }
    
    if( file.exists(file.path(baseDir, '.downloaded') ) ){
      unlink(file.path(baseDir, '.downloaded'))
    }
    
    if( file.exists(file.path(baseDirUp, '.downloaded') ) ){
      unlink(file.path(baseDirUp, '.downloaded'))
    }
    
    if( file.exists(file.path(baseDirUp, '.extracted') ) ){
      unlink(file.path(baseDirUp, '.extracted'))
    }
  }
  
  for( fname in f.names ){
    print(fname)
    unlink(fname)
  }
}

ctx$save(ctx$select())
