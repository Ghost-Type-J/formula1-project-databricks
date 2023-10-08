-- Databricks notebook source
SHOW DATABASES

-- COMMAND ----------

SELECT CURRENT_DATABASE()

-- COMMAND ----------

USE f1_processed

-- COMMAND ----------

SELECT CURRENT_DATABASE()

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

SELECT
  name, nationality, dob AS date_of_birth
FROM
  f1_processed.drivers
WHERE
  nationality = "British"
  AND dob >= "1985-01-01"
ORDER BY 
  3 DESC
LIMIT
  500

-- COMMAND ----------

DESCRIBE f1_processed.drivers

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
