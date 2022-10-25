# Paneldatensatz BR-Befragung 2015-2021
# R 4.2.1
# Helge Emmler
# 18.10.2022

# Präambel 
if(!"pacman" %in% installed.packages()[,1]) install.packages("pacman")
library(pacman)
p_load(haven, dplyr, tidyr, stringr, purrr, tibble, openxlsx)

# Ordner erzeugen
map(c("steps", "data", "metadata", "info", "output", "functions"), 
    dir.create, showWarnings=F)

# Durchlaufen
map(dir("functions", full.names=T), source, encoding="UTF-8")
map(dir("steps", full.names=T), source, encoding="UTF-8")

# (Stichprobendaten am Ende replizieren für alle Wellen!)
# Überführen der Betriebsratsstrukturen - Veränderung BR und Logische Filter!
