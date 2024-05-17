# Install a package to make it available to load ####
install.packages("tidyverse")
install.packages("here")

# Load a package to make it available during your session ####
library(readxl)
library(here)

# Read in dataset using read_excel() function
Measurements <- read_excel("data/EuropeanRedSquirrel.xlsx")
Measurements <- read_excel(here("data", "EuropeanRedSquirrel.xlsx"))


# Alternative format that uses the read_excel() function from the readxl package without loading the package
# This method is relevant when you need to be explicit about which package you want to use because sometimes
# different packages will have functions that have the same name but do things differently
Measurements <- readxl::read_excel("data/EuropeanRedSquirrel.xlsx")

# Reviewing objects in the console ####
names(Measurements)
head(Measurements) # Erika will show you an alternative from the tidyverse, str()
class(Measurements)

## Getting help with the plot function ####
?plot
help(plot)

# plotting #####
#### Using the column names from the tibble ####
plot(Measurements$`Skull width`,
     Measurements$`Skull height`)

#### Using arguments to be specific about which variable to which axis ####
plot(y=Measurements$`Skull width`,
     x=Measurements$`Skull height`)

#### Plotting two variables as a formula ####
plot(`Skull width`~`Skull height`, data=Measurements)
