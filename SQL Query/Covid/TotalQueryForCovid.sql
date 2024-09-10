
-- CovidDeaths Table
SELECT * from CovidDeaths
WHERE continent is NOT NULL
Order By 3,4;

SELECT * from CovidVaccinations
Order By 3,4;

-- select particular colum from table

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent is NOT NULL
ORDER BY location,date;

-- To find out the mortality_rate_in_percentage by total_cases As total_deaths

SELECT location, date, total_cases, total_deaths,
CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT) * 100 AS mortality_rate_in_percentage
FROM CovidDeaths
ORDER BY location,date;

-- mortality_rate_in_percentage by location wise(filter the location using WHERE)
SELECT location, date, total_cases, total_deaths,
CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT) * 100 AS mortality_rate_in_percentage
FROM CovidDeaths
WHERE location = 'United States' -- WHERE location like '%states'
AND continent is NOT NULL
ORDER BY location,date;


-- To find out the Covid_case_percentage by total_cases As Population

SELECT location, date, total_cases, population,
CAST(total_cases AS FLOAT) / CAST(population AS FLOAT) * 100 AS covid_case_percentage
FROM CovidDeaths
ORDER BY location,date;

-- To find out which country experienced the most severe cases

SELECT location, population, MAX(total_cases) As Highest_Infection_Count,
MAX(CAST(total_cases AS FLOAT) / CAST(population AS FLOAT) * 100) AS Percentage_Population_Infected
FROM CovidDeaths
GROUP BY location, population
ORDER BY Percentage_Population_Infected DESC;

-- To find out which country experienced the Highest death cases
SELECT location,MAX(CAST(total_deaths as INT)) As TotalDeathCount
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- continents vs highest death count per population (Continent wise death count)
SELECT continent,MAX(CAST(total_deaths as INT)) As TotalDeath_in_continent
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY TotalDeath_in_continent DESC;

-- Global Numbers
SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths,
SUM(CAST(new_deaths as INT))/SUM(new_cases)*100 AS mortality_percentage
FROM CovidDeaths
WHERE continent is NOT NULL;


-- -----------------------------------------------------------------------------------------------------------------------


-- CovidVaccination Table

SELECT * FROM CovidVaccinations
WHERE continent is NOT NULL;

-- JOIN CovidDeaths and CovidVaccination tables
SELECT * FROM CovidDeaths death
JOIN CovidVaccinations vaccination
ON death.location = vaccination.location
AND death.date = vaccination.date;

-- Total population vs vaccinations
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population,CovidVaccinations.new_vaccinations,
SUM(CAST(CovidVaccinations.new_vaccinations as FLOAT)) OVER (Partition by covidDeaths.location ORDER BY CovidDeaths.location, CovidDeaths.date) as RollingPeopleVaccinated
FROM CovidDeaths
JOIN CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
WHERE CovidDeaths.continent is NOT NULL
ORDER BY 2,3; 


-- CTE
WITH Population_vs_Vaccination(continent,location,date,population, new_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population,CovidVaccinations.new_vaccinations,
SUM(CAST(CovidVaccinations.new_vaccinations as FLOAT)) OVER (Partition by covidDeaths.location ORDER BY CovidDeaths.location, CovidDeaths.date) as RollingPeopleVaccinated
FROM CovidDeaths
JOIN CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
WHERE CovidDeaths.continent is NOT NULL
)

-- Execute CTE
SELECT *, (RollingPeopleVaccinated/population)* 100 As Rolling_people_vaccinated_percentage FROM Population_vs_Vaccination;


-- TEMP Table

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
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population,CovidVaccinations.new_vaccinations,
SUM(CAST(CovidVaccinations.new_vaccinations as FLOAT)) OVER (Partition by covidDeaths.location ORDER BY CovidDeaths.location, CovidDeaths.date) as RollingPeopleVaccinated
FROM CovidDeaths
JOIN CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date

SELECT *, (RollingPeopleVaccinated/population)* 100 As Rolling_people_vaccinated_percentage FROM #PercentPopulationVaccinated;

-- creating view to store data for visualization
CREATE VIEW PercentPopulationVaccinated AS
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population,CovidVaccinations.new_vaccinations,
SUM(CAST(CovidVaccinations.new_vaccinations as FLOAT)) OVER (Partition by covidDeaths.location ORDER BY CovidDeaths.location, CovidDeaths.date) as RollingPeopleVaccinated
FROM CovidDeaths
JOIN CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
WHERE CovidDeaths.continent is NOT NULL;

SELECT * FROM PercentPopulationVaccinated;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------