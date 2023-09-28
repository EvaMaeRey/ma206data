############# prepare isi files, convert to .rda and save for package ####

# clean a bit and convert to .rda files, send to package data folder

isi_file_paths <- fs::dir_ls("data-raw/isi_txt_data/")
length(isi_file_paths)

dataset_name <- isi_file_paths %>%
  str_remove("data-raw/isi_txt_data/") %>%
  str_remove(".txt$")

## a list that populates with datasets
isi_datasets <- list()


for (i in 1:length(isi_file_paths)){


  # pause so you don't hit isi website too often
  Sys.sleep(time = .2)

  # attempt to harvest data
  tryCatch(

    isi_file_paths[i] %>%
      readr::read_delim(delim = "\t") %>%
      janitor::clean_names() ->
      isi_datasets[[i]]

  )

  assign(x = dataset_name[i], value = isi_datasets[[i]])

  save(list = dataset_name[i],
       file = paste0("data/", dataset_name[i], ".rda"))

}


