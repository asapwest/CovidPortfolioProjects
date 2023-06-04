# CovidPortfolioProjects
This repository contains the code and analysis for exploring COVID-19 data. The data used in this project is obtained from the covidDeaths table in the portfolioProject database. The purpose of this project is to analyze and gain insights from the COVID-19 data.

## Data Exploration
The following SQL queries were used to explore the data:

## Selecting Data for Analysis
The initial step involved selecting relevant columns from the covidDeaths table to use for our analysis. The columns included location, date, total_cases, new_cases, total_deaths, and population. The data was ordered by location and date.

## Total Cases vs Total Deaths
A query was executed to compare the total cases and total deaths, calculating the death rate percentage for each location. The query specifically focused on locations containing the term "states" and excluded null values for the continent. The data was sorted by location and date.

## Total Cases vs Population
Another query was performed to determine the percentage of the population infected by COVID-19 in each location. The query calculated the total deaths, percentage of population infected, and sorted the data by location.

## Countries with Highest Infection Rate
To identify the countries with the highest infection rates, a query was executed to group the data by location and population. The query included columns such as location, population, total deaths, and the percentage of population infected. The data was ordered by the percentage of population infected in descending order.

## Countries with Highest Death Count per Population
A query was used to find the countries with the highest death count per population. The data was grouped by location, excluding null values for the continent. The query selected the location and the maximum death count for each location, ordered in descending order.

# Breakdown by Continent
# Multiple queries were performed to analyze the data based on continents:

A query identified the continent with the highest death count. The data was grouped by continent, excluding null values, and sorted by the total death count in descending order.
A query focused on global numbers, calculating the total cases, total deaths, and death rate percentage. The data excluded null values for the continent and was ordered by date and total cases.
A query calculated the total cases, total deaths, and death percentage for the entire dataset, including all continents. The data was ordered by total cases and total deaths.

# Population vs Vaccinations
Several queries were executed to analyze the relationship between population and vaccinations:

A query joined the covidDeaths and covidVaccinations tables to obtain data on population, new vaccinations, and rolling people vaccinated. The data was ordered by location and date.
A Common Table Expression (CTE) was used to perform calculations on the partitioned data obtained from the previous query. The CTE included columns such as continent, location, date, population, new vaccinations, and rolling people vaccinated.
A temporary table was created to store the data and perform calculations on the partitioned data.
A view named PercentPopulationVaccinated was created to store the data for further analysis.

# Conclusion
Through this data exploration process, we gained insights into COVID-19 cases, deaths, infection rates, and vaccination progress. The analysis provides a deeper understanding of the impact of COVID-19 across different locations and continents.

Please note that the data used in this analysis may be subject to limitations and accuracy constraints. Feel free to explore the code and adapt it for your own analysis or research purposes.

If you have any questions or suggestions, please contact me asapwest231@GMAIL.com. We appreciate your interest and contributions to this project.

Thank you for visiting and exploring the COVID-19 data analysis!
