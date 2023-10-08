-- Databricks notebook source
DESCRIBE f1_presentation.calculated_race_results

-- COMMAND ----------

SELECT 
driver_name,
COUNT(driver_name) AS total_races,
SUM(calculated_points) AS total_points,
AVG(calculated_points) AS avg_points
FROM f1_presentation.calculated_race_results
GROUP BY driver_name
HAVING COUNT(driver_name) >= 50
ORDER BY 4 DESC

-- COMMAND ----------

SELECT 
driver_name,
COUNT(driver_name) AS total_races,
SUM(calculated_points) AS total_points,
AVG(calculated_points) AS avg_points
FROM f1_presentation.calculated_race_results
WHERE race_year BETWEEN 2011 AND 2020
GROUP BY driver_name
HAVING COUNT(driver_name) >= 50
ORDER BY 4 DESC

-- COMMAND ----------

SELECT 
driver_name,
COUNT(driver_name) AS total_races,
SUM(calculated_points) AS total_points,
AVG(calculated_points) AS avg_points
FROM f1_presentation.calculated_race_results
WHERE race_year BETWEEN 2001 AND 2010
GROUP BY driver_name
HAVING COUNT(driver_name) >= 50
ORDER BY 4 DESC

-- COMMAND ----------


