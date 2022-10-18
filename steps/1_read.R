# Datensätze einlesen

dat15 <- 
  read_sav(
    "data/2015/infas_Befragungsdaten_Betriebsrätepanel_4808_20150518_1.SAV"
    ) %>%
  left_join(
    read_sav("data/2015/infas_Gewichte_WSI_4808_20150625_2.sav") %>%
      select(lfd, gewbr_k, gewbr_l)
    ) %>%
  left_join(
    read_sav("data/2015/infas_Methodendatensatz_WSI_4808_20150812.sav")
    ) %>%
  left_join(
    read_dta("data/2015/infas_Stichprobenmerkmale_WSI_4808_20150611.dta")
  ) 
  # Stichprobendaten am Ende replizieren für alle Wellen!

dat16 <- 
  read_sav("data/2016/infas_Befragungsdatensatz_5195_WSI_BR_20160524.sav") %>%
  left_join(
    read_dta("data/2016/infas_Gewichte_WSI_BR_5195_20160523_1.dta") %>%
      select(lfd, fakbr_w2)
    )
  # Faktor Welle 2 noch multiplizieren!

dat17 <- 
  read_dta("data/2017/infas_Befragungsdaten_WSI_BR_2017_20170428_1.dta") %>%
  left_join(
    read_dta("data/2017/infas_Gewichte_WSI_alle_Wellen_5535_20170512.dta") %>%
      select(lfd, gewbr_w3)
      )

dat18 <- 
  read_dta(
    "data/2018/infas_5806_Befragungsdaten_WSI_BR_2018_20180511_1.dta"
    ) %>%
  left_join(
    read_dta(
      "data/2018/v13_infas_Gewichte_WSI_alle_Wellen_5806_20180523.dta"
      ) %>%
      select(lfd, gewbr_w4)
  )
  
dat21 <- 
  read_dta("data/2021/015390_WSI_BRPR_2021_Daten_ungewichtet_UPDATE.dta") %>%
  left_join(read_dta("data/2021/gewicht_2021.dta")) %>%
  left_join(
    read_sav("data/2021/015390_WSI_BRPR_BRUTTOSTICHPROBE_WSI_UPDATE.sav") %>%
      select(lfn_015390, lfd_schichtung) %>%
      rename("lfd_alt" = lfd_schichtung)
  )
  


  
  