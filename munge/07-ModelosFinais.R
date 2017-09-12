info( logger, "TWITTER_PROJECT::ajustando modelos finais" )

info( logger, "TWITTER_PROJECT::ajustando modelo XG amostra estratificada" )

load("~/Projects/twitter_project/src/modeloXGamostraestrat.RData")

# Melhores parametros
best_param_xg_estrat <- Resultados_Tunning_XG_Estrat %>% 
  arrange( desc(Accuracy_valid) ) %>% 
  head(1)

# Dados para o treino
dados_tm_tweets <- tweets_tm[, colSums(tweets_tm) >= best_param_xg_estrat$N_word ]

dados_modelo_tweets <- cbind( polaridade = ( dados_cptm_treino_validacao$polaridade + 1 ),
                      dados_tm_tweets )

dados_modelo_tweets <- xgb.DMatrix( data = as.matrix( dados_modelo_tweets[, -1] ), 
                                       label = dados_modelo_tweets$polaridade )

rm(dados_tm_tweets)
gc()

# Estima o modelo

param <- list(objective = "multi:softmax",
              eval_metric = "merror",
              eval_metric = "mlogloss",
              num_class = 3,
              max_depth = best_param_xg_estrat$Best_max_depth_xg,
              eta = best_param_xg_estrat$Best_eta_xg,
              gamma = best_param_xg_estrat$Best_gamma_xg,
              subsample = best_param_xg_estrat$Best_subsample_xg,
              colsample_bytree = best_param_xg_estrat$Best_colsample_bytree_xg, 
              min_child_weight = best_param_xg_estrat$Best_min_child_weight_xg,
              max_delta_step = best_param_xg_estrat$Best_max_delta_step_xg
)

set.seed( best_param_xg_estrat$Seeds )

modelo_xg_estrat_tweets_final <- xgb.train( data = dados_modelo_tweets, 
                               params = param, 
                               nrounds = best_param_xg_estrat$Best_nround )



info( logger, "TWITTER_PROJECT::ajustando modelo XG amostra proporcional" )

load("~/Projects/twitter_project/src/modeloXGamostraprop.RData")

# Melhores parametros
best_param_xg_propor <- Resultados_Tunning_XG_Propor %>% 
  arrange( desc(Accuracy_valid) ) %>% 
  head(1)

# Dados para o treino
dados_tm_tweets <- tweets_tm[, colSums(tweets_tm) >= best_param_xg_propor$N_word ]

dados_modelo_tweets <- cbind( polaridade = ( dados_cptm_treino_validacao$polaridade + 1 ),
                              dados_tm_tweets )

#Pesos para polaridade negativa
peso_negativo <- dados_modelo_tweets %>%
  count( polaridade, sort = TRUE ) %>%
  mutate( p = n/sum(n),
          inversa = 1/p,
          prop_inversa = inversa/sum(inversa) ) %>%
  data.frame %>%
  filter( polaridade == 0 ) %>%
  select(prop_inversa)

#Pesos para polaridade neutra
peso_neutro <- dados_modelo_tweets %>%
  count( polaridade, sort = TRUE ) %>%
  mutate( p = n/sum(n),
          inversa = 1/p,
          prop_inversa = inversa/sum(inversa) ) %>%
  data.frame %>%
  filter( polaridade == 1) %>%
  select(prop_inversa)

#Pesos para polaridade positiva
peso_positivo <- dados_modelo_tweets %>%
  count( polaridade, sort = TRUE ) %>%
  mutate( p = n/sum(n),
          inversa = 1/p,
          prop_inversa = inversa/sum(inversa) ) %>%
  data.frame %>%
  filter( polaridade == 2) %>%
  select(prop_inversa)

proporcao <- ifelse( dados_modelo_tweets$polaridade == 0, peso_negativo$prop_inversa,
                     ifelse( dados_modelo_tweets$polaridade == 1, peso_neutro$prop_inversa,
                             peso_positivo$prop_inversa) )

#Pesos para polaridade negativa
peso_negativo <- dados_modelo_tweets %>%
  count( polaridade, sort = TRUE ) %>%
  mutate( p = n/sum(n) ) %>%
  data.frame %>%
  filter( polaridade == 0 ) %>%
  select(p)

#Pesos para polaridade neutra
peso_neutro <- dados_modelo_tweets %>%
  count( polaridade, sort = TRUE ) %>%
  mutate( p = n/sum(n) ) %>%
  data.frame %>%
  filter( polaridade == 1) %>%
  select(p)

#Pesos para polaridade positiva
peso_positivo <- dados_modelo_tweets %>%
  count( polaridade, sort = TRUE ) %>%
  mutate( p = n/sum(n) ) %>%
  data.frame %>%
  filter( polaridade == 2) %>%
  select(p)

proporcao_pos <- ifelse( dados_modelo_tweets$polaridade == 0, peso_negativo$p,
                         ifelse( dados_modelo_tweets$polaridade == 1, peso_neutro$p,
                                 peso_positivo$p) )

dados_modelo_tweets <- xgb.DMatrix( data = as.matrix( dados_modelo_tweets[, -1] ), 
                                    label = dados_modelo_tweets$polaridade,
                                    weight = proporcao)

rm(dados_tm_tweets)
gc()

# Estima o modelo

param <- list(objective = "multi:softmax",
                   eval_metric = "merror",
                   eval_metric = "mlogloss",
                   num_class = 3,
                   max_depth = best_param_xg_propor$Best_max_depth_xg,
                   eta = best_param_xg_propor$Best_eta_xg,
                   gamma = best_param_xg_propor$Best_gamma_xg,
                   subsample = best_param_xg_propor$Best_subsample_xg,
                   colsample_bytree = best_param_xg_propor$Best_colsample_bytree_xg, 
                   min_child_weight = best_param_xg_propor$Best_min_child_weight_xg,
                   max_delta_step = best_param_xg_propor$Best_max_delta_step_xg,
                   scale_pos_weight = proporcao_pos
)

set.seed( best_param_xg_propor$Seeds )

modelo_xg_propor_tweets_final <- xgb.train( data = dados_modelo_tweets, 
                                            params = param, 
                                            nrounds = best_param_xg_propor$Best_nround )

rm( dados_modelo_tweets, param, 
   peso_negativo, peso_neutro, peso_positivo, proporcao,                    
   Resultados_Tunning_XG_Estrat, Resultados_Tunning_XG_Propor )
gc()







