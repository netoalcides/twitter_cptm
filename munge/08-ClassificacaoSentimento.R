info( logger, "TWITTER_PROJECT::classificacao dos sentimentos" )

polarizacao_prevista_xg_estrat <- NULL
polarizacao_prevista_xg_propor <- NULL


info( logger, "TWITTER_PROJECT::criando dicionarios" )

dados_tm_tweets_estrat <- tweets_tm[, colSums(tweets_tm) >= best_param_xg_estrat$N_word ]
dados_tm_tweets_propor <- tweets_tm[, colSums(tweets_tm) >= best_param_xg_propor$N_word ]

dicionario_estrat <- dados_tm_tweets_estrat[1, ]
dicionario_propor <- dados_tm_tweets_propor[1, ]

gc()

# crude2.dtm <- DocumentTermMatrix( ajusta_textos, 
#                                   control = list(
#                                   dictionary = Terms(tweets_tm) ) )


info( logger, "MASSMEDIAPOC::obtendo polaridades modelo amostra estratificada" )

for( i in 1:dim(dados_cptm_teste)[1] ){
  
  dic_estrat <- dicionario_estrat

  # palavras
  
  ajusta_textos <- funcao_tm_cptm_twitter( dados_cptm_teste$texto_do_twitter[i]  )
  
  match_palavras_dic_estrat <- pmatch( colnames(ajusta_textos), colnames(dic_estrat) ) %>%
    na.omit

  if( length( match_palavras_dic_estrat ) == 0  ){
    
    polarizacao_prevista_xg_estrat[i] <- "NA"
    
  } else {
    
    # quantidade
    dic_estrat[, -match_palavras_dic_estrat] <- 0
    
    dic_estrat[, match_palavras_dic_estrat] <- ajusta_textos[, if( is.null( attributes(match_palavras_dic_estrat)$na.action ) == TRUE ){ 
      colnames(ajusta_textos) } else { -attributes(match_palavras_dic_estrat)$na.action } ]
    
    score_dataset <- dic_estrat
    score_dataset_xg <- xgb.DMatrix( data = as.matrix( score_dataset ) )
    
    polarizacao_prevista_xg_estrat[i] <- predict(modelo_xg_estrat_tweets_final, score_dataset_xg) - 1
    
  }
  
  info( logger, paste( "TWITTER_PROJECT::texto analisado", i ) )
  
}

info( logger, "MASSMEDIAPOC::obtendo polaridades modelo amostra proporcional" )

for( i in 1:dim(dados_cptm_teste)[1] ){
  
  dic_propor <- dicionario_propor
  
  # palavras
  
  ajusta_textos <- funcao_tm_cptm_twitter( dados_cptm_teste$texto_do_twitter[i]  )
  
  match_palavras_dic_propor <- pmatch( colnames(ajusta_textos), colnames(dic_propor) ) %>%
    na.omit
  
  if( length( match_palavras_dic_propor ) == 0  ){
    
    polarizacao_prevista_xg_propor[i] <- "NA"
    
  } else {
    
    # quantidade
    dic_propor[, -match_palavras_dic_propor] <- 0
    
    dic_propor[, match_palavras_dic_propor] <- ajusta_textos[, if( is.null( attributes(match_palavras_dic_propor)$na.action ) == TRUE ){ 
      colnames(ajusta_textos) } else { -attributes(match_palavras_dic_propor)$na.action } ]
    
    score_dataset <- dic_propor
    score_dataset_xg <- xgb.DMatrix( data = as.matrix( score_dataset ) )
    
    polarizacao_prevista_xg_propor[i] <- predict(modelo_xg_propor_tweets_final, score_dataset_xg) - 1
    
  }
  
  info( logger, paste( "TWITTER_PROJECT::texto analisado", i ) )
  
}
