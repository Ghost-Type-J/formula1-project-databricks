-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC 1. Spark SQL documentation
-- MAGIC 2. Create Datavase demo
-- MAGIC 3. Data tab in the UI
-- MAGIC 4. SHOW command
-- MAGIC 5. DESCRIBE command 
-- MAGIC 6. Find the current database

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS demo;

-- COMMAND ----------

SHOW DATABASES;

-- COMMAND ----------

DESCRIBE DATABASE demo;

-- COMMAND ----------

DESCRIBE DATABASE EXTENDED demo;

-- COMMAND ----------

SELECT CURRENT_DATABASE()

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

USE demo;

-- COMMAND ----------

SELECT CURRENT_DATABASE()

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC 1. Create managed table using Python
-- MAGIC 2. Create managed table using SQL
-- MAGIC 3. Effect of dropping a managed table
-- MAGIC 4. Describe table

-- COMMAND ----------

-- MAGIC %run
-- MAGIC
-- MAGIC "../includes/configuration"

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC race_results_df = spark.read.parquet(f"{presentation_folder_path}/race_results")

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC race_results_df.write.format("parquet").saveAsTable("demo.race_results_python")

-- COMMAND ----------

USE demo;
SHOW TABLES;

-- COMMAND ----------

DESCRIBE EXTENDED race_results_python;

-- COMMAND ----------

SELECT * 
FROM demo.race_results_python
WHERE race_year = 2020;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Creating a managed table using SQL

-- COMMAND ----------

CREATE TABLE demo.race_results_sql
AS 
SELECT * 
FROM demo.race_results_python
WHERE race_year = 2020;

-- COMMAND ----------

DESCRIBE EXTENDED demo.race_results_sql

-- COMMAND ----------

DROP TABLE demo.race_results_sql

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

-- MAGIC %md 
-- MAGIC
-- MAGIC 1. Create external table using Python.
-- MAGIC 2. Create external table using SQL.
-- MAGIC 3. See the effect of dropping an external table.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC race_results_df.write.format("parquet").option("path", f"{presentation_folder_path}/race_results_ext_py").saveAsTable("demo.race_results_ext_py")

-- COMMAND ----------

DESCRIBE EXTENDED demo.race_results_ext_py

-- COMMAND ----------

DROP TABLE race_results_ext_sql;
CREATE TABLE demo.race_results_ext_sql
(race_year INT,
race_name STRING,
race_date TIMESTAMP,
cicuit_location STRING,
driver_name STRING,
driver_number INTEGER,
driver_nationality STRING,
team STRING,
grid INT,
fastest_lap INT,
race_time STRING,
points FLOAT,
position INT,
created_date TIMESTAMP)
USING PARQUET
LOCATION "/mnt/jumayelformula1dl/presentation/race_results_ext_sql"
-- In this step, you only create the metadata for the table it has not yet been allocated in the storage container in Azure. In order to get our external data in the contianer, we must insert data in the table in the following step.

-- COMMAND ----------

SHOW TABLES IN demo

-- COMMAND ----------

INSERT INTO demo.race_results_ext_sql
SELECT * FROM demo.race_results_ext_py WHERE race_year = 2020;

-- COMMAND ----------

SELECT COUNT(*)
FROM demo.race_results_ext_sql

-- COMMAND ----------

SHOW TABLES IN demo

-- COMMAND ----------

DROP TABLE demo.race_results_ext_sql

-- COMMAND ----------

SHOW TABLES IN demo

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Note that the table has been dropped in the metadata within databricks, but if we go an check the storage container in azure, the data is unaffected. In the case of external tables you are only controlling the tables. In order to actually remove the data from the file storage we need to use managed tables.
-- MAGIC
-- MAGIC The difference between external and managed tables and esternal tables is:
-- MAGIC 1. Managed tables: Spark manages the tables AND the data in the storage system.
-- MAGIC 2. External tables: Spark manages only the tables and data in the storage system is unaffected.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Views on tables
-- MAGIC
-- MAGIC 1. Create temp view
-- MAGIC 2. Create global temp view
-- MAGIC 3. Create permanent view
-- MAGIC
-- MAGIC A view is simply a visual respresentation of the data. When you call a view, it queries a table and brings back the results.

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW v_race_results
AS
SELECT * 
FROM demo.race_results_python
WHERE race_year = 2018

-- COMMAND ----------

SELECT *
FROM v_race_results

-- COMMAND ----------

CREATE OR REPLACE GLOBAL TEMP VIEW gv_race_results
AS
SELECT * 
FROM demo.race_results_python
WHERE race_year = 2018

-- COMMAND ----------

SELECT *
FROM global_temp.gv_race_results

-- COMMAND ----------

SHOW TABLES IN global_temp

-- COMMAND ----------

CREATE OR REPLACE VIEW demo.pv_race_results
AS
SELECT * 
FROM demo.race_results_python
WHERE race_year = 2000

-- COMMAND ----------

SHOW TABLES IN demo

-- COMMAND ----------


