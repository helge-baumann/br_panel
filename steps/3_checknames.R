names_panel <- 
  read.xlsx(
    "output/aktuelle namensdatei/2022-10-24_namen_brbefragung.xlsx", 
    startRow=2) %>% 
  tibble(.name_repair="unique")

# grundlegende checks

# Namen der Datensätze vertreten, nichts versehentlich gelöscht?
table(names(dat[["2015"]]) %in% unlist(names_panel[,1]))
table(names(dat[["2016"]]) %in% unlist(names_panel[,3]))
table(names(dat[["2017"]]) %in% unlist(names_panel[,5]))
table(names(dat[["2018"]]) %in% unlist(names_panel[,7]))
table(names(dat[["2021"]]) %in% unlist(names_panel[,9])) # alles sauber

# Duplikate in vegebenen Namen (Relabel?)
dupl <- names_panel %>% group_by(newname) %>% mutate(n = n()) %>% filter(n > 1)
#View(dupl) # keine doppelten Namen (25.10.2022)


