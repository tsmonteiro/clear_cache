library(tercen)
library(dplyr, warn.conflicts = FALSE)
library(tim)

ctx = tercenCtx()

if (!any(ctx$cnames == "documentId")) stop("Column factor documentId is required") 

df <- ctx$cselect()
docId <- df$documentId

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

ctx$save(df)
