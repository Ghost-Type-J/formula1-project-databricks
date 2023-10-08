-- Databricks notebook source
-- MAGIC %md
-- MAGIC Create circuits table using the .csv file in SQL

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS f1_raw

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Create circuits table

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.circuits;
CREATE TABLE IF NOT EXISTS f1_raw.circuits(
  circuitId INT,
circuitRef STRING,
name STRING,
location STRING,
country STRING,
lat DOUBLE,
lng DOUBLE,
alt INT,
url STRING
)
USING csv
OPTIONS (path "/mnt/jumayelformula1dl/raw/circuits.csv", header true)


-- COMMAND ----------

SELECT * FROM f1_raw.circuits

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Create races table using races.csv file in SQL

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.races;
CREATE TABLE IF NOT EXISTS f1_raw.races(
  raceId INT,
  year INT,
  round INT,
  circuitId INT,
  name STRING,
  date DATE,
  time STRING,
  url STRING
)
USING CSV
OPTIONS(path "/mnt/jumayelformula1dl/raw/races.csv", header true)

-- COMMAND ----------

SELECT * FROM f1_raw.races

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Create constructors table
-- MAGIC - Single line JSON
-- MAGIC - Simple structure

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.constructors;
CREATE TABLE IF NOT EXISTS f1_raw.constructors(
  constructorId INT,
  constructorRef STRING,
  name STRING,
  nationality STRING,
  url STRING
)
USING JSON
OPTIONS(path "/mnt/jumayelformula1dl/raw/constructors.json", header true)

-- COMMAND ----------

SELECT * FROM f1_raw.constructors

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Create drivers table
-- MAGIC - Single line JSON
-- MAGIC - Complex structure

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.drivers;
CREATE TABLE IF NOT EXISTS f1_raw.drivers(
    driverId INT,
    driverRef STRING,
    number INT,
    code STRING,
    name STRUCT<forename: STRING, surname: STRING>,
    dob DATE,
    nationality STRING,
    url STRING
)
USING JSON
OPTIONS(path "/mnt/jumayelformula1dl/raw/drivers.json", header true)

-- COMMAND ----------

SELECT * FROM f1_raw.drivers

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Create results table
-- MAGIC - Single line JSON
-- MAGIC - Simple structure

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.results;
CREATE TABLE IF NOT EXISTS f1_raw.results(
  resultId INT,
  raceId INT,
  driverId INT,
  constructorId INT,
  number INT,
  grid INT,
  position INT,
  positionText STRING,
  positionOrder INT,
  points FLOAT,
  laps INT,
  time STRING,
  milliseconds INT,
  fastestLap INT,
  rank INT,
  fastestLapTime STRING,
  fastestLapSpeed STRING,
  statusId INT
) USING JSON OPTIONS(
  path "/mnt/jumayelformula1dl/raw/results.json",
  header true
)

-- COMMAND ----------

SELECT *
FROM f1_raw.results

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Create pit stops table
-- MAGIC - Multi line JSON
-- MAGIC - Simple structure

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.pit_stops;
CREATE TABLE IF NOT EXISTS f1_raw.pit_stops(
  raceId INT,
  driverId INT,
  stop INT,
  lap INT,
  time STRING,
  duration STRING,
  milliseconds INT
) USING JSON OPTIONS(
  path "/mnt/jumayelformula1dl/raw/pit_stops.json",
  multiLine true
)

-- COMMAND ----------

SELECT * FROM f1_raw.pit_stops

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Create Lap times table
-- MAGIC - CSV file
-- MAGIC - multiple files

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.lap_times;
CREATE TABLE IF NOT EXISTS f1_raw.lap_times(
  race_id INT,
  driver_id INT,
  lap INT,
  position INT,
  time STRING,
  milliseconds INT
) USING csv OPTIONS (
  path "/mnt/jumayelformula1dl/raw/lap_times/",
  header true
)

-- COMMAND ----------

SELECT * FROM f1_raw.lap_times

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Create Qualifying table
-- MAGIC - JSON file
-- MAGIC - Multi Line JSON
-- MAGIC - multiple files

-- COMMAND ----------

DROP TABLE IF EXISTS f1_raw.qualifying;
CREATE TABLE IF NOT EXISTS f1_raw.qualifying(
  qualifyId INT,
  raceId INT,
  driverId INT,
  constructorId INT,
  number INT,
  position INT,
  q1 STRING,
  q2 STRING,
  q3 STRING
) USING JSON OPTIONS(
  path "/mnt/jumayelformula1dl/raw/qualifying/",
  multiLine true
)

-- COMMAND ----------

SELECT * FROM f1_raw.qualifying
