library(tidyverse)
library(dplyr)
library(vroom)
library(tictoc)
library(data.table)

# col_types <- cols_only(
  # id = col_character(),
  # # type = col_character(),
  # # number = col_character(),
  # # country = col_character(),
  # date = col_date("%d-%m-%y"),
  # # abstract = col_character(),
  # # title = col_character(),
  # # kind = col_character(),
  # # num_claims = col_double(),
  # # filename = col_character(),
  # # withdrawn = col_double()
# )

# patent_tbl <- vroom(
  # file       = "~/Data science/DS_101/00_data/patent/patent.tsv", 
  # delim      = "\t", 
  # col_types  = col_types,
  # na         = c("", "NA", "NULL")
# )
col_types_PA <- cols_only(
  patent_id = col_character()
  # assignee_id = col_character(),
  # location_id = col_character()
  )
# patent_assignee_tbl <- vroom(
  # file       = "~/Data science/DS_101/00_data/patent/patent_assignee.tsv", 
  # delim      = "\t", 
  # col_types  = col_types_PA,
  # na         = c("", "NA", "NULL")
# )
# col_types_A <- cols_only(
  # id = col_character(),
  # # type = col_double(),
  # # name_first = col_character(),
  # # name_last = col_character(),
  # organization = col_character()
# )
assignee_tbl <- vroom(
  file       = "~/Data science/DS_101/00_data/patent/assignee.tsv", 
  delim      = "\t", 
  col_types  = col_types_A,
  na         = c("", "NA", "NULL")
)

tic()
assignee_tbl %>%
  filter(!is.na(organization)) %>%
  count(organization) %>%
  arrange(desc(n))
toc()


# class(patent_tbl)
# setDT(patent_tbl)
# class(patent_tbl)

# setDT(assignee_tbl)

# tic()
# combined_data <- merge(x = patent_tbl, y = assignee_tbl, 
                       # by    = "id", 
                       # all.x = TRUE, 
                       # all.y = FALSE)
# toc()