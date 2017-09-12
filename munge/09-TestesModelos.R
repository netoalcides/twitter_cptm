info( logger, "TWITTER_PROJECT::analise amostra de teste iniciado" )

info( logger, "TWITTER_PROJECT::ajustando dataset de teste" )

dados_cptm_teste %<>%
  mutate( polarizacao_prevista_xg_estrat = polarizacao_prevista_xg_estrat,
          polarizacao_prevista_xg_propor = polarizacao_prevista_xg_propor )

na_xg_estrat <- dados_cptm_teste %>% 
  count( polarizacao_prevista_xg_estrat ) %>% 
  filter( polarizacao_prevista_xg_estrat == "NA" )

na_xg_propor <- dados_cptm_teste %>% 
  count( polarizacao_prevista_xg_propor ) %>% 
  filter( polarizacao_prevista_xg_propor == "NA" )


info( logger, "TWITTER_PROJECT::obtendo resultados" )

# Matriz de confusão

dados_cptm_teste_estrat <- dados_cptm_teste %>% 
  filter( polarizacao_prevista_xg_estrat != "NA" ) %>% 
  mutate( polaridade = ifelse( polaridade == 1, "POSITIVO", 
                       ifelse( polaridade == 0, "NEUTRO", "NEGATIVO") ),
          polarizacao_prevista_xg_estrat = ifelse( polarizacao_prevista_xg_estrat == 1, "POSITIVO", 
                                           ifelse( polarizacao_prevista_xg_estrat == 0, "NEUTRO", "NEGATIVO") ) )

dados_cptm_teste_propor <- dados_cptm_teste %>% 
  filter( polarizacao_prevista_xg_propor != "NA" ) %>% 
  mutate( polaridade = ifelse( polaridade == 1, "POSITIVO", 
                               ifelse( polaridade == 0, "NEUTRO", "NEGATIVO") ),
          polarizacao_prevista_xg_propor = ifelse( polarizacao_prevista_xg_propor == 1, "POSITIVO", 
                                           ifelse( polarizacao_prevista_xg_propor == 0, "NEUTRO", "NEGATIVO") ) )

rm(dados_cptm_teste)
gc()

cf_xg_estrat <- confusionMatrix( dados_cptm_teste_estrat$polarizacao_prevista_xg_estrat, dados_cptm_teste_estrat$polaridade )
cf_xg_propor <- confusionMatrix( dados_cptm_teste_propor$polarizacao_prevista_xg_propor, dados_cptm_teste_propor$polaridade )

# Índice de sentimento

dados_indice_estrat <- dados_cptm_teste_estrat %>%
  mutate( tweets_neg = ifelse( polaridade == "NEGATIVO", 1, 0),
          tweets_neg_xg_estrat = ifelse( polarizacao_prevista_xg_estrat == "NEGATIVO", 1, 0),
          tempo = round_date( created, unit = "hours"  ) ) %>% 
  group_by( tempo ) %>%
  summarise( pol_index = ( sum(tweets_neg) ) / n(),
             pol_index_xg_estrat = sum(tweets_neg_xg_estrat) / n() ) %>%
  data.frame

dados_indice_propor <- dados_cptm_teste_propor %>%
  mutate( tweets_neg = ifelse( polaridade == "NEGATIVO", 1, 0),
          tweets_neg_xg_propor = ifelse( polarizacao_prevista_xg_propor == "NEGATIVO", 1, 0),
          tempo = round_date( created, unit = "hours"  ) ) %>% 
  group_by( tempo ) %>%
  summarise( pol_index = ( sum(tweets_neg) ) / n(),
             pol_index_xg_propor = sum(tweets_neg_xg_propor) / n() ) %>%
  data.frame

erro_indice_mae <- cbind(
  dados_indice_estrat %>%
    summarise( xg_estrat = mean( abs(pol_index - pol_index_xg_estrat) ) ),
  dados_indice_propor %>%
    summarise( xg_propor = mean( abs(pol_index - pol_index_xg_propor) ) )
)

erro_indice_rmse <- cbind(
  dados_indice_estrat %>%
    summarise( xg_estrat = sqrt( mean( (pol_index - pol_index_xg_estrat)^2 ) ) ),
  dados_indice_propor %>%
    summarise( xg_propor = sqrt( mean( (pol_index - pol_index_xg_propor)^2 ) ) )
)

pol_index_xg_estrat_plot <- ggplot(dados_indice_estrat, aes( tempo ) ) +
  geom_line( aes(y = pol_index, colour = "pol_index") ) +
  geom_line( aes(y = pol_index_xg_estrat, colour = "pol_index_xg_estrat") )

pol_index_xg_propor_plot <- ggplot(dados_indice_propor, aes( tempo ) ) +
  geom_line( aes(y = pol_index, colour = "pol_index") ) +
  geom_line( aes(y = pol_index_xg_propor, colour = "pol_index_xg_propor") )


save( na_xg_estrat,
      na_xg_propor,
      cf_xg_estrat,
      cf_xg_propor,
      pol_index_xg_estrat_plot,
      pol_index_xg_propor_plot,
      erro_indice_mae,
      erro_indice_rmse,
      file = "src/resultados_amostra_teste.RData")

info( logger, "TWITTER_PROJECT::analise amostra de teste finalizado" )

info( logger, "TWITTER_PROJECT::finalizado" )

rm( list = ls() )











