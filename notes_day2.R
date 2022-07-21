## Intro to ggplot2
## JP Flores
## 07/14/2022

# Review ------------------------------------------------------------------

## installing and loading packages
# install.packages(c("tidyverse", "tidytuesdayR", "janitor"))
library(tidyverse)
library(tidytuesdayR)
library(janitor)

## operators / math
5 + 5
10 * 1000
sum <- 5 + 5
sum
product <- 10 * 1000
product
sum + product 

## help function 
?mean # function
?ggplot2 # library 
?ggplot
?ggplot2::ggplot # function within a specific library
?starwars # datasets

## Taking an initial glimpse at the data
starwars
head(starwars)
ncol(starwars) 
nrow(starwars)
dim(starwars)
names(starwars)
glimpse(starwars) # JP's preferred way

## Subsetting
starwars_names <- starwars$name # can use the `$` or brackets! `[]`


# ggplot2 basics ----------------------------------------------------------

## Obj: Learn basic ggplot2 syntax


## Load in the data
data <- tt_load("2019-09-24")
data

## take a glimpse... ba dum tss
data <- data$school_diversity
glimpse(data)

## Here, we use a filter function from the `dplyr` package to pull out only NC schools
nc_schools <- 
  data %>%  # this is called a pipe! 
  filter(ST == "NC")  # `ST` is a column name in the dataset

# this step is done in this order. note how clean_names() is before all the other functions.
nc_schools <- 
  nc_schools %>% 
  clean_names() %>% 
  select(-leaid) %>% 
  rename(school_district = lea_name, school_type = d_locale_txt)

View(nc_schools)  

nrow(nc_schools)
ncol(nc_schools)


## start the ggplot

## recall the different arguments within the ggplot function!
ggplot(data = nc_schools, mapping = aes(x = diverse)) +
  geom_bar()

## Alternatively, you can write code with pipes...
nc_schools %>% 
  ggplot(aes(x = diverse)) +
  geom_bar()


## Reordering from greatest to least
library(forcats)
nc_schools %>% 
  ggplot(aes(x = fct_infreq(diverse))) +
  geom_bar(fill = "dodgerblue") +
  labs(title = "How diverse are the school districts in NC?",
       x = "diversity",
       y = "# of school districts")


# different viz -----------------------------------------------------------

## Load in a different dataset using `readr`
salary_potential <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/salary_potential.csv')

salary_potential <- 
  salary_potential %>% 
  clean_names() 


## handy little combo of functions to arrange objects in descending order.
salary_potential %>% 
  arrange(desc(stem_percent))

## scatter plot with a trendline through it
salary_potential %>% 
  ggplot(aes(x = make_world_better_percent, y = stem_percent)) +
  geom_point(color = "yellow") +
  geom_smooth(color = "purple")


## layering matters!
salary_potential %>% 
  ggplot(aes(x = make_world_better_percent, y = stem_percent)) +
  geom_smooth() +
  geom_point()


# boxplots ----------------------------------------------------------------

combined_data <- readr::read_csv("https://raw.githubusercontent.com/5harad/openpolicing/master/results/data_for_figures/combined_data.csv")

policing <- combined_data
glimpse(policing)

## this will pull out all the distinct objects in a column
policing %>% 
  distinct(driver_race)

policing %>% 
  ggplot(aes(x = driver_race, y = arrest_rate)) +
  geom_boxplot() +
  xlab("Driver's Race") +
  ylab("Arrest Rate (%)") +
  ggtitle("Arrest rates (%) by driver's race")




