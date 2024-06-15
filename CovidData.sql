use Covid

select * from coviddata



-- check the total_cases and total deaths according to the country
SELECT location, 
       SUM(total_cases) AS total_cases,
       SUM(total_deaths) AS total_deaths,
       CASE 
           WHEN SUM(total_deaths) = 0 THEN NULL
           ELSE SUM(total_deaths) / SUM(total_cases)*100
       END AS Total
FROM coviddata
where continent is not null
GROUP BY location
ORDER BY location ASC;

-- check the total_cases in United Kingdom
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as percentage
from coviddata
where location ='United Kingdom'
and continent is not null
order by date ASC


--checking the population as well
--checking the total population that got covid
select location, date, total_cases, total_deaths, population, (total_cases/population)*100 as percentage
from coviddata
where location ='United Kingdom'
and continent is not null
order by date ASC


--checking how many people from the population lost their life
select location, date, total_cases, total_deaths, population, (total_cases/population)*100 as percentage, (total_deaths/population)*100 as deaths_in_percentage
from coviddata
where location ='United Kingdom'
and continent is not null
order by date ASC


-- checking where the infection rate was the highest with the death ratio
-- check the total_cases and total deaths according to the country
SELECT location, 
       SUM(total_cases) AS total_cases,
       SUM(total_deaths) AS total_deaths,
       CASE 
           WHEN SUM(total_deaths) = 0 THEN NULL
           ELSE SUM(total_deaths) / SUM(total_cases)*100
       END AS Total
FROM coviddata
where continent is not null
GROUP BY location
ORDER BY Total DESC;


-- checking the death rate by continent
select continent, sum(total_cases) as total_cases, sum(total_deaths) as death_total, (sum(total_deaths)/ Sum(total_cases)*100) as total
from covidData
where continent is not null
group by continent
order by total DESC;


--checking the total population that got vaccinated
select continent, date, population, new_vaccinations
from coviddata
where continent is not null
order by new_vaccinations DESC


--checking the total population and new vaccination in United Kingdom
select location, date, population, new_vaccinations
from coviddata
where location ='united Kingdom'
and continent is not null
and new_vaccinations is not null
order by date DESC


--  checking the new vaccination per day in united kingdom

SELECT continent, 
       location, 
       date, 
       population, 
       new_vaccinations, 
       SUM(CAST(new_vaccinations AS FLOAT)) OVER (PARTITION BY location ORDER BY date) AS rolling_vaccinations
FROM coviddata
WHERE location ='united Kingdom' and continent is not null
ORDER BY location, date;

-- Using CTE to do the same(Common Table Expression)

WITH PopulationvsVaccination AS (
    SELECT continent, 
           location, 
           date, 
           population, 
           new_vaccinations, 
           SUM(CAST(new_vaccinations AS FLOAT)) OVER (PARTITION BY location ORDER BY date) AS rolling_vaccinations
    FROM coviddata
    WHERE location = 'United Kingdom' AND continent IS NOT NULL
)
SELECT * 
FROM PopulationvsVaccination;



