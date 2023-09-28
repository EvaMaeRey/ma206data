#### Prepare course data datasets for package ############

course_director_datasets <- list()


for (i in 1:length(course_director_csvs)){


  # attempt to read in data
  tryCatch(

    course_director_csvs[i] %>%
      readr::read_csv() %>%
      janitor::clean_names() ->
      course_director_datasets[[i]]

  )

  # assignment without assignment operator
  assign(x = dataset_name[i], value = course_director_datasets[[i]])

  #
  save(list = dataset_name[i],
       file = paste0("data/", "cd_", dataset_name[i], ".rda"))

}
