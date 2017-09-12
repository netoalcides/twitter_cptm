funcao_tm_cptm_twitter <- function( texto ){
  
  # Cria lista de sinonimos
  
  synonyms <- list(
    list( word = "aff", syns = c("afff", "affff", "afffff", "affffff", "affffff") ),
    list( word = "bom", syns = c("bommm", "bommmmmm", "boooommm") ),
    list( word = "hahaha", syns = c("ahahahah", "ahahh", "hah", "hahah", "hahahah", "hahahahahah") ),
    list( word = "deus", syns = c("deussss", "deuuuuus") ),
    list( word = "descarrilhamento", syns = c("descarrilamen", "descarrilamentodetr", "descarrilamentoeit") ),
    list( word = "todo", syns = c("tood", "toood", "toood", "tooooooood") ),
    list( word = "whatsapp", syns = c("whasapp", "what", "whatapp", "whatssapp", "zap") )
  )
  
  # Trata o texto
  
  texto %<>%
    gsub("/", ",", ., ignore.case = T) %>%
    gsub('[[:cntrl:]]', "", .) %>% 
    gsub("http\\S+\\s*", "", .) %>% 
    gsub("\\d+", "", .) %>% 
    gsub("[^[:graph:]]", " ", .) %>% 
    gsub("cptm", "", ., ignore.case = T) %>% 
    gsub("AprovaConcursos", "Aprova,Concursos", ., ignore.case = T) %>%
    gsub("ApuracaoSP", "Apuracao,SP", ., ignore.case = T) %>% 
    gsub("AquiEuConfio", "Aqui,Eu,Confio", ., ignore.case = T) %>% 
    gsub("boanoite", "boa,noite", ., ignore.case = T) %>% 
    gsub("ComandoSP", "Comando,SP", ., ignore.case = T) %>% 
    gsub("comecouocarnaval", "comecou,o,carnaval", ., ignore.case = T) %>%
    gsub("DicaCultural", "Dica,Cultural", ., ignore.case = T) %>%
    gsub("melhorzinhaLinha", "melhorzinha,Linha", ., ignore.case = T) %>%
    gsub("oficialAlguma", "oficial,Alguma", ., ignore.case = T) %>%
    gsub("oficialSr", "oficial,Sr", ., ignore.case = T) %>%
    gsub("OperaçãoPaese", "Operação,Paese", ., ignore.case = T) %>%
    gsub("operacionaisIma", "operacionais,Ima", ., ignore.case = T) %>%
    gsub("ProtejamAsMulheresNosVagoes", "Protejam,As,Mulheres,Nos,Vagoes", ., ignore.case = T) %>%
    gsub("QualidadeDeVidaPaulista", "Qualidade,De,Vida,Paulista", ., ignore.case = T) %>%
    gsub("TodoCarnavalTemSeuFim", "Todo,Carnaval,Tem,Seu,Fim", ., ignore.case = T) %>%
    gsub("UsuarioCPTM", "Usuario,CPTM", ., ignore.case = T) %>%
    gsub("UsuariosMetroSP", "Usuarios,Metro,SP", ., ignore.case = T) %>%
    gsub("UsuariosTrensSP", "Usuarios,Trens,SP", ., ignore.case = T) %>%
    gsub(",", " ", ., fixed = TRUE) %>% 
    gsub("[[:punct:]]", " ", .) %>% 
    gsub("\n", " ", ., ignore.case = T)
  
  # Faz o text minning
  
  texto_tratado <- VCorpus( VectorSource( texto ) )
  
  texto_tratado %<>% 
    tm_map( removeNumbers ) %>% 
    tm_map( removePunctuation ) %>% 
    tm_map( content_transformer(tolower) ) %>% 
    tm_map( stripWhitespace ) %>% 
    tm_map( removeWords, c( stopwords("portuguese"), 
                            "linha", "transitosp", "sptrem", "metrosp", 
                            "usuariosmetrosp", "metrospoficial" ) ) %>% 
    tm_map( stemDocument, language = "portuguese" ) %>% 
    tm_map( replaceSynonyms, synonyms ) %>% 
    tm_map( PlainTextDocument ) %>% 
    DocumentTermMatrix() %>% 
    as.matrix() %>% 
    data.frame()
  
  return( texto_tratado )
}