library(tidyverse)
library(rmarkdown)

file_path <- c("C:/Users/ethan.walker/Box/Ethan Walker UM/R/EldersAIR/")

analysis_data <- read_rds(paste0(file_path, "Output/elders_cleaned_dataset_by_visit.rds")) %>% 
  mutate(cohort = factor(cohort, levels = c("2015", "2016", "2017", "2018", "2019"))) %>% 
  filter(area == "NPT") %>% 
  filter(pm_mean_winter < 200)

#for (home in unique(analysis_data$home)){
 # home_data <- analysis_data[analysis_data$home == home,]
  #render("letter_results.rmd", output_file = paste0('report.', home, '.docx'))    
#}

for (adult_id_char in unique(analysis_data$adult_id_char)){
  adult_data <- analysis_data[analysis_data$adult_id_char == adult_id_char,]
  render("letter_results.rmd", output_file = paste0('report.', adult_id_char, '.docx'))    
}