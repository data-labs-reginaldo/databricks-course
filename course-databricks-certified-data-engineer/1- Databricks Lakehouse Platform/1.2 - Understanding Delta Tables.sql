-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Creating Delta Lake Tables

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Note:** If your workspace does not support the `hive_metastore` catalog, switch to the **unity-catalog** branch in this Git Folder.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## %md
-- MAGIC ## USE CATALOG hive_metastore ==> não esta sendo mais usado no databricks free

-- COMMAND ----------

SHOW CATALOGS;

-- COMMAND ----------

SELECT current_catalog();

-- COMMAND ----------

SHOW SCHEMAS;

-- COMMAND ----------

USE CATALOG workspace;

SHOW SCHEMAS;


-- COMMAND ----------

USE CATALOG workspace;
USE SCHEMA default;

CREATE TABLE IF NOT EXISTS alunos (
    id INT,
    nome STRING
);

-- COMMAND ----------

SHOW TABLES;

-- COMMAND ----------

CREATE TABLE employees
  (id INT, name STRING, salary DOUBLE);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Catalog Explorer
-- MAGIC
-- MAGIC Check the created **employees** table in the **Catalog** explorer.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Inserting Data

-- COMMAND ----------

INSERT INTO employees
VALUES 
  (1, "Adam", 3500.0),
  (2, "Sarah", 4020.5);

INSERT INTO employees
VALUES
  (3, "John", 2999.3),
  (4, "Thomas", 4000.3);

INSERT INTO employees
VALUES
  (5, "Anna", 2500.0);

INSERT INTO employees
VALUES
  (6, "Kim", 6200.3)

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Exploring Table Metadata

-- COMMAND ----------

DESCRIBE DETAIL employees

-- COMMAND ----------

DESCRIBE DETAIL workspace.default.employees;

-- COMMAND ----------

SELECT current_catalog();

-- COMMAND ----------

SELECT current_schema();

-- COMMAND ----------

DESCRIBE HISTORY workspace.default.employees;

-- COMMAND ----------

SHOW TBLPROPERTIES workspace.default.employees;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Exploring Table Directory

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/employees'
-- MAGIC
-- MAGIC workspace.default.employees
-- MAGIC

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:'
-- MAGIC

-- COMMAND ----------

select * from employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Updating Table

-- COMMAND ----------

UPDATE employees 
SET salary = salary + 100
WHERE name LIKE "A%"

-- COMMAND ----------

select * from employees

-- COMMAND ----------

select * from employees@v

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC #### ls 'dbfs:/user/hive/warehouse/employees' -- naos esta sendo mais usada

-- COMMAND ----------

DESCRIBE DETAIL employees

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Exploring Table History

-- COMMAND ----------

DESCRIBE HISTORY employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ls 'dbfs:/user/hive/warehouse/employees/_delta_log'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC head 'dbfs:/user/hive/warehouse/employees/_delta_log/00000000000000000005.json'

-- COMMAND ----------

select * from employees@v04

-- COMMAND ----------

select * from employees@v05

-- COMMAND ----------

select sum(salary) from employees@v04
union all
select sum(salary) from employees@v05

-- COMMAND ----------

select * from employees@v01

-- COMMAND ----------

select * from employees@v00

-- COMMAND ----------

select * from employees@v02

-- COMMAND ----------

select * from employees@v03

-- COMMAND ----------

-- Os notebooks no Databricks são salvos automaticamente.

-- COMMAND ----------

select teste as teste


