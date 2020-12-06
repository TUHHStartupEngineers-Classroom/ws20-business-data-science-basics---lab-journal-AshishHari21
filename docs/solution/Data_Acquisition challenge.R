library(tidyverse) # Main Package - Loads dplyr, purrr, etc.
library(rvest)     # HTML Hacking & Web Scraping
library(xopen)     # Quickly opening URLs
library(jsonlite)  # converts JSON files to R objects
library(glue)      # concatenate strings
library(stringi) 

url_home <- "https://www.radon-bikes.de/"
xopen(url_home) 

html_home <- read_html(url_home)
list_of_product_types <- html_home%>%
  html_nodes(css = ".megamenu__item > a")%>%
  html_text()


list_of_products_url <- html_home %>%
  html_nodes(".megamenu__item > a") %>%
  html_attr("href") %>%
  enframe(name = NULL, value = "url") %>%
  mutate(url = str_glue("https://www.radon-bikes.de{url}"))

# selecting first bike category url
bike_category_url <- list_of_products_url$url[1]

xopen(bike_category_url)

# Get the URLs for the bikes of the first category
html_bike_category  <- read_html(bike_category_url)
temp_url <- html_bike_category%>%
  html_node(".a-button--hollow-secondary")%>%
  html_attr("href")%>%
  enframe(name = NULL, value = "url") %>%
  mutate(url = str_glue("https://www.radon-bikes.de{url}"))

temp_url <- temp_url$url[1]
xopen(temp_url)

bike_category_grid_html <- read_html(temp_url)

list_of_product_names <- bike_category_grid_html%>%
  html_nodes(css=".m-bikegrid__info > a > div > h4")%>%
  html_text%>%
  stringr::str_replace_all(pattern = "\n","")%>%
  stringr::str_replace_all(pattern = "  ","")%>%
  enframe(name = NULL, value = "NAME")



list_of_product_prices <- bike_category_grid_html%>%
  html_nodes(css=".m-bikegrid__price--active")%>%
  html_text()%>%
  stringr::str_extract(pattern = "[0-9€]+")%>%
  stringr::str_replace(pattern = "€","")%>%
  as.numeric()%>%
  enframe(name = NULL, value = "PRICE")

list_of_product_prices = na.omit(list_of_product_prices)

bike_df <- data.frame(list_of_product_names,list_of_product_prices)
saveRDS(bike_df, "bike_data.rds")
head(bike_df,10)