library(dplyr)
library(tidyr)
library(readxl)
library(lubridate)

# Update this file to load all Logtag files and get into the same format
# Then, transfer this file to the CPHR server:

###### Command line code for sftp file transfer ######

# Connect to VPN
# Open command prompt
# sftp ethan.walker@cphrstor1.health.umt.edu # open sftp connection
# pwd # print working directory
# cd /home/ethan.walker/eldersair/logtag # change directory - specify filepath
# put C:/R/EldersAIR/logtag_cleaning.r # transfer specific file
# put -r C:/R/EldersAIR/Logtag # use this to transfer a directory
# ls # list files in a directory

# Once the file is updated, connect to X2Go client:
# Password saved in email and Microsoft To Do reminders
# Authenticate with Duo Mobile
# Once connected, open the Geany application
# Open the logtag_cleaning.r file and run code through the Terminal
# Enter "R" into the Terminal to run R code


###### NPT Files #######

#### File type: header_1col_date_m.d.y_time_ampm_c

list_files <- list.files("/home/ethan.walker/eldersair/logtag/NPT/header_1col_date_m.d.y_time_ampm_c")
list_files

# Set working directory and load files in list; extract file name and add as column
## run next lines together
setwd("/home/ethan.walker/eldersair/logtag/NPT/header_1col_date_m.d.y_time_ampm_c")
initial_data <- tibble(file_name = list_files) %>%
  mutate(save_data = lapply(file_name, read_excel, skip = 1,
                            col_names = c("data"),
                            col_types = c("text"))) %>%
  unnest(save_data) %>% 
  separate(data, into = c("datetime", "c_f", "temp_c"), sep = ",") %>% 
  mutate(datetime = mdy_hms(datetime),
         temp_c = as.numeric(temp_c))


