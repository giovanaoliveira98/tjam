data <- list(
  `cdOrigemTema` = "",
  `cdSituacaoTema` = "",
  `deTemaCompleto` = "locação",
  `nuTema` = ""
)

r <- httr::POST(url = "https://consultasaj.tjam.jus.br/temas/consulta", body = data, encode = "form", httr::write_disk("data-raw/busca.html", overwrite = FALSE))