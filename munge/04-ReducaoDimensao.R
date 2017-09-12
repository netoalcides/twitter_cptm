# info( logger, "TWITTER_PROJECT::Latent Semantic Analysis" )
# 
# info( logger, "TWITTER_PROJECT::obtendo matriz reduzida" )
# 
# svd <- lsa( tweets_tm, dims = dimcalc_kaiser() )
# 
# info( logger, "TWITTER_PROJECT::obtendo melhores dimensoes" )
# 
# svd <- svd$sk %>% 
#   data.frame %>% 
#   rename_(sk = "." ) %>% 
#   mutate( p = sk/sum(sk),
#           soma_p = cumsum(p) ) %>%
#   filter( soma_p < 0.6 ) %>% 
#   dim
# 
# gc()
# 
# info( logger, "TWITTER_PROJECT::obtendo matriz com melhores dimensoes" )
# 
# svd <- lsa( tweets_tm, dims = svd[1] )
# 
# tweets_lsa <- svd$tk %>% data.frame
# pesos_lsa <- svd$dk
# 
# rm(svd)
# gc()