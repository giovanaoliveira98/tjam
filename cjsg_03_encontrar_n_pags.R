#Encontrar número de páginas - Acórdãos - TJAM

#Encontrar número máximo de páginas
# max_pag <- a %>%
#   httr::content() %>%
#   xml2::xml_find_all(xpath = "//*[@id='totalResultadoAba-A']|//*[@id='totalResultadoAba-D']") %>%
#   xml2::xml_attrs() %>%
#   .[[1]] %>%
#   .[3] %>%
#   as.numeric() %>%
#   `/`(20) %>%
#   ceiling()
# paginas <- 1:max_pag
# pb <- progress::progress_bar$new(total = max_pag)



pags <- r %>% 
  httr::content() %>% 
  xml2::xml_find_all(xpath = "//*[@id='paginacaoSuperior-A']") %>% 
  xml2::xml_text() %>% 
  stringr::str_extract("(?<=de )\\d+") %>% 
  as.integer() %>% 
  as.numeric() %>% 
  `/`(10) %>% 
  ceiling()

percurso <- 1:pags