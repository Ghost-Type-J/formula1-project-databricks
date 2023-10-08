-- Databricks notebook source
USE f1_processed;

SELECT *, CONCAT(driver_ref, "-", code) AS new_driver_ref
  FROM drivers

-- COMMAND ----------

SELECT
  *,
  split(name, " ") [0] AS forename,
  split(name, " ") [1] AS surname
FROM
  drivers

-- COMMAND ----------

SELECT count(*)
FROM drivers;

-- COMMAND ----------

SELECT nationality, count(*)
FROM drivers
GROUP BY nationality
HAVING COUNT(*) > 50
ORDER BY 2 DESC

-- COMMAND ----------

SELECT
  nationality,
  name,
  dob,
  RANK() OVER(
    PARTITION BY nationality
    ORDER BY
      dob DESC
  ) AS age_rank
FROM
  drivers
ORDER BY
  nationality,
  age_rank

-- COMMAND ----------


