## code to prepare `DATASET` dataset goes here
#
# AP.BottledWater = readr::read_csv("data-raw/AP.BottledWater.csv")
#
# usethis::use_data(AP.BottledWater, overwrite = TRUE)

####################################################################


library(tidyverse)
# look at text of html file
readLines("http://www.isi-stats.com/isi2nd/data.html") %>%
  # each line is content in data frame
  tibble(text = .) %>%
  filter(str_detect(text, "\\.txt")) %>%
  mutate(href =
           str_extract(text, "http.+\\.txt"),
         .before = 1) %>%
  mutate(dataset_name = str_extract(href, "data.+"),
         .before = 1) %>%
  mutate(dataset_name =
           str_remove(dataset_name, "data."),
         .before = 1) %>%
  mutate(dataset_name =
           str_remove(dataset_name, "\\.txt")) %>%
  mutate(dataset_name =
           str_replace(dataset_name, "\\/", "_")) ->
  href_df

href_df$dataset_name


## Download raw data .txt files in isi folder in data-raw
isi_dir <- "data-raw/isi_txt_data/"
dir.create(isi_dir)

for (i in 1:length(href_df$href)){

  Sys.sleep(time = 1)
  try(
  download.file(url = href_df$href[i],
                destfile = paste0(isi_dir, href_df$dataset_name[i], ".txt"))
  )
}
