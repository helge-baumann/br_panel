# Value-Label doppelt vergeben?----

# Bereits bekannt: Vereinheitlichen (manuell)
attributes(dat_wide$untn_n__1)$labels <- attributes(dat_wide$untn_n__1)$labels[c(3,4)]
attributes(dat_wide$idauer_m__2)$labels <- attributes(dat_wide$idauer_m__2)$labels[2]

for(b in names(dat_wide)) {
  
  if(!is.null(attributes(dat_wide[[b]])$labels)) { 
    
    # welche sind doppelt?
    attr_temp <- attributes(dat_wide[[b]])$labels
    attr_temp <- attr_temp[nchar(names(attr_temp)) > 1]
   
  if(length(unique(names(attr_temp))) < length(names(attr_temp))) print(b)

  }
  
}

# Missings auf negativ----
dat_wide <- 
    map_dfc(dat_wide, function(x) 
      rec_attr(
        x, 
        namen=c("prozentangabe", "angabe in prozent", "weiß nicht", "verweigert", "trifft nicht zu"), 
        werte=c(-9,  -9, -8, -7, -6), 
        ausnahme_wert = 2) # für spezielles "Trifft nicht zu"
      )

# Erster Buchstabe auf uppercase----
for(b in names(dat_wide)) {
  
  if(!is.null(attributes(dat_wide[[b]])$labels))
    
    names(attributes(dat_wide[[b]])$labels) <- 
      first_to_upper(names(attributes(dat_wide[[b]])$labels))
  
  attributes(dat_wide[[b]])$labels <- sort(attributes(dat_wide[[b]])$labels)
  
}

# Vereinheitlichen: "Angabe in Prozent" = "Prozentangabe"----
for(b in names(dat_wide)) {
  
  if(!is.null(attributes(dat_wide[[b]])$labels))
    
    names(attributes(dat_wide[[b]])$labels)[
      names(attributes(dat_wide[[b]])$labels) == "Prozentangabe"
    ] <- "Angabe in Prozent"
  
}

# Kontrolle: Label, Valuelabel, Class identisch?----
namen_unique <- unique(str_remove_all(names(dat_wide), "__[[:digit:]]$"))

fehler <- list()

for(b in namen_unique) {
  
  vars <- names(dat_wide)[str_detect(names(dat_wide), paste0("^", b, "__"))]
  
  temp_list <- map(vars, function(x) attributes(dat_wide[[x]]))
  temp_list <- map(temp_list, function(x) list(x$label, x$labels, x$class))
  
  if(length(unique(temp_list)) > 1) fehler[[b]] <- temp_list
  
}

# Auffällig:
  # einige fehlen in Welle 5 Attribute (besch_..._p); auch w4_besch_freie_p
  # gewerk_name komma bei transnet
  # gesf: familie(n)
  # wirtschaft: Item trifft nicht zu muss auf Vorwellen übertragen werden.
  # alle ai: Welle 2 auf Welle 1 übertragen.
  # wahl: von allen Wellen auf W4 übertragen ("verweigert" fehlt) 
  # vorssex: von Welle 5 auf Vorwellen übertragen (divers)
  # vorsage: Attribute fehlen in Welle 1 (übertragen)
  # verlaesslich: von W5 übertragen (Fragezeochen)
  # einigst_n: Eine Welle (4) ohne weiß nicht und verweigert
  # gericht_n : same 
  # funktion: Welle 5 auf Vorwellen übertragen
  # untn_n: Unsinnige Doppel-Labelung in Welle 1; vorher korrigieren. 
  # idauer_m: Wellen auf W1 übertragen
  # uintro_n : same
  # bland: Von W1 auf W5 übertragen
  # tn_vorjahr: Von Welle 4 zurückziehen.
  # brtl_milo: vereinheitlichen (Fragezeichen)
  # alle dwege: Vereinheitlichen (items anders gelabelt aber gleich)
  # keintarif: alles aufs neueste
  # streik_verw: alles aufs neueste; streik_wn: ebenso. 
  # leih_rkg: alles auf neueste

# Interviewergruppierung: Von Welle 5 auf Vorwelle übertragen
dat_wide <- 
  dat_wide %>%
  mutate(int_altg__5 = 
           case_when(
             int_altg__5 %in% 0:29 ~ 1,
             int_altg__5 %in% 30:49 ~ 2,
             int_altg__5 %in% 50:65 ~ 3,
             int_altg__5 %in% 66:100 ~ 4,
             is.na(int_altg__5) & !is.na(split__5) ~ 9
           ))

attributes(dat_wide$int_altg__5) <- attributes(dat_wide$int_altg__1)

for(b in names(fehler)[str_detect(names(fehler), "besch_|bland")]) {
  
  vars <- names(dat_wide)[str_detect(names(dat_wide), paste0("^", b, "__[[:digit:]]"))]
  attr <- attributes(dat_wide[[vars[1]]])
  
  for(d in vars) {
    
    attributes(dat_wide[[d]]) <- attr 
    
  }
  
}

for(b in names(fehler)[!str_detect(names(fehler), "besch_|bland|intv_altg")]) {
  
  vars <- names(dat_wide)[str_detect(names(dat_wide), paste0("^", b, "__[[:digit:]]"))]
  attr <- attributes(dat_wide[[vars[length(vars)]]])
  
  for(d in vars) {
    
    attributes(dat_wide[[d]]) <- attr 
    
  }
  
}



  


  

  




