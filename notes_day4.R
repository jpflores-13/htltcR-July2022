## ggplot2 exercise & importing with readr
## JP
## 07-21-2022

# packages ----------------------------------------------------------------
install.packages(c("tidyverse", "tidytuesdayR","gapminder", "here", "janitor"))
library(tidyverse) # tidyverse contains ggplot2, dplyr, etc. 
library(gapminder)

# data cleaning -----------------------------------------------------------
finalExampleData <- gapminder %>% 
  filter(year %in% c(1952, 2007))

# JP ----------------------------------------------------------------------
finalExampleData <- 
  gapminder %>% 
  filter(year %in% c(1952,2007))

finalExampleData <- 
  gapminder %>% 
  filter(year == 1952 | year == 2007)


# visualization (live coding) -----------------------------------------------------------
glimpse(finalExampleData)

examplePlot <- 
  finalExampleData %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop, color = continent), alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "black", lty = "dashed") +
  facet_wrap(~ year) +
  scale_x_log10() +
  labs(x = "GDP per capita",
       y = "Life Expectancy",
       color = "Continent",
       size = "Population",
       title = "Life Expectancy Increases independently of GDP per cap") +
  theme_classic()

## let's save our plot as a pdf
ggsave(filename = "plots/examplePlot.pdf", plot = examplePlot)

# answer key --------------------------------------------------------------
## data cleaning step
finalExampleData <- dplyr::filter(gapminder, year %in% c(1952, 2007))

## ggplot
ggplot(finalExampleData, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point(aes(size = pop, color = continent), alpha = 0.5) + 
  geom_smooth(method = "lm", se = FALSE, color = "black", lty = 2) +
  facet_wrap(~year) + 
  scale_x_log10() + 
  ylab("Life Expectancy") + 
  xlab("GDP per capita") + 
  guides(color = guide_legend("Continent"), 
         size = guide_legend("Population")) +
  ggtitle("Life Expectancy Increases independently of GDP per cap") +
  theme(strip.text.x = element_text(size = 14),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14))

# readr -------------------------------------------------------------------
library(here)
library(tidytuesdayR)
library(janitor)

## take a quick look at the data we're going to be looking at
tuesdata <- tt_load('2020-01-21') 
tuesdata

## let's do a quick example of reading it in in its .csv format
spotify_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')

## let's write this as a .csv file in our current working directory
getwd()
setwd()
here()
here(write.csv(spotify_songs, file = "data/spotify_songs.csv"))

## let's remove spotify_songs so we can see if our write.csv function worked
rm(spotify_songs)

## let's read in the .csv and clean it up a bit
spotify_songs <- read.csv("data/spotify_songs.csv") %>% 
  clean_names()

# quick review exercises --------------------------------------------------
## who's your favorite artist? how popular is their music?
glimpse(spotify_songs)
sheerio <- 
  spotify_songs %>% 
  select(track_artist, track_name, track_popularity) %>% 
  filter(track_artist == "Ed Sheeran" & track_popularity >=80) %>% 
  arrange(desc(track_popularity)) %>% 
  distinct()

## write it as a .csv
here(write_csv(sheerio, file = "data/sheeran_songs.csv"))

## read it as a .csv
sheeran_songs <- read.csv("data/sheeran_songs.csv")

## how can I view my dataset?

## how many songs are in this dataset?

## what is the most "danceable" song in this playlist?

## can you find me the top 5 most popular Ed Sheeran song in this playlist?

# how JP would've done it: ------------------------------------------------
spotify_songs %>% 
  select(track_artist, track_popularity, track_name) %>% 
  filter(track_artist == "Ed Sheeran" & track_popularity > 0) %>% 
  arrange(desc(track_popularity)) %>% 
  distinct() %>% 
  view()













## any other questions we're curious about?

## can you graph these songs 




