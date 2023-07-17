library(readxl)

Measurements <- read_excel("data/Poorboyetal_Hybridization_Measurements.xls")

names(Measurements)

## Getting help ####
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
