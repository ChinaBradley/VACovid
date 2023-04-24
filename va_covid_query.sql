-- creating column that calculate new cases each day
DROP VIEW IF EXISTS va_new_cases;
CREATE VIEW va_new_cases AS
SELECT 
  *, 
  CASE 
	  WHEN total_cases - LAG(total_cases, 1) OVER(PARTITION BY locality ORDER BY report_date) IS NULL THEN total_cases
      ELSE total_cases - LAG(total_cases, 1) OVER(PARTITION BY locality ORDER BY report_date)
	  END AS new_cases,
  CASE
      WHEN deaths - LAG(deaths, 1) OVER(PARTITION BY locality ORDER BY report_date) IS NULL THEN deaths
	  ELSE deaths - LAG(deaths, 1) OVER(PARTITION BY locality ORDER BY report_date)
	  END AS new_deaths, 
  CASE
      WHEN hospitalizations - LAG(hospitalizations, 1) OVER(PARTITION BY locality ORDER BY report_date) IS NULL THEN hospitalizations
	  ELSE hospitalizations - LAG(hospitalizations, 1) OVER(PARTITION BY locality ORDER BY report_date) 
	  END AS new_hospitalizations  
FROM va_covid
ORDER BY report_date;



-- Number of infections to date
SELECT locality, MAX(total_cases) AS total_infected
FROM va_new_cases
GROUP BY locality
ORDER BY total_infected DESC;


-- Number of deaths to date
SELECT locality, MAX(deaths) AS total_deaths
FROM va_new_cases
GROUP BY locality
ORDER BY total_deaths DESC;


-- Number of Hospitalizations to date
SELECT locality, MAX(hospitalizations) AS total_hospitalizations
FROM va_new_cases
GROUP BY locality
ORDER BY total_hospitalizations DESC;


-- Number of Infections in each county by year
SELECT EXTRACT(year FROM report_date) AS year, locality, SUM(new_cases) AS total_infected
FROM va_new_cases
GROUP BY locality, EXTRACT(year FROM report_date)
ORDER BY 2,1;


-- Nuber of Infections in Virginia by year
SELECT EXTRACT(year FROM report_date) AS year, SUM(new_cases) AS total_infected
FROM va_new_cases
GROUP BY EXTRACT(year FROM report_date)
ORDER BY 1;


-- Number of infections to date
SELECT SUM(new_cases) AS total_hospitalizations
FROM va_new_cases;


-- Number of deaths in each county by year
SELECT EXTRACT(year FROM report_date) AS year, locality, SUM(new_deaths) AS total_deaths
FROM va_new_cases
GROUP BY locality, EXTRACT(year FROM report_date)
ORDER BY 2,1;


-- Number of deaths in Virginia by year
SELECT EXTRACT(year FROM report_date) AS year, SUM(new_deaths) AS total_deaths
FROM va_new_cases
GROUP BY EXTRACT(year FROM report_date)
ORDER BY 1;


-- Number of deaths to date
SELECT SUM(new_deaths) AS total_hospitalizations
FROM va_new_cases;


-- Number of hospitalizations in each county by year
SELECT EXTRACT(year FROM report_date) AS year, locality, SUM(new_hospitalizations) AS total_hospitalizations
FROM va_new_cases
GROUP BY locality, EXTRACT(year FROM report_date)
ORDER BY 2,1;


-- Number of deaths in Virginia by year
SELECT EXTRACT(year FROM report_date) AS year, SUM(new_hospitalizations) AS total_hospitalizations
FROM va_new_cases
GROUP BY EXTRACT(year FROM report_date)
ORDER BY 1;


-- Number of hospitalizations to date
SELECT SUM(new_hospitalizations) AS total_hospitalizations
FROM va_new_cases;


-- rolling average of new_cases
select *,
  avg(new_cases) OVER(ORDER BY locality, report_date
     ROWS BETWEEN 6 PRECEDING AND CURRENT ROW )
     as infections_7day_average
from va_new_cases
order by locality, report_date;


-- rolling average of deaths
select *,
  avg(new_deaths) OVER(ORDER BY locality, report_date
     ROWS BETWEEN 6 PRECEDING AND CURRENT ROW )
     as deaths_7day_average
from va_new_cases
order by locality, report_date;


-- rolling average of hospitalizations
select *,
  avg(new_hospitalizations) OVER(ORDER BY locality, report_date
     ROWS BETWEEN 6 PRECEDING AND CURRENT ROW )
     as hospitalizations_7day_average
from va_new_cases
order by locality, report_date;

