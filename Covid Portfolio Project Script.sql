SELECT * 
FROM portfolioProject..covidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT * 
--FROM portfolioProject..covidvaccinations

--Selecting data to use for our analysis

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM portfolioProject..covidDeaths
ORDER BY 1,2



--Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths, cast(total_deaths as int) / cast(total_cases as int)*100 AS death_rate_Percentage
FROM portfolioProject..covidDeaths
WHERE location LIKE '%states%' 
AND continent IS NOT NULL
ORDER BY 1, 2;



-- Total Cases vs Population

SELECT location, MAX(total_cases) as TotalDeaths, CONVERT(float, total_cases)/population *100 AS PercentagePopulationInfected
FROM portfolioProject..covidDeaths
WHERE location LIKE '%states%'
ORDER BY 1, 2;



-- Countries with Highest Infection Rate

SELECT location, population, MAX(total_cases) as total_deaths, MAX(CONVERT(float, total_cases)/population) *100 AS PercentagePopulationInfected
FROM portfolioProject..covidDeaths
GROUP BY location, population
ORDER BY PercentagePopulationInfected desc;



-- Countries with Highest Death Count per population

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM portfolioProject..covidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount desc;



--LET'S BREAK THINGS DOWN BY CONTINENT

-- Continent with Highest Death Rate
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM portfolioProject..covidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount desc;



-- Global Numbers

SELECT date, total_cases, total_deaths, (CONVERT(float, total_deaths) / CONVERT(float, total_cases))*100 AS death_rate_Percentage
FROM portfolioProject..covidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2



-- Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (partition by dea.location,
	dea.date ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM portfolioProject..covidDeaths as dea
JOIN portfolioProject..covidVaccinations as vac
	ON dea.date = vac.date
	WHERE dea.continent IS NOT NULL
ORDER BY 2,3



--Using CTE to perform Calculation on Partition By of the previous query

With PopvsVac (continent, location,date, population, new_vaccinations, RollingPeopleVaccinated)
as (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (partition by dea.location,
	dea.date ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM portfolioProject..covidDeaths as dea
JOIN portfolioProject..covidVaccinations as vac
	ON dea.date = vac.date
	WHERE dea.continent IS NOT NULL
	)
SELECT * , (RollingPeopleVaccinated/population)*100
FROM PopvsVac




-- Creating TEMP Table to perform calculation on Partition By

DROP TABLE if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (partition by dea.location,
	dea.date ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM portfolioProject..covidDeaths as dea
JOIN portfolioProject..covidVaccinations as vac
	ON dea.date = vac.date
	WHERE dea.continent IS NOT NULL 

SELECT * , (RollingPeopleVaccinated/population)*100
FROM #PercentPopulationVaccinated



-- Creating View to store data 

CREATE VIEW PercentPopulationVaccinated
as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (partition by dea.location,
	dea.date ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM portfolioProject..covidDeaths as dea
JOIN portfolioProject..covidVaccinations as vac
	ON dea.date = vac.date
	WHERE dea.continent IS NOT NULL 

SELECT *
FROM PercentPopulationVaccinated


