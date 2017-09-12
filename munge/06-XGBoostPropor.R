info( logger, "TWITTER_PROJECT::testando modelo XGBoost Amostra Proporcional" )

info( logger, "TWITTER_PROJECT::tunning XGBoost" )

iteracoes <- 5 # numero de iteracoes para tunning
s_seeds <- sample(1000000:9999999, iteracoes) # sementes aleatorias
cv.nround <- 20
cv.nfold <- 5
early_stop <- 15


# Parametros das iteracoes #
n_word <- NULL
max_depth_xg <- NULL
eta_xg <- NULL
gamma_xg <- NULL
subsample_xg <- NULL
colsample_bytree_xg <- NULL
min_child_weight_xg <- NULL
max_delta_step_xg <- NULL


# Parametros dos melhores modelos #
N_word <- list()
Best_max_depth_xg <- list()
Best_eta_xg <- list()
Best_gamma_xg <- list()
Best_subsample_xg <- list()
Best_colsample_bytree_xg <- list()
Best_min_child_weight_xg <- list()
Best_max_delta_step_xg <- list()
Best_nround <- list()
Accuracy_train <- list()
Accuracy_valid <- list()


### Iteracoes para tunning
for(iter in 1:iteracoes){
  
  info( logger, paste( "TWITTER_PROJECT:Iteracao Tunning XGBoost Amostra Proporcional", iter ) )
  cat('Iteracao Tunning XGBoost Amostra Proporcional', iter, '\n')
  
  
  # Parametros
  set.seed( s_seeds[iter] )
  n_word <- sample(10:150, 1)
  max_depth_xg = sample(6:18, 1)
  eta_xg = runif(1, .01, .3)
  gamma_xg = runif(1, 0.001, 0.5)
  subsample_xg = runif(1, .6, .9)
  colsample_bytree_xg = runif(1, .5, .8)
  min_child_weight_xg = sample(1:40, 1)
  max_delta_step_xg = sample(1:10, 1)
  
  
  # Guarda Parametros
  N_word[[length(N_word) + 1]] <- n_word
  Best_max_depth_xg[[length(Best_max_depth_xg) + 1]] <- max_depth_xg
  Best_eta_xg[[length(Best_eta_xg) + 1]] <- eta_xg
  Best_gamma_xg[[length(Best_gamma_xg) + 1]] <- gamma_xg
  Best_subsample_xg[[length(Best_subsample_xg) + 1]] <- subsample_xg
  Best_colsample_bytree_xg[[length(Best_colsample_bytree_xg) + 1]] <- colsample_bytree_xg
  Best_min_child_weight_xg[[length(Best_min_child_weight_xg) + 1]] <- min_child_weight_xg
  Best_max_delta_step_xg[[length(Best_max_delta_step_xg) + 1]] <- max_delta_step_xg
  
  
  # Amostras
  dados_tm_tweets <- tweets_tm[, colSums( tweets_tm ) >= n_word]
  
#   dadosTreino <- cbind(polaridade = (dados_cptm_treino_validacao$polaridade + 1),
#                        dados_tm_tweets, tweets_lsa)
  
  dadosTreino <- cbind( polaridade = ( dados_cptm_treino_validacao$polaridade + 1 ),
                       dados_tm_tweets )
  
  #Pesos para polaridade negativa
  peso_negativo <- dadosTreino %>%
    count( polaridade, sort = TRUE ) %>%
    mutate( p = n/sum(n),
            inversa = 1/p,
            prop_inversa = inversa/sum(inversa) ) %>%
    data.frame %>%
    filter( polaridade == 0 ) %>%
    select(prop_inversa)
  
  #Pesos para polaridade neutra
  peso_neutro <- dadosTreino %>%
    count( polaridade, sort = TRUE ) %>%
    mutate( p = n/sum(n),
            inversa = 1/p,
            prop_inversa = inversa/sum(inversa) ) %>%
    data.frame %>%
    filter( polaridade == 1) %>%
    select(prop_inversa)
  
  #Pesos para polaridade positiva
  peso_positivo <- dadosTreino %>%
    count( polaridade, sort = TRUE ) %>%
    mutate( p = n/sum(n),
            inversa = 1/p,
            prop_inversa = inversa/sum(inversa) ) %>%
    data.frame %>%
    filter( polaridade == 2) %>%
    select(prop_inversa)
  
  proporcao <- ifelse( dadosTreino$polaridade == 0, peso_negativo$prop_inversa,
                       ifelse( dadosTreino$polaridade == 1, peso_neutro$prop_inversa,
                               peso_positivo$prop_inversa) )
  
  rm(dados_tm_tweets)
  gc()
  
  
  # Modelo XGBoost #
  dadosTreino <- xgb.DMatrix(data = as.matrix( dadosTreino[, -1] ), 
                             label = dadosTreino$polaridade,
                             weight = proporcao)
  
  param <- list(objective = "multi:softmax",
                eval_metric = "merror",
                eval_metric = "mlogloss",
                num_class = 3,
                max_depth = max_depth_xg,
                eta = eta_xg,
                gamma = gamma_xg,
                subsample = subsample_xg,
                colsample_bytree = colsample_bytree_xg, 
                min_child_weight = min_child_weight_xg,
                max_delta_step = max_delta_step_xg
  )
  
  set.seed( s_seeds[iter] )
  
  tweets_xg_cv <- xgb.cv( data = dadosTreino, 
                          params = param, 
                          nthread = 1, 
                          nfold = cv.nfold, 
                          nround = cv.nround,
                          verbose = T, 
                          early_stopping_rounds = early_stop, 
                          maximize = FALSE)
  
  # Previsoes teste
  best_iteration <- which.min( tweets_xg_cv$evaluation_log[, test_mlogloss_mean] )
  Best_nround[[length(Best_nround) + 1]] <- best_iteration
  Accuracy_train[[length(Accuracy_train) + 1]] <- 1 - tweets_xg_cv$evaluation_log[best_iteration, train_merror_mean]
  Accuracy_valid[[length(Accuracy_valid) + 1]] <- 1 - tweets_xg_cv$evaluation_log[best_iteration, test_merror_mean]
  
  rm(best_iteration, tweets_xg_cv, param, dadosTreino)
  gc()
  
}


Resultados_Tunning_XG_Propor <- data.frame(
  N_word = do.call(rbind, N_word),
  Seeds = s_seeds,
  Best_nround = do.call( rbind, Best_nround ),
  Best_max_depth_xg = do.call(rbind, Best_max_depth_xg),
  Best_eta_xg = do.call(rbind, Best_eta_xg),
  Best_gamma_xg = do.call(rbind, Best_max_depth_xg),
  Best_subsample_xg = do.call(rbind, Best_subsample_xg),
  Best_colsample_bytree_xg = do.call(rbind, Best_colsample_bytree_xg),
  Best_min_child_weight_xg = do.call(rbind, Best_min_child_weight_xg),
  Best_max_delta_step_xg = do.call(rbind, Best_max_delta_step_xg),
  Accuracy_train = do.call(rbind, Accuracy_train),
  Accuracy_valid = do.call(rbind, Accuracy_valid) )

save(Resultados_Tunning_XG_Propor, file = "src/modeloXGamostraprop.RData")

rm( Accuracy_valid, Accuracy_train, Best_colsample_bytree_xg, Best_eta_xg, 
    Best_gamma_xg, Best_max_delta_step_xg, Best_max_depth_xg, Best_min_child_weight_xg, 
    Best_nround, Best_subsample_xg, colsample_bytree_xg, eta_xg, gamma_xg, 
    max_delta_step_xg, max_depth_xg, min_child_weight_xg, Resultados_Tunning_XG_Propor, 
    subsample_xg, iteracoes, s_seeds, cv.nround, cv.nfold, n_word, N_word )

gc()

info( logger, "TWITTER_PROJECT::teste modelo XGBoost Amostra Proporcional finalizado" )




