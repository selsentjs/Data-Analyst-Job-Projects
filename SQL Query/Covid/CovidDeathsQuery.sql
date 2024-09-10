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


