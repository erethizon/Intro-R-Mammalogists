library(tidyverse)
library(ggplot2)
library(ggpubr)

#Set working directory and read in data -----

setwd("~/Documents/GitHub/Intro-R-Mammalogists/Data")
data <- read_csv("Poorboyetal_Hybridization_Measurements.csv")


#What's in a graph? ------
#1.The data used to create the plot
#2.The axes of the plot
#3.The geometric shapes used to create the data
#4.The labels or annotations that will help a reader understand the plot

#Breaking down a plot into layers is important because it is how the ggplot2 package understands and builds a plot

#Let's look at the data we're working with
summary(data)

#Let's have a quick look at the data to see what it looks like for one particular species

#Get the names of the different species we have to work with

table(data$Category)

#Filter the data to what we need
red.data <- data %>%
  filter(Category == "Red")


#Let's start by making a histogram- since this is an important basic data exploration tool

#Step 1 - Add the data -------
#We can pipe the data into a ggplot() function to begin creating a graph. We use the ggplot() function to indicate that we want to create a plot.

red.data %>%
  ggplot()

#This code produces a blank graph. But it now “knows” to use the "red.data", even though we don't see it plotted yet

#Step 2 - Build the axes ------
#Now that we've prepared the data we can start building a visualization. The next layer we need to build are the axes

#To specify the axes, we use the aes() function (short for “aesthetic”), this tells ggplot what columns we want to use for different parts of the plot.

red.data %>%
  ggplot(aes(x = Mass))

#But there's still nothing on the plot. Now we need to tell ggplot() what kind of shapes to use to visualize the data we're interested in

#Step 3 - Specify the geom -----
#Here we need to specify the type of graph since it’s really the shapes that we see that tell us most of the information. The shape we use will depend on the type of data and relationship we are trying to visualize.

#Here we are interested in starting by exploring the distribution of different masses

#To create a histogram with ggplot(), we use the geom_histogram() function. All functions used to create the shape that we want to use to visualize the data start with geom_


red.data %>%
  ggplot(aes(x = Mass)) +
  geom_histogram()

#Notice how after the use of the ggplot() function, we start to add more layers to it using a + sign.

#Step 4 - Add the title and axis labels ------
#In order to change the axis labels for a plot, we can use the labs() function and add it as a layer onto the plot

red.data %>% #data layer
  ggplot(aes(x = Mass)) + #axes layer
  geom_histogram() + #geom layer
  labs(             #annotations layer
  title = "Histogram of red squirrel body mass",
  x = "Body mass (grams)",
  y = "Frequency"
)


#Step 5 - Prettify the figure -----
#There are lots of things we can do to alter the look of this figure and make it more visually appealing and/or easier to read. Here are just a few ideas below:


##Adjust the scale of the axes -----

summary(red.data$Mass)

red.data %>%
  ggplot(aes(x = Mass)) +
  geom_histogram() +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20))

#OR

red.data %>%
  ggplot(aes(x = Mass)) +
  geom_histogram() +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(n.breaks = 10)


##Change the bin width ------
#this allows you to specify the number of bins to use in the histogram


red.data %>%
  ggplot(aes(x = Mass)) +
  geom_histogram(bins = 10) +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20))

#OR

red.data %>%
  ggplot(aes(x = Mass)) +
  geom_histogram(binwidth = 10) +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20))



##Change the colour and fill of the histogram -----


red.data %>%
  ggplot(aes(x = Mass)) +
  geom_histogram(binwidth = 10, color = "dark blue", fill = "grey") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20))


##Change the theme ------
#this changes the overall appearance of the plot

red.data %>%
  ggplot(aes(x = Mass)) +
  geom_histogram(binwidth = 10, color = "dark blue", fill = "grey") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20)) +
  theme_classic()


#What if we wanted to separate this distribution by sex? ------

colnames(red.data)

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, color = "dark blue", fill = "grey") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20)) +
  theme_classic()

#But what's going on here?
#We need to make sure not to overwrite our original arguments later in the code....

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, color = "dark blue") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20)) +
  theme_classic()


#BUT I don't like these colors and what if I want to make sure my figures are colour-blind friendly?

#Introducing viridis -----

library(viridis)

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10) +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T) #adding the viridis palatte

#Changing where the viridis palatte begins and ends

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, colour = "black") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.8)

#Changing the color scale

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, colour = "black") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks=seq(160,300,by=20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.8, option = "magma")


#Manipulate the legend -----

#There are lots of ways to change the legend here are just a few

##Change the legend position ------
red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, colour = "black") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks=seq(160,300,by=20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.8, option = "magma") +
  theme(legend.position="bottom")

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, colour = "black") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks=seq(160,300,by=20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.8, option = "magma") +
  theme(legend.position = c(0.2, 0.8))

##Change the legend title and text -----

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, colour = "black") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by = 20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.8, option = "magma") +
  theme(legend.position = c(0.2, 0.8),
        legend.title = element_text(colour = "dark blue", size = 10,
                                    face = "bold"),
        legend.text = element_text(colour = "dark blue", size = 10,
                                   face = "bold"))

##Remove the plot legend -----

red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, colour = "black") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(160,300,by=20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.8, option = "magma") +
  theme(legend.position ='none')

#BUT this isn't a very good way of visualizing sex differences in body mass....

#Trying a different type of plot - the Boxplot -----

red.data %>%
  ggplot(aes(x = Sex, y = Mass)) +
  geom_boxplot() +
  labs(
    x = "Sex",
    y = "Body Mass"
  ) +
  scale_y_continuous(breaks = seq(160,300,by = 20)) +
  theme_classic()


#What if we want to look at this relationship across multiple species?

#Using facet_grid -------

table(data$Category)
summary(data$Mass)

data %>%
  ggplot(aes(x = Sex, y = Mass)) +
  geom_boxplot() +
  labs(
    x = "Sex",
    y = "Body Mass"
  ) +
  scale_y_continuous(breaks = seq(100,300,by = 20)) +
  theme_classic() +
  facet_grid(cols = vars(Category)) #can alter whether this is organized by column or row

#Add color to this

data %>%
  ggplot(aes(x = Sex, y = Mass, fill = Category)) +
  geom_boxplot() +
  labs(
    x = "Sex",
    y = "Body Mass"
  ) +
  scale_y_continuous(breaks = seq(100,300,by = 20)) +
  theme_classic() +
  facet_grid(cols = vars(Category)) +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.9)


#Let's try a scatter plot -----

#Look at the relationship between mass and incisor bite force

data %>%
  ggplot(aes(x = Mass, y = Incisor_BiteForce)) +
  geom_point()

##Prettify the figure ----

data %>%
  ggplot(aes(x = Mass, y = Incisor_BiteForce)) +
  geom_point() +
  labs(
    x = "Body mass (grams)",
    y = "Incisor Bite Force") +
  scale_y_continuous(breaks = seq(25, 50, by = 5)) +
  scale_x_continuous(breaks = seq(100, 300, by = 20)) +
  theme_classic()

##Add a line of best fit -----

data %>%
  ggplot(aes(x = Mass, y = Incisor_BiteForce)) +
  geom_point() +
  labs(
    x = "Body mass (grams)",
    y = "Incisor Bite Force") +
  scale_y_continuous(breaks = seq(25, 50, by = 5)) +
  scale_x_continuous(breaks = seq(100, 300, by = 20)) +
  theme_classic() +
  stat_smooth(method = "lm")

#Maybe we expect the relationship between bite force and mass to depend on the species....?

#Note that here we have to use "color" rather than "fill" and "scale_color_viridis" rather than "scale_fill_viridis"

data %>%
  ggplot(aes(x = Mass, y = Incisor_BiteForce, color = Category)) +
  geom_point() +
  labs(
    x = "Body mass (grams)",
    y = "Incisor Bite Force") +
  scale_y_continuous(breaks = seq(25, 50, by = 5)) +
  scale_x_continuous(breaks = seq(100, 300, by = 20)) +
  theme_classic() +
  stat_smooth(method = "lm") +
  scale_color_viridis(discrete = T, begin = 0.3, end = 0.9)

#Bonus- rather than just plotting three differently coloured lines for each species, how would you plot the body mass/bite force relationship for each species in a separate panel? Try it if you're feeling bold.

#Combine into multi-paneled figure -----
#Finally let's combine the 3 figures we made into a single figure

library(ggeffects)

#First step is we need to assign each of our figures to an object

graph1 <- red.data %>%
  ggplot(aes(x = Mass, fill = Sex)) +
  geom_histogram(binwidth = 10, colour = "black") +
  labs(
    title = "Histogram of red squirrel body mass",
    x = "Body mass (grams)",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks=seq(160,300,by=20)) +
  theme_classic() +
  scale_fill_viridis(discrete = T, begin = 0.3, end = 0.8, option = "magma")

graph2 <- data %>%
  ggplot(aes(x = Sex, y = Mass)) +
  geom_boxplot() +
  labs(
    x = "Sex",
    y = "Body Mass"
  ) +
  scale_y_continuous(breaks = seq(100,300,by = 20)) +
  theme_classic() +
  facet_grid(cols = vars(Category))

graph3 <- data %>%
  ggplot(aes(x = Mass, y = Incisor_BiteForce, color = Category)) +
  geom_point() +
  labs(
    x = "Body mass (grams)",
    y = "Incisor Bite Force") +
  scale_y_continuous(breaks = seq(25, 50, by = 5)) +
  scale_x_continuous(breaks = seq(100, 300, by = 20)) +
  theme_classic() +
  stat_smooth(method = "lm") +
  scale_color_viridis(discrete = T, begin = 0.3, end = 0.9)

#Now use the ggarrange function to plot together

ggarrange(graph1, graph2, graph3, ncol = 2, nrow = 2)


#Now an example for you to try -------

#The data collected here was actually used in a paper to explore interspecific divergence in dietary ecomorphology. With this in mind, can you create a graph showing the differences in BFQ (bite force quotient) between each species? What type of graph will you need to illustrate this?

#Could you then split this figure to show differences between the sexes in BFQ for each species?

#Can you make each sex a different color?
