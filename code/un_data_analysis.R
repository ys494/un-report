library(tidyverse)

gapminder_data <- read_csv("data/gapminder_data.csv")

summarize(gapminder_data, averageLifeExp = mean(lifeExp), 
          medianLifeExp = median(lifeExp))

# learning piping
gapminder_summary <- gapminder_data %>% 
        summarize(averageLifeExp = mean(lifeExp))

# filtering
gapminder_summary_2007 <- gapminder_data %>%
        filter(year == 2007) %>%
        summarize(average = mean(lifeExp))

# average GDP per capita for first year
gapminder_avgGDP <- gapminder_data %>%
        filter(year == min(year)) %>%
        summarize(average_GDP = mean(gdpPercap) )
# grouping 
gapminder_data %>%
        group_by(year, continent) %>%
        summarize(average = mean(lifeExp),
                  error = sd(lifeExp))

# mutating
gapminder_data %>%
        mutate(gdp = pop * gdpPercap)

# mutate new column -- population in millions 
gapminder_data %>%
        mutate(popInMillions = pop / 1000000)

# selecting
gapminder_data %>%
        select(pop, year)
gapminder_data %>%
        select(-continent)

# pivot wider
gapminder_data %>%
        select(country, continent, year, lifeExp) %>%
        pivot_wider(names_from = year, values_from = lifeExp) %>%
        View()

