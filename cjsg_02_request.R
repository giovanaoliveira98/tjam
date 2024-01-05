#Request - TJAM

r <- httr::POST(url = "https://consultasaj.tjam.jus.br/cjsg/resultadoCompleta.do;jsessionid=4E57929D379493F4A4DEAC80DCF9EEE3.cjsg3", body = data, encode = "form", httr::write_disk("data-raw/busca.html", overwrite = TRUE))