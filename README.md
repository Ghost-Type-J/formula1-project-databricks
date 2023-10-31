# formula1-project-databricks

A project using the Azure Databricks platform in conjunction with Azure Data Lake Storage to analyse Formula 1 data. The vast majority of code is written in Python, SQL and pySpark.

In this project, I ingest historical Formula 1 data from 1950 to 2021 using Ergast API (deprecated).
 
I load the datasets into an Azure Data Lake and then run them through Databricks using a spark cluster.

Using both PySpark and SQL, I ingest and apply various transformations to my data to allow them to prepare the data for analysis (for a data analyst or otherwise). The data transformations can be procedurally executed as part of a data pipeline when new data becomes available in the API.

The pipeline supports the incremental load of the data. It takes historical data and then expects a delta on every scheduled data ingestion.
 
Some analysis is conducted on the teams and drivers of Formula 1, but the main focus in this project is working with Spark compute clusters and creating Databricks notebooks which can be scheduled to run recurringly.
