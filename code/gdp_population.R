# Analyze life expectancy and CO2 emissions vs. population with gapminder
# Date: 1/17/2023
# Author: Yumino

# load packages
library("tidyverse")
library(readr)

# read data
gapminder_1997 <- read_csv("gapminder_1997.csv")

# plotting data
ggplot(data = gapminder_1997, aes(x = gdpPercap, y = lifeExp, color = continent, 
                                  size = pop/1000000, shape = continent)) +
        scale_color_brewer(palette = "Set1") +
        labs(x = "GDP Per Capita", 
             y = "Life Expectancy (yrs)", 
             title = "Do people in wealthy countries live longer?", 
             size = "Population (in millions)") +
        geom_point()

# read all data from gapminder (more years than 1997)
gapminder_data <- read_csv("gapminder_data.csv")
View(gapminder_data)
dim(gapminder_data)
head(gapminder_data)
tail(gapminder_data)

# predict the ggplot output
ggplot(data = gapminder_data, aes(x=year, y=lifeExp, color=continent, group = country)) +
        geom_line()

# learn about data
str(gapminder_data)

# violin plot
ggplot(data = gapminder_1997, aes(x = continent, y = lifeExp)) +
        geom_jitter(aes(size = pop)) +
        geom_violin(aes(color = continent))

# univariate plot histogram
ggplot(gapminder_1997) +
        aes(x = lifeExp) +
        geom_histogram(bins = 20) +
        theme_classic()

# facets
ggplot(gapminder_1997) +
        aes(x = gdpPercap, y = lifeExp) +
        geom_point() +
        facet_grid(rows = vars(continent))
ggsave("figures/awesome_plot.jpg", width = 6, height = 4)


