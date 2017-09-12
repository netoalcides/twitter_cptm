replaceSynonyms <- content_transformer( function(x, syn = NULL) { 
  Reduce(function(a,b) {
    gsub( paste0( "\\b(", paste(b$syns, collapse="|"), ")\\b" ), b$word, a ) }, syn, x )   
} )
