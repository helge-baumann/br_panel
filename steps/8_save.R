# speichern

map(c("output/spss", "output/stata"), dir.create, showWarnings=F)

v <- "v1-0"

write_sav(dat_wide, paste0("output/spss/brprbefr_w1-5_wide_", v, ".sav"))
write_dta(dat_wide, paste0("output/stata/brprbefr_w1-5_wide_", v, ".dta"))

write_sav(dat_long, paste0("output/spss/brprbefr_w1-5_long_", v, ".sav"))
write_dta(dat_long, paste0("output/stata/brprbefr_w1-5_long_", v, ".dta"))