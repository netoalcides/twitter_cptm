info( logger, "TWITTER_PROJECT::dividir bases de treino, validacao e teste" )

dados_cptm_treino_validacao <- dados_cptm %>% 
  filter( data_ajustada < "2017-02-27" )

dados_cptm_teste <- dados_cptm %>% 
  filter( data_ajustada >= "2017-02-27" )

rm(dados_cptm)

gc()