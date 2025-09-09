datasource <- function(..., dir = NULL, sep = NULL) {
    if (is.null(dir)) dir <- "datasource"
    if (is.null(sep)) sep <- .Platform$file.sep
    root <- fs::path_rel(
        Sys.getenv("QUARTO_DOCUMENT_PATH"),
        Sys.getenv("QUARTO_DOCUMENT_ROOT")
    )
    subdir <- fs::path_ext_remove(Sys.getenv("QUARTO_DOCUMENT_FILE"))
    file.path(root, dir, subdir, ..., fsep = sep)
}

#' Create a Markdown link to a project data repository
#'
#' Constructs a GitHub-style Markdown link pointing to a directory in the
#' repository, using the current Quarto `params` for URL and branch if not
#' provided.
#'
#' @param label Character. The link text to display. Default
#' `"Data Repository"`.
#' @param dir Character. Subdirectory relative to the document directory.
#'   Passed to [`datasource()`]. Default `datasource`.
#' @param url Character. Repository URL. If `NULL`, tries to read from
#' `params[['repo-url']]`.
#' @param branch Character. Repository branch. If `NULL`, tries to read from
#' `params[['repo-branch']]`.
#' @return Character string containing a Markdown link.
datasource_md_link <- function(label = "Data Repository",
                               dir = NULL, url = NULL, branch = NULL) {
    if (is.null(url) && (
        !exists("params", envir = globalenv(), mode = "list") ||
            is.null(url <- params[["repo-url"]]) # nolint
    )) {
        url <- "https://github.com/Yunuuuu/ggalign-gallery"
        # cli::cli_abort(c(
        #     "{.fn datasource_md_link} must be used in a knitr/Quarto code block with {.var params[['repo-url']]} available", # nolint
        #     i = "Try to specify {.arg url} manually"
        # ))
    }
    if (is.null(branch) && (
        !exists("params", envir = globalenv(), mode = "list") ||
            is.null(branch <- params[["repo-branch"]]) # nolint
    )) {
        branch <- "main"
        # cli::cli_abort(c(
        #     "{.fn datasource_md_link} must be used in a knitr/Quarto code block with {.var params[['repo-branch']]} available", # nolint
        #     i = "Try to specify {.arg branch} manually"
        # ))
    }
    sprintf(
        "[%s](%s)",
        label,
        file.path(
            url,
            "tree",
            branch,
            datasource(dir = dir, sep = "/"),
            fsep = "/"
        )
    )
}
