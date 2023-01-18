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

# working with messy data
co2_emissions_dirty <- read_csv("data/co2-un-data.csv", skip = 2,
         col_names = c("region", "country", "year", "series", "value", "footnotes", "source"))

# co2 emissions data
co2_emissions <- co2_emissions_dirty %>%
        select(country, year, series, value) %>%
        mutate(series = recode(series, 
                               "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions",
                               "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>%
        pivot_wider(names_from = series, values_from = value) %>% 
        filter(year == 2005) %>%
        select(-year)

# import 2007 population data     
gapminder_data_2007 <- read_csv("data/gapminder_data.csv") %>%
        filter(year == 2007) %>%
        select(country, pop, lifeExp, gdpPercap)

joined_co2_pop <- inner_join(co2_emissions, gapminder_data_2007)

anti_join(gapminder_data_2007, co2_emissions, by = "country")

full_join(co2_emissions, gapminder_data_2007) %>%
        View()

# writing a csv
write_csv(joined_co2_pop, file = "data/joined_co2_pop.csv")




