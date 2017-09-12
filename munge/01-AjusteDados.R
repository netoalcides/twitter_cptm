info( logger, "TWITTER_PROJECT::iniciado" )

info( logger, "TWITTER_PROJECT::combinando twitter e polaridade" )

dados_cptm <- cbind.data.frame(dados_tweets, polaridade)

info( logger, "TWITTER_PROJECT::ajustando dados" )

dados_cptm %<>% 
  mutate( data_ajustada = as.Date(created) ) %>% 
  rename( texto_do_twitter = text )

dados_cptm[dados_cptm$id == "834793432778407936", 5] <- 0
dados_cptm[dados_cptm$id == "834345743599226880", 5] <- -1
dados_cptm[dados_cptm$id == "834076472742670336", 5] <- -1
dados_cptm[dados_cptm$id == "833423985836773378", 5] <- -1

# linha 92, trocar para -1
dados_cptm[92, 5] <- -1

# linha 96, trocar para -1
dados_cptm[96, 5] <- -1

# linha 104, trocar para -1
dados_cptm[104, 5] <- -1

# linha 114, trocar para -1
dados_cptm[114, 5] <- -1

# linha 117, trocar para -1
dados_cptm[117, 5] <- -1

# linha 182, trocar para -1
dados_cptm[182, 5] <- -1

# linha 216, trocar para -1
dados_cptm[216, 5] <- -1

# linha 251, trocar para -1
dados_cptm[251, 5] <- -1

# linha 283, trocar para -1
dados_cptm[283, 5] <- -1

# linha 284, trocar para -1
dados_cptm[284, 5] <- -1

# linha 288, trocar para -1
dados_cptm[288, 5] <- -1

# linha 289, trocar para -1
dados_cptm[289, 5] <- -1

# linha 295, trocar para -1
dados_cptm[295, 5] <- -1

# linha 297, trocar para -1
dados_cptm[297, 5] <- -1

# linha 302, trocar para -1
dados_cptm[302, 5] <- -1

# linha 392, trocar para -1
dados_cptm[392, 5] <- -1

# linha 393, trocar para -1
dados_cptm[393, 5] <- -1

# linha 401, trocar para -1
dados_cptm[401, 5] <- -1

# linha 405, trocar para 1
dados_cptm[405, 5] <- -1

# linha 453, trocar para -1
dados_cptm[453, 5] <- -1

# linha 459, trocar para -1
dados_cptm[459, 5] <- -1

# linha 519, trocar para -1
dados_cptm[519, 5] <- -1

# linha 530, trocar para -1
dados_cptm[530, 5] <- -1

# linha 535, trocar para -1
dados_cptm[535, 5] <- -1

# linha 536, trocar para -1
dados_cptm[536, 5] <- -1

# linha 539, trocar para -1
dados_cptm[539, 5] <- -1

# linha 548, trocar para -1
dados_cptm[548, 5] <- -1

# linha 550, trocar para -1
dados_cptm[550, 5] <- -1

# linha 551, trocar para -1
dados_cptm[551, 5] <- -1

# linha 558, trocar para -1
dados_cptm[558, 5] <- -1

# linha 559, trocar para -1
dados_cptm[559, 5] <- -1

# linha 563, trocar para -1
dados_cptm[563, 5] <- -1

# linha 566, trocar para -1
dados_cptm[566, 5] <- -1

# linha 570, trocar para -1
dados_cptm[570, 5] <- -1

# linha 648, trocar para -1
dados_cptm[648, 5] <- -1

# linha 674, trocar para -1
dados_cptm[674, 5] <- -1

# linha 903, trocar para -1
dados_cptm[903, 5] <- -1

# linha 1077, trocar para -1
dados_cptm[1077, 5] <- -1

# linha 1078, trocar para -1
dados_cptm[1078, 5] <- -1

# linha 1266, trocar para 1
dados_cptm[1266, 5] <- 1

# linha 1562, trocar para 0
dados_cptm[1562, 5] <- 0

# linha 1783, trocar para 1
dados_cptm[1783, 5] <- 1

# linha 1784, trocar para 1
dados_cptm[1784, 5] <- 1

# linha 1785, trocar para 1
dados_cptm[1785, 5] <- 1

# linha 1786, trocar para 1
dados_cptm[1786, 5] <- 1

# linha 1971, trocar para 0
dados_cptm[1971, 5] <- 0

# linha 2030, trocar para 1
dados_cptm[2030, 5] <- 1

# linha 2042, trocar para 1
dados_cptm[2042, 5] <- 1

# linha 2188, trocar para 0
dados_cptm[2188, 5] <- 0

# linha 2231, trocar para -1
dados_cptm[2231, 5] <- -1

# linha 2257, trocar para 1
dados_cptm[2257, 5] <- 1

# linha 2297, trocar para 1
dados_cptm[2297, 5] <- 1

# linha 2309, trocar para 0
dados_cptm[2309, 5] <- 0

# linha 2404, trocar para 0
dados_cptm[2404, 5] <- 0

# linha 2412, trocar para -1
dados_cptm[2412, 5] <- -1

# linha 2438, trocar para 0
dados_cptm[2438, 5] <- 0

# linha 2440, trocar para -1
dados_cptm[2440, 5] <- -1

# linha 2514, trocar para 0
dados_cptm[2514, 5] <- 0

# linha 2559, trocar para 1
dados_cptm[2559, 5] <- 1

# linha 2618, trocar para 0
dados_cptm[2618, 5] <- 0

# linha 2624, trocar para 1
dados_cptm[2624, 5] <- 1

# linha 2625, trocar para 1
dados_cptm[2625, 5] <- 1

# linha 2626, trocar para 1
dados_cptm[2626, 5] <- 1

# linha 2764, trocar para 1
dados_cptm[2764, 5] <- 1

# linha 2892, trocar para 0
dados_cptm[2892, 5] <- 0

# linha 2893, trocar para 0
dados_cptm[2893, 5] <- 0

# linha 2919, trocar para 1
dados_cptm[2919, 5] <- 1

# linha 2920, trocar para -1
dados_cptm[2920, 5] <- -1

# linha 2922, trocar para -1
dados_cptm[2922, 5] <- -1

# linha 2926, trocar para -1
dados_cptm[2926, 5] <- -1

# linha 2939, trocar para 1
dados_cptm[2939, 5] <- 1

# linha 2971, trocar para -1
dados_cptm[2971, 5] <- -1

# linha 3041, trocar para 1
dados_cptm[3041, 5] <- 1

# linha 3258, trocar para 0
dados_cptm[3258, 5] <- 0

# linha 3301, trocar para 0
dados_cptm[3301, 5] <- 0

# linha 3312, trocar para 0
dados_cptm[3312, 5] <- 0

# linha 3369, trocar para 0
dados_cptm[3369, 5] <- 0

# linha 3385, trocar para 1
dados_cptm[3385, 5] <- 1

# linha 3511, trocar para 0
dados_cptm[3511, 5] <- 0

# linha 3529, trocar para 0
dados_cptm[3529, 5] <- 0

# linha 3638, trocar para 0
dados_cptm[3638, 5] <- 0

# linha 3695, trocar para 0
dados_cptm[3695, 5] <- 0

# linha 3703, trocar para 1
dados_cptm[3703, 5] <- 1

# linha 3728, trocar para 0
dados_cptm[3728, 5] <- 0

# linha 3755, trocar para 1
dados_cptm[3755, 5] <- 1

# linha 3756, trocar para 1
dados_cptm[3756, 5] <- 1

# linha 3757, trocar para 1
dados_cptm[3757, 5] <- 1

# linha 4032, trocar para 0
dados_cptm[4032, 5] <- 0

# linha 4093, trocar para -1
dados_cptm[4093, 5] <- -1

# linha 4098, trocar para -1
dados_cptm[4098, 5] <- -1

# linha 4215, trocar para -1
dados_cptm[4215, 5] <- -1

# linha 4242, trocar para -1
dados_cptm[4242, 5] <- -1

# linha 4256, trocar para 0
dados_cptm[4256, 5] <- 0

# linha 4258, trocar para -1
dados_cptm[4258, 5] <- -1

# linha 4281, trocar para -1
dados_cptm[4281, 5] <- -1

# linha 4282, trocar para -1
dados_cptm[4282, 5] <- -1

# linha 4284, trocar para -1
dados_cptm[4284, 5] <- -1

# linha 4286, trocar para -1
dados_cptm[4286, 5] <- -1

# linha 4289, trocar para -1
dados_cptm[4289, 5] <- -1

# linha 4291, trocar para -1
dados_cptm[4291, 5] <- -1

# linha 4292, trocar para -1
dados_cptm[4292, 5] <- -1

# linha 4295, trocar para -1
dados_cptm[4295, 5] <- -1

# linha 4301, trocar para -1
dados_cptm[4301, 5] <- -1

# linha 4303, trocar para -1
dados_cptm[4303, 5] <- -1

# linha 4340, trocar para -1
dados_cptm[4340, 5] <- -1

# linha 4346, trocar para -1
dados_cptm[4346, 5] <- -1

# linha 4350, trocar para -1
dados_cptm[4350, 5] <- -1

# linha 4361, trocar para 1
dados_cptm[4361, 5] <- -1

# linha 4362, trocar para -1
dados_cptm[4362, 5] <- -1

# linha 4382, trocar para -1
dados_cptm[4382, 5] <- -1

# linha 4401, trocar para -1
dados_cptm[4401, 5] <- -1

# linha 4402, trocar para -1
dados_cptm[4402, 5] <- -1

# linha 4404, trocar para -1
dados_cptm[4404, 5] <- -1

# linha 4405, trocar para -1
dados_cptm[4405, 5] <- -1

# linha 4406, trocar para -1
dados_cptm[4406, 5] <- -1

# linha 4408, trocar para -1
dados_cptm[4408, 5] <- -1

# linha 4413, trocar para -1
dados_cptm[4413, 5] <- -1

# linha 4427, trocar para -1
dados_cptm[4427, 5] <- -1

# linha 4547, trocar para 0
dados_cptm[4547, 5] <- 0

# linha 4560, trocar para 0
dados_cptm[4560, 5] <- 0

# linha 4647, trocar para 0
dados_cptm[4647, 5] <- 0

# linha 4961, trocar para 1
dados_cptm[4961, 5] <- 1

# linha 5021, trocar para 0
dados_cptm[5021, 5] <- 0

# linha 5023, trocar para 0
dados_cptm[5023, 5] <- 0

# linha 5055, trocar para -1
dados_cptm[5055, 5] <- -1

# linha 5057, trocar para -1
dados_cptm[5057, 5] <- -1

# linha 5109, trocar para 0
dados_cptm[5109, 5] <- 0

# linha 5123, trocar para -1
dados_cptm[5123, 5] <- -1

# linha 5132, trocar para 1
dados_cptm[5132, 5] <- 1

# linha 5133, trocar para 0
dados_cptm[5133, 5] <- 0

# linha 5135, trocar para 0
dados_cptm[5135, 5] <- 0

# linha 5258, trocar para 0
dados_cptm[5258, 5] <- 0

# linha 5324, trocar para -1
dados_cptm[5324, 5] <- -1

# linha 5339, trocar para 0
dados_cptm[5339, 5] <- 0

# linha 5432, trocar para 0
dados_cptm[5432, 5] <- 0

# linha 5498, trocar para -1
dados_cptm[5498, 5] <- -1

# linha 5506, trocar para 0
dados_cptm[5506, 5] <- 0

# linha 5530, trocar para 0
dados_cptm[5530, 5] <- 0

# linha 5543, trocar para 0
dados_cptm[5543, 5] <- 0

# linha 5566, trocar para -1
dados_cptm[5566, 5] <- -1

# linha 5582, trocar para -1
dados_cptm[5582, 5] <- -1

# linha 5584, trocar para -1
dados_cptm[5584, 5] <- -1

# linha 5652, trocar para -1
dados_cptm[5652, 5] <- -1

# linha 5818, trocar para 1
dados_cptm[5818, 5] <- 1

# linha 5824, trocar para -1
dados_cptm[5824, 5] <- -1

# linha 5858, trocar para 1
dados_cptm[5858, 5] <- 1

# linha 5914, trocar para -1
dados_cptm[5914, 5] <- -1

# linha 6083, trocar para 1
dados_cptm[6083, 5] <- 1

# linha 6165, trocar para 1
dados_cptm[6165, 5] <- 1

# linha 6166, trocar para 1
dados_cptm[6166, 5] <- 1

# linha 6167, trocar para 1
dados_cptm[6167, 5] <- 1

# linha 6168, trocar para 1
dados_cptm[6168, 5] <- 1

# linha 6172, trocar para 0
dados_cptm[6172, 5] <- 0

# linha 6270, trocar para -1
dados_cptm[6270, 5] <- -1

# linha 6325, trocar para 0
dados_cptm[6325, 5] <- 0

# linha 6333, trocar para -1
dados_cptm[6333, 5] <- -1

# linha 6416, trocar para 1
dados_cptm[6416, 5] <- 1

# linha 6418, trocar para 1
dados_cptm[6418, 5] <- 1

# linha 6508, trocar para -1
dados_cptm[6508, 5] <- -1

# linha 6509, trocar para -1
dados_cptm[6509, 5] <- -1

# linha 6779, trocar para 1
dados_cptm[6779, 5] <- 1

# linha 6780, trocar para 1
dados_cptm[6780, 5] <- 1

# linha 7041, trocar para 1
dados_cptm[7041, 5] <- 1

# linha 7047, trocar para -1
dados_cptm[7047, 5] <- -1

# linha 7050, trocar para -1
dados_cptm[7050, 5] <- -1

# linha 7051, trocar para 1
dados_cptm[7051, 5] <- 1

# linha 7176, trocar para -1
dados_cptm[7176, 5] <- -1

# linha 7177, trocar para -1
dados_cptm[7177, 5] <- -1

# linha 7251, trocar para 0
dados_cptm[7251, 5] <- 0

# linha 7262, trocar para -1
dados_cptm[7262, 5] <- -1

# linha 7273, trocar para 1
dados_cptm[7273, 5] <- 1

# linha 7290, trocar para -1
dados_cptm[7290, 5] <- -1

# linha 7311, trocar para 0
dados_cptm[7311, 5] <- 0

# linha 7368, trocar para 1
dados_cptm[7368, 5] <- 1

# linha 7413, trocar para -1
dados_cptm[7413, 5] <- -1

# linha 7505, trocar para 0
dados_cptm[7505, 5] <- 0

# linha 7679, trocar para 0
dados_cptm[7679, 5] <- 0

# linha 7680, trocar para 0
dados_cptm[7680, 5] <- 0

# linha 7681, trocar para 0
dados_cptm[7681, 5] <- 0

# linha 7701, trocar para 0
dados_cptm[7001, 5] <- 0

# linha 7703, trocar para 0
dados_cptm[7703, 5] <- 0

# linha 7704, trocar para 0
dados_cptm[7704, 5] <- 0

# linha 7705, trocar para 0
dados_cptm[7705, 5] <- 0

# linha 7812, trocar para -1
dados_cptm[7812, 5] <- -1

# linha 7957, trocar para -1
dados_cptm[7957, 5] <- -1

# linha 7958, trocar para -1
dados_cptm[7958, 5] <- -1

# linha 8052, trocar para -1
dados_cptm[8052, 5] <- -1

# linha 8053, trocar para -1
dados_cptm[8053, 5] <- -1

# linha 8056, trocar para -1
dados_cptm[8056, 5] <- -1

# linha 8072, trocar para -1
dados_cptm[8072, 5] <- -1

# linha 8084, trocar para -1
dados_cptm[8084, 5] <- -1

# linha 8088, trocar para -1
dados_cptm[8088, 5] <- -1

# linha 8098, trocar para 1
dados_cptm[8098, 5] <- 1

# linha 8099, trocar para 1
dados_cptm[8099, 5] <- 1

# linha 8100, trocar para 1
dados_cptm[8100, 5] <- 1

# linha 8101, trocar para 1
dados_cptm[8101, 5] <- 1

# linha 8102, trocar para 1
dados_cptm[8102, 5] <- 1

# linha 8103, trocar para 1
dados_cptm[8103, 5] <- 1

# linha 8104, trocar para 1
dados_cptm[8104, 5] <- 1

# linha 8105, trocar para 1
dados_cptm[8105, 5] <- 1

# linha 8106, trocar para 1
dados_cptm[8106, 5] <- 1

# linha 8107, trocar para 1
dados_cptm[8107, 5] <- 1

# linha 8108, trocar para 1
dados_cptm[8108, 5] <- 1

# linha 8109, trocar para 1
dados_cptm[8109, 5] <- 1

# linha 8149, trocar para 1
dados_cptm[8149, 5] <- -1

# linha 8150, trocar para 1
dados_cptm[8150, 5] <- 1

# linha 8151, trocar para 1
dados_cptm[8151, 5] <- 1

# linha 8152, trocar para 1
dados_cptm[8152, 5] <- 1

# linha 8153, trocar para 1
dados_cptm[8153, 5] <- 1

# linha 8154, trocar para 1
dados_cptm[8154, 5] <- 1

# linha 8155, trocar para 1
dados_cptm[8155, 5] <- 1

# linha 8165, trocar para 0
dados_cptm[8165, 5] <- 0

# linha 8166, trocar para 0
dados_cptm[8166, 5] <- 0

# linha 8199, trocar para -1
dados_cptm[8199, 5] <- -1

# linha 8219, trocar para -1
dados_cptm[8219, 5] <- -1

# linha 8221, trocar para -1
dados_cptm[8221, 5] <- -1

# linha 8254, trocar para 0
dados_cptm[8254, 5] <- 0

# linha 8381, trocar para -1
dados_cptm[8381, 5] <- -1

# linha 8383, trocar para -1
dados_cptm[8383, 5] <- -1

# linha 8391, trocar para -1
dados_cptm[8391, 5] <- -1

# linha 8446, trocar para 0
dados_cptm[8446, 5] <- 0

rm(dados_tweets, polaridade)

gc()