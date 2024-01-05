escrever_arquivo <- function(pagina,
                             diretorio,
                             livre){
  
  #Deixar um vetor de termos limpo para uso no arquivo
  termo <- janitor::make_clean_names(livre)
  
  #Adicionar hora para não escrever por cima de arquivos
  hora <- stringr::str_replace_all(Sys.time(), "\\D", "_")
  
  #Criar o caminho do arquivo
  arquivo <- file.path(diretorio,paste0(termo,"_", hora,"_pagina_",pagina,".html"))
}

arquivo <- escrever_arquivo(pagina = "2",
                            diretorio = "data-raw",
                            livre = "locação temporada")