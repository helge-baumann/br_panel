# Longformat erzeugen

# Interviewernummer einheitlich als character definieren
dat_wide <- dat_wide %>% mutate(across(starts_with("internr_n"), as.character))

dat_long <- 
  dat_wide %>% 
  pivot_longer(
    cols = -id, 
    names_to = c('.value', 'Welle'), 
    names_sep="__"
  )

dat_long$Welle <- as.numeric(dat_long$Welle)
