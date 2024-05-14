# Install a package to make it available to load ####
install.packages("tidyverse")
install.packages("here")

# Load a package to make it available during your session ####
library(readxl)

# Read in dataset using read_excel() function
Measurements <- read_excel("data/Poorboyetal_Hybridization_Measurements.xls")

# Alternative format that uses the read_excel() function from the readxl package without loading the package
# This method is relevant when you need to be explicit about which package you want to use because sometimes
# different packages will have functions that have the same name but do things differently 
Measurements <- readxl::read_excel("data/Poorboyetal_Hybridization_Measurements.xls")

# Reviewing objects in the console ####
names(Measurements)
head(Measurements) # Erika will show you an alternative from the tidyverse, str()
class(Measurements) 

## Getting help with the plot function ####
?plot
help(plot)

# plotting #####
#### Using the column names from a dataframe ####
plot(Measurements$LogMass,
     Measurements$Incisor_BiteForce)

#### Using arguments to be specific about which variable to which axis ####
plot(y=Measurements$LogMass,
     x=Measurements$Incisor_BiteForce)

#### Plotting two variables as a formula ####
plot(Incisor_BiteForce~LogMass, data=Measurements)
