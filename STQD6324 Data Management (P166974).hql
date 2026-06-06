SELECT t.country AS country,
       t.total_population AS population,
       t.year AS year
FROM total_population_cleaned t
JOIN (
    SELECT MAX(year) AS latest_year
    FROM total_population_cleaned
) y
ON t.year = y.latest_year
ORDER BY population DESC
LIMIT 10;

SELECT t.country AS country,
       t.total_population AS population,
       t.year AS year
FROM total_population_cleaned t
JOIN (
    SELECT MAX(year) AS latest_year
    FROM total_population_cleaned
) y
ON t.year = y.latest_year
ORDER BY population ASC
LIMIT 10;

SELECT t.country AS country,
       t.gdp_per_capita AS gdp_per_capita,
       t.year AS year
FROM gdp_per_capita_cleaned t
JOIN (
    SELECT MAX(year) AS latest_year
    FROM gdp_per_capita_cleaned
) y
ON t.year = y.latest_year
ORDER BY gdp_per_capita DESC
LIMIT 10;

SELECT t.country AS country,
       t.gdp_per_capita AS gdp_per_capita,
       t.year AS year
FROM gdp_per_capita_cleaned t
JOIN (
    SELECT MAX(year) AS latest_year
    FROM gdp_per_capita_cleaned
) y
ON t.year = y.latest_year
ORDER BY gdp_per_capita ASC
LIMIT 10;

SELECT MIN(year) AS oldest_year,
       MAX(year) AS latest_year
FROM life_expectancy_cleaned;

SELECT country,
       AVG(life_expectancy) AS avg_life_expectancy
FROM life_expectancy_cleaned
GROUP BY country
LIMIT 10;

SELECT year,
       AVG(life_expectancy) AS global_avg_life_expectancy
FROM life_expectancy_cleaned
GROUP BY year
ORDER BY year ASC;

SELECT g.country AS country,
       AVG(g.gdp_per_capita) AS avg_gdp,
       AVG(h.health_expenditure_per_capita) AS avg_health_expenditure
FROM gdp_per_capita_cleaned g
JOIN health_expenditure_per_capita_cleaned h
ON g.country = h.country
AND g.year = h.year
GROUP BY g.country;

SELECT h.country AS country,
       AVG(h.health_expenditure_per_capita) AS avg_health_expenditure,
       AVG(l.life_expectancy) AS avg_life_expectancy
FROM health_expenditure_per_capita_cleaned h
JOIN life_expectancy_cleaned l
ON h.country = l.country
AND h.year = l.year
GROUP BY h.country;

SELECT h.country AS country,
       AVG(h.health_expenditure_per_capita) AS avg_health_expenditure,
       AVG(u.under_5_mortality_rate) AS avg_under_5_mortality_rate
FROM health_expenditure_per_capita_cleaned h
JOIN under_5_mortality_rate_cleaned u
ON h.country = u.country
AND h.year = u.year
GROUP BY h.country;

SELECT h.country AS country,
       AVG(h.health_expenditure_per_capita) AS avg_health_expenditure,
       AVG(i.hiv_incidence) AS avg_hiv_incidence
FROM health_expenditure_per_capita_cleaned h
JOIN hiv_infections_cleaned i
ON h.country = i.country
AND h.year = i.year
GROUP BY h.country;

SELECT h.country AS country,
       AVG(h.health_expenditure_per_capita) AS avg_health_expenditure,
       AVG(d.doctors_per_10k) AS avg_doctors_per_10k
FROM health_expenditure_per_capita_cleaned h
JOIN density_of_doctors_cleaned d
ON h.country = d.country
AND h.year = d.year
GROUP BY h.country;

SELECT country,
       year,
       co2_emissions
FROM co2_emissions_cleaned
GROUP BY country, year, co2_emissions
ORDER BY year ASC;

SELECT g.country AS country,
       AVG(g.gdp_per_capita) AS avg_gdp,
       AVG(c.co2_emissions) AS avg_co2_emissions
FROM gdp_per_capita_cleaned g
JOIN co2_emissions_cleaned c
ON g.country = c.country
AND g.year = c.year
GROUP BY g.country;

CREATE VIEW health_economic_environmental_summary AS
SELECT p.country,
       p.year,
       l.life_expectancy,
       h.health_expenditure_per_capita,
       m.under_5_mortality_rate,
       c.co2_emissions,
       i.hiv_incidence,
       d.doctors_per_10k,
       g.gdp_per_capita,
       p.total_population
FROM total_population_cleaned p
LEFT JOIN life_expectancy_cleaned l
    ON p.country = l.country AND p.year = l.year
LEFT JOIN health_expenditure_per_capita_cleaned h
    ON p.country = h.country AND p.year = h.year
LEFT JOIN under_5_mortality_rate_cleaned m
    ON p.country = m.country AND p.year = m.year
LEFT JOIN co2_emissions_cleaned c
    ON p.country = c.country AND p.year = c.year
LEFT JOIN hiv_infections_cleaned i
    ON p.country = i.country AND p.year = i.year
LEFT JOIN density_of_doctors_cleaned d
    ON p.country = d.country AND p.year = d.year
LEFT JOIN gdp_per_capita_cleaned g
    ON p.country = g.country AND p.year = g.year;

SELECT 
    country AS country,
    year AS year,
    life_expectancy AS life_expectancy,
    health_expenditure_per_capita AS health_expenditure_per_capita,
    co2_emissions AS co2_emissions,
    under_5_mortality_rate AS under_5_mortality_rate,
    hiv_incidence AS hiv_incidence,
    doctors_per_10k AS doctors_per_10k,
    gdp_per_capita AS gdp_per_capita,
    total_population AS total_population
FROM health_economic_environmental_summary
WHERE year >= 2000;

