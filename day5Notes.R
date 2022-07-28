# load required packages ####
library(tidyverse)
library(gapminder)

# un-tidy data ####
table1
table4a
table4b

## tidy data satisfies 3 criteria:
# 1. all rows are unique observations
# 2. all columns are unique variables
# 3. all cells are unique values

## use pivot_longer if the columns are not  unique variables
tidy_table4a <- pivot_longer(data = table4a, 
             cols = c(`1999`,`2000`), 
             names_to = "year", 
             values_to = "cases")

tidy_table4a

tidy_table4b <- pivot_longer(data = table4b,
                             cols = c(`1999`,`2000`),
                             names_to = "year",
                             values_to = "population")

tidy_table4b

## join datasets together
left_join(tidy_table4a, tidy_table4b)

?join # learn about the different joins

## use pivot_wider if the rows are not unique observations
table2

pivot_wider(data = table2,
            names_from = type,
            values_from = count)

## Use separate if the cells are not unique values
table3

# auto-detect separator
# use convert = T to convert to numeric types
separate(data = table3, col = rate, into = c("cases", "population"), convert = TRUE) %>%
  mutate(rate = cases/population)

# designate separator
separate(data = table3, col = rate, into = c("cases", "population"), sep = "/") %>%
  select(-population) # removing population

# functions ####
## Use functions when you want to repeat some formula or analysis
## with various input(s) and one output
functionName <- function(x) {
  
  return(x)
  
}

functionName("hello")
functionName(5)

square_plus1 <- function(x) {
  
  answer <- x^2 +1
  return(answer)
  
}

square_plus1(5)

## Create a function to convert F to K (K = 5/9 * (F-32) + 273.15)
f_to_k <- function(temp) {
  
  kelvin = 5/9 * (temp-32) + 273.15
  return(kelvin)
  
}

f_to_k(90)


# for loops ####
## Use for loops to repeat the same function over the elements of a vector
vector <- c(1,2,3)

for(value in vector) {
  
  print(value)
  
}

for(year in c(2000, 2005, 2015, 2020)){
  
  print(paste0("The year is ", year, ". This is my favorite year!"))
  
}

day = 26
month = 07
year = 2022

paste0("Today is ", paste(month, day, year, sep = "/"))
#paste0 is a shorthand function for paste(sep="")

## save a variable using a for loop
output <- c()

for(year in c(2000, 2005, 2010, 2015, 2020)){
  
  output <- c(output, paste("The year is", year))
  
}

output

# using length and indicies instead of elements in a vector
output <- vector("numeric")
years <- c(2000, 2005, 2010, 2015, 2020)
for(i in 1:length(years)){
  
  output[i] <- years[i] + 100
  
}

output

# for loop with a dataset
glimpse(gapminder)

# Use a for loop to print all the countries in the Americas from gapminder
# Tips: use filter() to extract American countries and you may need to look up
# how to avoid duplicates
# Also, look into as.character() to convert countries from a factor

# we will finish this on Thursday! 
# Ooooh, a cliffhanger!!





