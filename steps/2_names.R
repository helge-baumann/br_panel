# Namen extrahieren und in csv speichern

# längster Datensatz
n <- max(sapply(dat, ncol))

# empty frame
namen <- map_dfc(
  paste0(rep(c("n", "l"), 5), rep(1:5, each=2)), 
  ~{tibble({{.x}} := rep(NA, n))}
  )

# Namen und Labels
num <- 1

for(b in names(dat)) {
  temp <- 
    enframe(
      unlist(
        map(
          dat[[b]], 
          function(x) {
            if(!is.null(attributes(x)$label)) {
              attributes(x)$label 
            } else {  "" 
                }
            }
          )
        )
      )
         
  namen[1:nrow(temp), num:(num+1)] <- temp
  num <- num+2
}

write.csv2(namen, 
           paste0("output/", Sys.Date(), "_namen.csv"), 
           row.names=F, fileEncoding="CP1252")




