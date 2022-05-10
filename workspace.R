library(tercen)

library(dplyr, warn.conflicts = FALSE)


library(tim)

#http://127.0.0.1:5402/test-team/w/cc41c236da58dcb568c6fe1a320140d2/ds/13c2fa4e-925a-442c-b1a0-f8f2013c6830
options("tercen.workflowId" = "cc41c236da58dcb568c6fe1a320140d2")
options("tercen.stepId"     = "13c2fa4e-925a-442c-b1a0-f8f2013c6830")


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

ctx$save(ctx$select())
