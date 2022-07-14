#install.packages("tidyverse")
library(tidyverse)

#install.packages(c("gapminder", "titanic"))
library(gapminder)
library(titanic)

?install.packages()
# c means combine
?c

# By default, R code goes to console
5+5
100 * 100
"My name is Sarah"

# We can save values into variables
value <- 5 + 5
name <- "Sarah"

print(value)

?source

# Using data
?starwars
View(starwars)
head(starwars)

# If we create a local variable, it becomes the default
starwars <- "Starwars is cool."
head(starwars)

# We can use "::" to say where we want the object to come from
head(dplyr::starwars)

# You can remove the local variable using rm()
starwarsFeeling <- starwars
starwarsFeeling
rm(starwars)

# To access a column in a dataset, use $
starwars$mass
starwars$mass * 2
class(starwars$mass) # get the data type of the column

# Find the mean of a column
mean(starwars$mass[!is.na(starwars$mass)])
mean(starwars$mass, na.rm = TRUE)

sum(starwars$height, na.rm = TRUE)

## plotting!
library(ggplot2)

mass_height_plot <- ggplot(data = starwars, mapping = aes(x = height, y = mass)) +
  geom_point()












