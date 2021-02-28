## load data compressed in .zip format and unpack it
## zip_url - data url
## zip_delete - if TRUE delete .zip archive after
load_unpack_zip <- function(zip_url, zip_delete = TRUE) {
    # load data
    file_path <- file.path(".", "data.zip")
    download.file(zip_url, file_path)
    
    # unpack data
    exdir <- file.path(".", "data", "raw")
    unzip(file_path, exdir = exdir)
    
    # delete zip data if necessary
    if (zip_delete & file.exists(file_path)) {
        file.remove(file_path)
    }
}
