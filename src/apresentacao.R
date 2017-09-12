# Carrega pacotes e dados

source("~/Projects/twitter_project/src/init_twitter_project.R")

# Ajusta dados

source("~/Projects/twitter_project/munge/01-AjusteDados.R")

# Divide Treino e Validação

source("~/Projects/twitter_project/munge/02-DivideTreinoValidacaoTeste.R")

# Tratamento dos dados - "nesse caso foi texto"

source("~/Projects/twitter_project/munge/03-TextMinning.R")

############################################################
#### analise exploratoria ####
############################################################

dados_cptm %>% 
  select(created, texto_do_twitter, polaridade) %>% 
  head(15)


var <- c("polaridade", "screenName", "data_ajustada")

for( v in var){
  
  cat( v, "\n" )
  
  show( dados_cptm %>% 
          count_( v, sort = TRUE ) %>% 
          mutate( p = n/sum(n) ) 
        
  )
  
  cat( "\n" )
  
}


dados_cptm %>%
  mutate( polaridade = as.factor(polaridade) ) %>% 
  count(data_ajustada, polaridade) %>%
  data.frame %>% 
  spread( key = polaridade, value = n)

dados_cptm %>%
  mutate( polaridade = as.factor(polaridade) ) %>% 
  count(data_ajustada, polaridade) %>%
  data.frame %>% 
  ggplot( aes( x = data_ajustada, y = n, colour = polaridade ) ) +
  geom_line() 


dados_cptm %>%
  mutate( polaridade = as.factor(polaridade) ) %>% 
  count(data_ajustada, polaridade) %>%
  mutate( p = n/sum(n) ) %>% 
  select( -n ) %>% 
  data.frame %>% 
  spread( key = polaridade, value = p)


dados_cptm %>%
  mutate( polaridade = as.factor(polaridade) ) %>% 
  count(data_ajustada, polaridade) %>%
  mutate( p = n/sum(n) ) %>% 
  select( -n ) %>% 
  data.frame %>% 
  ggplot( aes( x = data_ajustada, y = p, colour = polaridade ) ) +
  geom_line() 


freq_termos <- tweets_tm %>% 
  summarise_each( funs(sum) ) %>% 
  gather( word, freq ) %>% 
  arrange( desc(freq) ) %>% 
  data.frame

############################################################
#### Mineracao de texto ####
############################################################

library(wordcloud)

freq_termos <- tweets_tm %>% 
  summarise_each( funs(sum) ) %>% 
  gather( word, freq ) %>% 
  arrange( desc(freq) ) %>% 
  data.frame

freq_termos %>% 
  filter(freq > 500) %>% 
  ggplot( ., aes(x = reorder(word, -freq), y = freq) ) + 
  geom_bar(stat="identity") +
  xlab( "palavras" )

wordcloud( freq_termos$word, freq_termos$freq, max.words = 100 )

############################################################
#### Modelo ####
############################################################

source("~/Projects/twitter_project/munge/05-XGBoostEstrat.R")

############################################################
#### Resultados ####
############################################################


load("~/Projects/twitter_project/src/modeloXGamostraestrat_teste1.RData")

Resultados_Tunning_XG_Estrat %>%
  arrange( desc(Accuracy_valid) ) %>% 
  dim()


Resultados_Tunning_XG_Estrat %>%
  arrange( desc(Accuracy_valid) ) %>% 
  head(5)

load("~/Projects/twitter_project/src/modeloXGamostraprop_teste1.RData")

Resultados_Tunning_XG_Propor %>%
  arrange( desc(Accuracy_valid) ) %>% 
  dim()


Resultados_Tunning_XG_Propor %>%
  arrange( desc(Accuracy_valid) ) %>% 
  head(5)


load("~/Projects/twitter_project/src/resultados_amostra_teste1.RData")

dados_cptm_teste %>% 
  select(created, texto_do_twitter) %>% 
  head(5)

cf_xg_estrat
cf_xg_propor

erro_indice_mae
erro_indice_rmse

pol_index_xg_estrat_plot
pol_index_xg_propor_plot
