############################################################
#### analise exploratoria ####
############################################################

var <- c("polaridade", "screenName", "data")

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
        count(data, polaridade) %>%
        data.frame %>% 
        spread( key = polaridade, value = n)



dados_cptm %>%
        mutate( polaridade = as.factor(polaridade) ) %>% 
        count(data, polaridade) %>%
        mutate( p = n/sum(n) ) %>% 
        select( -n ) %>% 
        data.frame %>% 
        spread( key = polaridade, value = p)


############################################################
#### TEXT MINNING ####
############################################################

tweets_tm[ grep("viananovoproblem", tweets_tm, ignore.case = TRUE) ]


# tweets_tm <- gsub('[[:punct:]]', "", tweets_tm)
# tweets_tm <- gsub('[[:cntrl:]]', "", tweets_tm)
# tweets_tm <- gsub("http\\S+\\s*", "", tweets_tm)
# tweets_tm <- gsub("\\d+", "", tweets_tm)
# tweets_tm <- gsub("[^[:graph:]]", " ", tweets_tm)
#x <- str_replace_all(x,"[^[:graph:]]", " ")
#x <- iconv(x, "ASCII", "UTF-8", sub="")
#x <- iconv(x, "ISO-8859-1", "ASCII", sub="")
#x <- tolower(x)

# tweets_tm <- tm_map( tweets_tm, removeNumbers )
# tweets_tm <- tm_map( tweets_tm, removePunctuation )
# tweets_tm <- tm_map( tweets_tm, content_transformer(tolower) )
# tweets_tm <- tm_map( tweets_tm, stripWhitespace )
# tweets_tm <- tm_map( tweets_tm, removeWords, c( stopwords("portuguese"), "linha", 
#                                 "transitosp", 
#                                 sptrem", "metrosp",
#                                 "usuariosmetrosp", "metrospoficial" ) )
# tweets_tm <- tm_map( tweets_tm, stemDocument, language = "portuguese" )
# #x <- tm_map( x, replaceSynonyms, synonyms )
# tweets_tm <- tm_map( tweets_tm, PlainTextDocument )
# tweets_tm <- DocumentTermMatrix( tweets_tm )
# 
# tweets_tm <- tweets_tm %>% as.matrix() %>% data.frame()

colnames( tweets_tm )[3901:4000]

#tirar
#cesartrall

#mudar
#acidentesambulantesroubosassédi
#acompanharoficial
#afff - trocar por aff
#ahahahah, ahahh - trocar por hahaha
#aprovaconcurs
#apuracaosp
#aquieuconfi
#atualizaçãol
#aventureiracarnaval
#bençaproblem
#boaflux, boalot, boanoit
#bomdiasp, bommédi, bommédioalt, bommm, bomnotic, bomveloc
#brincadeiraprivatiz
#caminhodaroçaoudol
#chegalogodiademai
#ciberseguranc
#coisaess
#comandosp
#comecouocarnaval
#corinthiansitaqu
#descarilh, descarreg, descarril, descarrilamen, descarrilamentodetr, descarrilamentoeit, descarrilamet, descarrilan, descarrilh
#desligadoextermíni, desligadogrupodiari
#desseskkkkkkkk
#deussss, deuuuuus
#dicacultural
#domingoobrig
#extrakamaulicencapoet
#expostodesproteg
#hah, hahah, hahahah, hahahahahah - mudar para haha
#históricainfosgrupodiari
#horariodevera, horáriodeverãocom
#incompetênciatr
#lentidãoalalaôalckmin
#melhorzinhalinh
#obrasgrupodiari
#ocorrênciaporém, ocorrênciasencaminh
#oficialacident, oficialalgum, oficialisabel, oficiallinhacoral, oficialsr, oficialvej
#operacaobetalab, operaçãopaes, operacion, operacionaisim, operacional, operacionald
#prometelinharubigd
#protejamasmulheresnosvago, protejamasmulheresnosvagoesp
#públicooficial
#qualidadedevidapaul
#questionamentosporém
#regularmentebo, regularmentecvelocreduz
#responderpo, respondidassalv
#sindicatocentral
#todocarnavaltemseufim, todosconscientiz, todosnocarnaval, tooooooood
#usuariocpt, usuariosmet, usuariosmetr, usuariospgovbr, usuariostrenssp, usurp
#viananovoproblem

# Frequencia dos termos

freq_termos <- tweets_tm %>% 
  summarise_each( funs(sum) ) %>% 
  gather( word, freq ) %>% 
  arrange( desc(freq) ) %>% 
  data.frame

freq_termos %>% 
  filter(word == "atualizaçãol")



# ggplot( freq_termos, aes(x = reorder(word, -freq), y = freq) ) + 
#   geom_bar(stat="identity")
# 
# freq_termos %>% 
#   filter(freq > 100) %>% 
#   ggplot( ., aes(x = reorder(word, -freq), y = freq) ) + 
#   geom_bar(stat="identity")
# 
# freq_termos %>% 
#   filter(freq > 500) %>% 
#   wordcloud( word, freq )
#   
# wordcloud( freq_termos$word, freq_termos$freq, max.words = 100 )




#sinonimos
#afff - trocar por aff
#ahahahah, ahahh - trocar por hahaha
#hah, hahah, hahahah, hahahahahah - mudar para haha
#deussss, deuuuuus
#descarilh, descarril, descarrilamen, descarrilamentodetr, descarrilamentoeit, descarrilamet, descarrilan, descarrilh
#bommm - trocar por bom
#tooooooood - trocar por todo

############################################################
#### LSA ####
############################################################



svd <- lsa( tweets_tm, dimcalc_kaiser() )

k <- length(svd$sk)

rm(svd)

nmf_twitter <- nmf( as.matrix(tweets_tm), 5, 'snmf/r', nrun = 2, seed = 123456)

tweets_tm %>% 
  filter( rowSums(.) == 0 )

#pesos <- svd$dk

#df_26.01.s$c1 <- apply(pesos[,1]*df_26.01.s[,16:47], 1, sum)
#df_26.01.s$c2 <- apply(pesos[,2]*df_26.01.s[,16:47], 1, sum)
#df_26.01.s$c3 <- apply(pesos[,3]*df_26.01.s[,16:47], 1, sum)


############################################################
#### Resultados ####
############################################################


load("~/Projects/twitter_project/src/modeloXGamostraestrat_teste1.RData")

Resultados_Tunning_XG_Estrat %>%
  arrange( desc(Accuracy_valid) ) %>% 
  head(5)

load("~/Projects/twitter_project/src/modeloXGamostraprop_teste1.RData")

Resultados_Tunning_XG_Propor %>%
  arrange( desc(Accuracy_valid) ) %>% 
  head(5)


load("~/Projects/twitter_project/src/resultados_amostra_teste1.RData")

cf_xg_estrat
cf_xg_propor

erro_indice_mae
erro_indice_rmse

pol_index_xg_estrat_plot
pol_index_xg_propor_plot
