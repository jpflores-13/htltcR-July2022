# Review ####
## Adding libraries
library(ggplot2)
library(dplyr)
library(forcats)

#install.packages(gapminder) #un-comment this if you need to install the gapminder library
library(gapminder)

## glimpse the dataset for a preview and some info about the dataset
glimpse(gapminder) 
?gapminder

## filter only entries where the country is the United States
usa <- filter(gapminder, country == "United States")
head(usa)

## plot year vs life expectancy for US with a red line connecting points
ggplot(usa, aes(x = year, y = lifeExp)) +
  geom_line(color = "red") +
  geom_point() 

## color by a column by using aes(color = column_name)
usa %>% ggplot(aes(x = year, y = lifeExp)) +
  geom_point(aes(color = as.factor(year)))

## Don't put color names inside of aes()
ggplot(usa, aes(x = year, y = lifeExp)) +
  geom_line() +
  geom_point(aes(color = "blue")) # this doesn't work as expected

## You can also set size, shape, and other features to change based on other column values
## And you can add labels for axes and legends (by using the feature affected, i.e. color)
ggplot(usa, aes(x = year, y = lifeExp)) +
  geom_line() +
  geom_point(aes(size = pop, color = as.factor(year))) +
  labs(y = "Life Expecency",
       title = "USA life expectancy and population by year",
       size = "population",
       color = "year")

# Using dplyr ####
## Filter allows us to remove rows with values that do not meet our criteria
## We can do multiple comparisons using | (or) and & (and)
americas <- dplyr::filter(gapminder, continent == "Americas" | (pop > 1e7 & pop < 50e6))
americas <- dplyr::filter(gapminder, 
                          continent == "Americas", 
                          between(pop, 10e6, 20e6), # between(column, left, right) is a shortcut for column > left & column > right
                          year != 2002)

## We can use arrange() to resort rows in a dataset
americas <- arrange(americas, year)
americas <- arrange(americas, desc(year), pop)
View(americas)

## column %in% vector checks if the column value is present in the given vector 
favoriteCountries <- c("Philippines", "Chile", "United States")
View(dplyr::filter(gapminder, country %in% favoriteCountries))

## grepl(pattern, column) does the opposite-- checks if the pattern is present in the column value
View(dplyr::filter(gapminder, grepl("United", country)))


### column manipulation
## select allows us to choose columns to keep or remove
(country_gdp <- select(gapminder, -year, -pop, -lifeExp)) # - removes columns
select(gapminder, -c(year, pop))

head(starwars)

## We can use helper functions like contains(), ends_with(), starts_with()
select(starwars, -contains("color"))
select(starwars, -ends_with("color"))

select(starwars, height, mass)
select(starwars, starts_with("s"), contains("color"))

## everything() is a shortcut to get all column names
select(starwars, films, homeworld, eye_color, everything()) #reorder

## If a column is repeated, it is only included once
select(starwars, mass, mass, mass)

## adding columns using mutate()
starwars %>%
  mutate(height_m = height/100,
         height_mass = height_m*mass) %>% # you can use a new column immediately after creating it
  select(height, height_m, height_mass, everything())


mutate(starwars, height_m = height/100)


## summarize & group_by

summarize(starwars, mean_mass = mean(mass, na.rm = T))

## we can create new columns based on a category by combining summarize() and group_by()
char_mass <- starwars %>% 
  group_by(species) %>%
  summarize(mean_mass = mean(mass, na.rm = T),
            count = n()) %>%
  arrange(mean_mass)

View(char_mass)

## We can group by multiple categories at once
populations <- gapminder %>% 
  group_by(continent, year) %>%
  summarize(mean_pop = mean(pop))

View(populations)














