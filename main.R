library(tercen)
library(dplyr, warn.conflicts = FALSE)
library(tim)


ctx = tercenCtx()

if (!any(ctx$cnames == "documentId")) stop("Column factor documentId is required") 

df <- ctx$cselect()
docId <- df$documentId

f.names <- tim::load_data(ctx, docId, force_load=FALSE)

for( fname in f.names ){
  print(fname)
  unlink(fname)
}


ctx$save(df)