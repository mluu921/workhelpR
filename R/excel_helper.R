paste_to_excel <- function(data, ...) {
  write.table(data, "clipboard", sep = "\t", ...)
}

copy_from_excel <- function(header=TRUE, ...) {
  read.table("clipboard",sep="\t",header=header, ...)
}
