# Namen extrahieren und in csv speichern

# längster Datensatz
n <- max(sapply(mget(ls()[str_detect(ls(), "^dat")]), ncol))

# empty frame
namen <- tibble(n1 = character(n))

for(i in 1:5) {
  for(b in c("n", "l")) {
    namen[paste0(b, i)] <- NA
  }
}

# Namen und Labels
num <- 1

for(b in ls()[str_detect(ls(), "^dat")]) {
  temp <- enframe(unlist(map(get(b), function(x) attributes(x)$label)))
  namen[1:nrow(temp), num:(num+1)] <- temp
  num <- num+2
}

write.csv2(namen, "output/namen.csv", row.names=F)




