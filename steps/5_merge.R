# Wideformat merge
dat_wide <- dat[["2015"]]

for(b in names(dat)[-1]) {
  
  dat_wide <- dat_wide %>%
    full_join(dat[[b]], by="id")
  
}

# ID zusammenführen
dat_wide <- dat_wide %>% mutate(id = if_else(is.na(id), w5_id__5, id))
