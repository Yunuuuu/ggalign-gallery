datasource_md_link <- function(dir = NULL, label = "Data Repository") {
    sprintf(
        "[%s](https://github.com/Yunuuuu/ggalign-gallery/tree/main/rawdata/%s)",
        label, dir %||% datasource_dir()
    )
}

datasource <- function(..., dir = NULL) {
    fs::path("rawdata", dir %||% datasource_dir(), ...)
}

datasource_dir <- function() {
    root <- Sys.getenv("QUARTO_PROJECT_ROOT")
    path <- paste(
        Sys.getenv("QUARTO_DOCUMENT_PATH"),
        fs::path_ext_remove(Sys.getenv("QUARTO_DOCUMENT_FILE")),
        sep = "/"
    )
    fs::path_rel(path, root)
}
