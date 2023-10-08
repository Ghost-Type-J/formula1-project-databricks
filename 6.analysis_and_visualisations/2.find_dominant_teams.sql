-- Databricks notebook source
SHOW DATABASES

-- COMMAND ----------

USE f1_presentation;
DESCRIBE f1_presentation.calculated_race_results

-- COMMAND ----------

SELECT
  team_name,
  COUNT(team_name) AS number_of_races,
  SUM(calculated_points) AS all_time_weighted_points,
  AVG(calculated_points) AS average_weighted_points_per_race
FROM f1_presentation.calculated_race_results
GROUP BY team_name
HAVING COUNT(team_name) >= 100
ORDER BY 4 DESC

-- COMMAND ----------

SELECT
  team_name,
  COUNT(team_name) AS number_of_races,
  SUM(calculated_points) AS all_time_weighted_points,
  AVG(calculated_points) AS average_weighted_points_per_race
FROM f1_presentation.calculated_race_results
WHERE race_year BETWEEN 2001 AND 2010
GROUP BY team_name
HAVING COUNT(1) >= 100
ORDER BY 4 DESC

-- COMMAND ----------

SELECT
  team_name,
  COUNT(team_name) AS number_of_races,
  SUM(calculated_points) AS all_time_weighted_points,
  AVG(calculated_points) AS average_weighted_points_per_race
FROM f1_presentation.calculated_race_results
WHERE race_year BETWEEN 2011 AND 2020
GROUP BY team_name
HAVING COUNT(team_name) >= 100
ORDER BY 4 DESC

-- COMMAND ----------


