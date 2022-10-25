# Datensätze einlesen

# alle korrekten Gewichte sind im neuen Datensatz für 2018 hinterlegt!

dat <- list()

dat[["2015"]] <- 
  read_dta(
    "data/2015/infas_Befragungsdaten_Betriebsrätepanel_4808_20150518_1.dta"
    ) %>%
  left_join(
    read_dta(
      "data/2018/infas_5806_Befragungsdaten_WSI_BR_2018_Gewichte_20180612_1utf8.dta"
    ) %>%
      select(lfd, gewbr_k, gewbr_l, gewab_l, gewab_k)
    ) %>%
  left_join(
    read_sav("data/2015/infas_Methodendatensatz_WSI_4808_20150812.sav") %>%
      select(-k_rc, -l_krc, -sprachkon, -aapor2, -langkurz)
    ) %>%
  left_join(
    read_dta("data/2015/infas_Stichprobenmerkmale_WSI_4808_20150611.dta")
  ) %>%
  left_join(
    read_dta("data/2015/brbefragung_interviewerdaten_2015.dta"),
    by=c("internr_n" = "Internr_n")
  )
 
dat[["2016"]] <- 
  read_sav("data/2016/infas_Befragungsdatensatz_5195_WSI_BR_20160524.sav") %>%
  left_join(
    read_dta(
      "data/2018/infas_5806_Befragungsdaten_WSI_BR_2018_Gewichte_20180612_1utf8.dta"
    ) %>%
      select(lfd, gewbr_w2, gewab_w2)
  ) %>%
  left_join(
    read_dta("data/2016/brbefragung_methodendaten_2016.dta") %>%
      select(-k_rc, -l_krc, -sprachkon, -frabv, -aapor)
  ) %>%
  mutate(gewbr_l_w2 = gewbr_w2, gewab_l_w2 = gewab_w2) %>% 
  left_join(
    read_dta("data/2016/brbefragung_interviewerdaten_2016.dta"),
    by=c("internr_n" = "INTERNR")
  )

dat[["2017"]] <- 
  read_dta("data/2017/infas_Befragungsdaten_WSI_BR_2017_20170428_1.dta") %>%
  left_join(
    read_dta(
      "data/2018/infas_5806_Befragungsdaten_WSI_BR_2018_Gewichte_20180612_1utf8.dta"
    ) %>%
      select(lfd, gewbr_w3, gewab_w3)
  ) %>%
  left_join(
    read_dta("data/2017/infas_Methodendatensatz_WSI_BR_5535_20170621.dta") %>%
      select(-k_rc, -l_krc, -sprachkon, -frabv, -aapor)
  ) %>%
  mutate(gewbr_l_w3 = gewbr_w3, gewab_l_w3 = gewab_w3) %>% 
  left_join(
    read_dta("data/2017/brbefragung_interviewerdaten_2017.dta"),
    by=c("internr_n" = "INTERNR")
  )

# 2018 nachträglich mit Gewichten geliefert
dat[["2018"]] <- 
  read_dta(
    "data/2018/infas_5806_Befragungsdaten_WSI_BR_2018_Gewichte_20180612_1utf8.dta"
    ) %>%
  select(lfd:J8, gewbr_w4, gewab_w4) %>%
  left_join(
    read_dta("data/2018/infas_Methodendatensatz_WSI_BR_2018_20180626_1_utf8.dta") %>%
      select(-k_rc, -l_krc, -sprachkon, -frabv, -aapor)
  ) %>%
  mutate(gewbr_l_w4 = gewbr_w4, gewab_l_w4 = gewab_w4) %>% 
  left_join(
    read_dta("data/2018/infas_Interviewerdatensatz_WSI_BR_2018_20180626_1_utf8.dta"),
    by=c("internr_n" = "internr")
  )
  
dat[["2021"]] <- 
  read_dta("data/2021/015390_WSI_BRPR_2021_Daten_ungewichtet_UPDATE.dta") %>%
  left_join(read_dta("data/2021/gewicht_2021.dta")) %>%
  left_join(
    read_dta("data/2021/015390_WSI_BRPR_BRUTTOSTICHPROBE_WSI_UPDATE_UPDATE.dta") %>%
      select(lfn_015390, lfd_schichtung, brpr_ursprung, bland, N_Kontakt, intv_name,
             intv_age) %>%
      rename("lfd_alt" = lfd_schichtung)
  ) %>%
  mutate(gewicht_l = gewicht) 
  



  