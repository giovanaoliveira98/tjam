#' Autenticar
#'
#' @param cpf cpf
#' @param senha senha
#'
#' @return NULL
#' @export
#'
autenticar_tjam <- function(cpf = NULL, senha = NULL){
  
  url<-"https://consultasaj.tjam.jus.br//sajcas/login?service=https%3A%2F%2Fconsultasaj.tjam.jus.br%2Fesaj%2Fj_spring_cas_security_check"
  
  conteudo<-httr::GET(url) %>%
    httr::content()
  
  
  execucao<-xml2::xml_find_first(conteudo,"//*[@name='execution']") %>%
    xml2::xml_attr("value")
  
  
  body <-
    list(
      username = cpf,
      password = senha,
      lt = "",
      execution = execucao,
      `_eventId` = "submit",
      pbEntrar= "Entrar",
      signature= "",
      certificadoSelecionado = "",
      certificado = ""
    )
  
  url2<-"https://consultasaj.tjam.jus.br/esaj/j_spring_cas_security_check"
  
  r <- httr::POST(url2,body=body,encode="form")
  return(r)
}