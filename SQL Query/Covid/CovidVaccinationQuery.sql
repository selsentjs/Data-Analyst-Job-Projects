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