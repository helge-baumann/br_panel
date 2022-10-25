# alle Datensätze namen und Namen entsprechend Vorgabe umwandeln

names_panel <- data.frame(names_panel)

num <- 1

for(b in names(dat)) {
  
  for(i in 1:nrow(names_panel)) {
    
    if(names_panel[i, num*2-1] %in% names(dat[[b]])) {
      
      oldname <- names_panel[i, num*2-1]
      newname <- names_panel[i, "newname"]
      if(newname != "id") newname <- paste0(newname, "__", num)
      dat[[b]] <- dat[[b]] %>% rename({{newname}} := oldname)
      attributes(dat[[b]][[newname]])$label <- names_panel[i, "newlabel"]
      
    }
    
  }
  
  num <- num+1
  
}
