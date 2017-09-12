# source("/opt/research/twitter_project/src/init_twitter_project.R")

# setwd("/opt/research/twitter_project/")

if( !require(ProjectTemplate) ) {
  if( !require(devtools) ) {
    install.packages("devtools")
    library(devtools)
  }
  install_github("johnmyleswhite/ProjectTemplate")
  library(ProjectTemplate)
}

# Carregar projeto
load.project( translate.dcf("./config/twitter_project.dcf") )

# Setar parametros da configuracao
logger$logfile <- "./logs/twitter_project.log"
config$data_loading <- TRUE
config$munging <- FALSE

if(config$load_libraries) {
  list.files("./lib", pattern = "*.R$", full.names=TRUE) %>%
    sort() %>%
    sapply(., source, .GlobalEnv)
}

if(config$data_loading) {
  list.files("./data", pattern = ".R$", full.names=TRUE) %>%
    sapply(., source)
}

if(config$munging) {
  list.files("./munge", pattern = "*.R$", full.names=TRUE) %>%
    sort() %>%
    sapply(., source)
}

# nohup Rscript /opt/research/twitter_project/src/init_twitter_project.R &