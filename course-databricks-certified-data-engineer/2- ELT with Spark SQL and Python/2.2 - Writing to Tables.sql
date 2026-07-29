-- Databricks notebook source
-- MAGIC %md-sandbox
-- MAGIC
-- MAGIC <div  style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://raw.githubusercontent.com/derar-alhussein/Databricks-Certified-Data-Engineer-Associate/main/Includes/images/bookstore_schema.png" alt="Databricks Learning" style="width: 600">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %run ../Includes/Copy-Datasets

-- COMMAND ----------

CREATE TABLE orders AS
SELECT * FROM parquet.`${dataset.bookstore}/orders`

-- COMMAND ----------

SELECT * FROM orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Overwriting Tables

-- COMMAND ----------

CREATE OR REPLACE TABLE orders AS
SELECT * FROM parquet.`${dataset.bookstore}/orders`

-- COMMAND ----------

DESCRIBE HISTORY orders

-- COMMAND ----------

INSERT OVERWRITE orders
SELECT * FROM parquet.`${dataset.bookstore}/orders`

-- COMMAND ----------

DESCRIBE HISTORY orders

-- COMMAND ----------

INSERT OVERWRITE orders
SELECT *, current_timestamp() FROM parquet.`${dataset.bookstore}/orders`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Appending Data

-- COMMAND ----------

INSERT INTO orders
SELECT * FROM parquet.`${dataset.bookstore}/orders-new`

-- COMMAND ----------

SELECT count(*) FROM orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Merging Data

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW customers_updates AS 
SELECT * FROM json.`${dataset.bookstore}/customers-json-new`;

MERGE INTO customers c
USING customers_updates u
ON c.customer_id = u.customer_id
WHEN MATCHED AND c.email IS NULL AND u.email IS NOT NULL THEN
  UPDATE SET email = u.email, updated = u.updated
WHEN NOT MATCHED THEN INSERT *

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW books_updates
   (book_id STRING, title STRING, author STRING, category STRING, price DOUBLE)
USING CSV
OPTIONS (
  path = "${dataset.bookstore}/books-csv-new",
  header = "true",
  delimiter = ";"
);

SELECT * FROM books_updates

-- COMMAND ----------

MERGE INTO books b
USING books_updates u
ON b.book_id = u.book_id AND b.title = u.title
WHEN NOT MATCHED AND u.category = 'Computer Science' THEN 
  INSERT *

-- COMMAND ----------

drop table employees_teste;
drop view temp_employees_teste;


-- COMMAND ----------

CREATE TABLE employees_teste
  (id INT, name STRING, salary DOUBLE);

-- COMMAND ----------

select * from employees_teste

-- COMMAND ----------

INSERT INTO employees_teste
VALUES 
  (1, "Adam", 3500.0),
  (2, "Sarah", 4020.5);

INSERT INTO employees_teste
VALUES
  (3, "John", 2999.3),
  (4, "Thomas", 4000.3);

INSERT INTO employees_teste
VALUES
  (5, "Anna", 2500.0);

INSERT INTO employees_teste
VALUES
  (6, "Kim", 6200.3)

-- COMMAND ----------

describe history employees_teste;


-- COMMAND ----------

select * from employees_teste

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW temp_employees_teste AS 
SELECT * FROM employees_teste@v04;

-- COMMAND ----------

SELECT * FROM temp_employees_teste;

-- COMMAND ----------

update employees_teste set salary = 10000 where id = 1

-- COMMAND ----------

delete from employees_teste where id = 2

-- COMMAND ----------

SELECT * FROM employees_teste;

-- COMMAND ----------

describe history employees_teste;

-- COMMAND ----------

 -- (id INT, name STRING, salary DOUBLE);

MERGE INTO employees_teste c
USING temp_employees_teste u
ON c.id = u.id
WHEN MATCHED AND c.salary <> u.salary THEN
  UPDATE SET salary = u.salary
WHEN NOT MATCHED THEN INSERT *

-- COMMAND ----------

SELECT * FROM employees_teste;

-- COMMAND ----------

describe history employees_teste

-- COMMAND ----------

DESCRIBE HISTORY employees_teste;

-- COMMAND ----------

DESCRIBE DETAIL employees_teste;

-- COMMAND ----------

OPTIMIZE employees_teste;

-- COMMAND ----------

DESCRIBE DETAIL employees_teste;
