-- Databricks notebook source
-- MAGIC %python
-- MAGIC html = """<h1 style="color:Black;text-align:center;font-family:arial"> Report on Dominant Formula 1 Teams </h1>"""
-- MAGIC displayHTML(html)

-- COMMAND ----------

CREATE
OR REPLACE TEMP VIEW v_dominant_teams AS
SELECT
  team_name,
  COUNT(team_name) AS number_of_races,
  SUM(calculated_points) AS all_time_weighted_points,
  AVG(calculated_points) AS average_weighted_points_per_race,
  RANK() OVER(ORDER BY AVG(calculated_points) DESC) AS team_rank
FROM
  f1_presentation.calculated_race_results
GROUP BY
  team_name
HAVING
  COUNT(team_name) >= 100
ORDER BY
  4 DESC

-- COMMAND ----------

SELECT
  race_year,
  team_name,
  COUNT(team_name) AS number_of_races,
  SUM(calculated_points) AS total_points,
  AVG(calculated_points) AS average_points
FROM
  f1_presentation.calculated_race_results
WHERE
  team_name IN (
    SELECT
      team_name
    FROM
      v_dominant_teams
    WHERE
      team_rank <= 5
  )
GROUP BY
  race_year,
  team_name
ORDER BY
  1,
  5 DESC

-- COMMAND ----------

SELECT
  race_year,
  team_name,
  COUNT(team_name) AS number_of_races,
  SUM(calculated_points) AS total_points,
  AVG(calculated_points) AS average_points
FROM
  f1_presentation.calculated_race_results
WHERE
  team_name IN (
    SELECT
      team_name
    FROM
      v_dominant_teams
    WHERE
      team_rank <= 5
  )
GROUP BY
  race_year,
  team_name
ORDER BY
  1,
  5 DESC

-- COMMAND ----------


