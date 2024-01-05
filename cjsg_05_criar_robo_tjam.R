tjam_baixar_cjsg <- function(
    livre = "",
    aspas = FALSE,
    tipo = "A",
    diretorio = "."){
  
  #Pesquisa literal
  if (aspas == TRUE) livre <- deparse(livre)
  
  #Corpo da requisição
  body <- list(
    `conversationId` = "",
    `dados.buscaInteiroTeor` = livre,
    `dados.pesquisarComSinonimos` = "S",
    `dados.pesquisarComSinonimos` = "S",
    `dados.buscaEmenta` = "",
    `dados.nuProcOrigem` = "",
    `dados.nuRegistro` = "",
    `agenteSelectedEntitiesList` = "",
    `contadoragente` = "0",
    `contadorMaioragente` = "0",
    `codigoCr` = "",
    `codigoTr` = "",
    `nmAgente` = "",
    `juizProlatorSelectedEntitiesList` = "",
    `contadorjuizProlator` = "0",
    `contadorMaiorjuizProlator` = "0",
    `codigoJuizCr` = "",
    `codigoJuizTr` = "",
    `nmJuiz` = "",
    `classesTreeSelection.values` = "",
    `classesTreeSelection.text` = "",
    `assuntosTreeSelection.values` = "",
    `assuntosTreeSelection.text` = "",
    `secoesTreeSelection.values` = "",
    `secoesTreeSelection.text` = "",
    `dados.dtJulgamentoInicio` = "",
    `dados.dtJulgamentoFim` = "",
    `dados.dtPublicacaoInicio` = "",
    `dados.dtPublicacaoFim` = "",
    `dados.origensSelecionadas` = "T",
    `dados.origensSelecionadas` = "R",
    `tipoDecisaoSelecionados` = "A",
    `tipoDecisaoSelecionados` = "H",
    `tipoDecisaoSelecionados` = "D",
    `dados.ordenarPor` = "dtPublicacao"
  )
  
  #Requisição
  r <- httr::POST(url = "https://consultasaj.tjam.jus.br/cjsg/resultadoCompleta.do;jsessionid=4E57929D379493F4A4DEAC80DCF9EEE3.cjsg3", body = body, encode = "form")
  
  #Calcula número de páginas da requisição
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
  
  #Adiciona barra de progresso por páginas
  pb <- progress::progress_bar$new(total = pags)
  
  #Salva em um arquivo com ajuda da função pré-estabelecida escrever_arquivo
  if (tipo == "A") {
    
    purrr::walk(percurso, purrr::possibly(~{
      
      pb$tick()
      
      arquivo <- escrever_arquivo(pagina = .x,
                                  diretorio = diretorio,
                                  livre = livre)
      
      Sys.sleep(1)
      
      httr::GET(
        paste0(
          "https://consultasaj.tjam.jus.br/cjsg/trocaDePagina.do?tipoDeDecisao=A&pagina=",
          .x,
          "&conversationId="),
        httr::set_cookies(unlist(r$cookies)),
        httr::accept("text/html; charset=latin1;"),
        httr::write_disk(arquivo, overwrite = TRUE)
      )
      
    }, NULL))
  } else {
    
    purrr::walk(percurso, purrr::possibly(~{
      
      pb$tick()
      
      arquivo <- escrever_arquivo(pagina = .x,
                                  diretorio = diretorio,
                                  livre = livre)
      
      Sys.sleep(1)
      
      httr::GET(
        paste0(
          "https://consultasaj.tjam.jus.br/cjsg/trocaDePagina.do?tipoDeDecisao=D&pagina=",
          .x,
          "&conversationId="),
        httr::set_cookies(unlist(r$cookies)),
        httr::accept("text/html; charset=latin1;"),
        httr::write_disk(arquivo, overwrite = TRUE)
      )
    }, NULL))
  }
  
}
