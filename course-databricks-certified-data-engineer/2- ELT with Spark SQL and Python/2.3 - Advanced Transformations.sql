-- Databricks notebook source
-- MAGIC %md-sandbox
-- MAGIC
-- MAGIC <div  style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://raw.githubusercontent.com/derar-alhussein/Databricks-Certified-Data-Engineer-Associate/main/Includes/images/bookstore_schema.png" alt="Databricks Learning" style="width: 600">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %run ../Includes/Copy-Datasets

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Parsing JSON Data

-- COMMAND ----------

SELECT * FROM customers

-- COMMAND ----------

select count(*) from samples.tpcds_sf1000.customer limit 10 -- 12.000.000

-- COMMAND ----------

DESCRIBE customers

-- COMMAND ----------

SELECT c_customer_id,
       c_first_name,
       c_email_address
FROM samples.tpcds_sf1000.customer
LIMIT 10

-- COMMAND ----------

SELECT c_customer_id,
       get_json_object(profile, 'c_first_name') AS first_name,
       get_json_object(profile, 'c_email_address') AS address
FROM samples.tpcds_sf1000.customer limit 10;

-- COMMAND ----------

SELECT c_customer_sk,c_customer_id, c_first_name,
 c_email_address,c_birth_country 
FROM samples.tpcds_sf1000.customer limit 10

-- COMMAND ----------

select * FROM workspace.default.customers_lab;

-- COMMAND ----------

SELECT profile AS profile_struct
  FROM workspace.default.customers_lab limit 1;

-- COMMAND ----------

SELECT profile 
FROM workspace.default.customers_lab 
LIMIT 1

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW parsed_customers AS
  SELECT customer_id, from_json(profile, schema_of_json('{"first_name":"Thomas","last_name":"Lane","gender":"Male","address":{"street":"06 Boulevard Victor Hugo","city":"Paris","country":"France"}}')) AS profile_struct
  FROM workspace.default.customers_lab ;
  
SELECT * FROM parsed_customers

-- COMMAND ----------

DESCRIBE parsed_customers

-- COMMAND ----------

SELECT customer_id, profile_struct.first_name, profile_struct.address.country
FROM parsed_customers

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW customers_final AS
  SELECT customer_id, profile_struct.*
  FROM parsed_customers;
  
SELECT * FROM customers_final

-- COMMAND ----------

SELECT order_id, customer_id, books
FROM orders_lab

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Explode Function

-- COMMAND ----------

SELECT order_id, customer_id, explode(books) AS book 
FROM orders_lab

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Collecting Rows

-- COMMAND ----------

SELECT customer_id,
  collect_set(order_id) AS orders_set,
  collect_set(books.book_id) AS books_set
FROM orders_lab
GROUP BY customer_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ##Flatten Arrays

-- COMMAND ----------

SELECT customer_id,
  collect_set(books.book_id) As before_flatten,
  array_distinct(flatten(collect_set(books.book_id))) AS after_flatten
FROM orders_lab
GROUP BY customer_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ##Join Operations

-- COMMAND ----------

CREATE OR REPLACE VIEW orders_enriched AS
SELECT *
FROM (
  SELECT *, explode(books) AS book 
  FROM orders_lab) o
INNER JOIN books_lab b
ON o.book.book_id = b.book_id;

SELECT * FROM orders_enriched

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Set Operations

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW orders_updates
AS SELECT * FROM parquet.`${dataset.bookstore}/orders-new`;

SELECT * FROM orders_lab
UNION 
SELECT * FROM orders_updates 

-- COMMAND ----------

SELECT * FROM orders 
INTERSECT 
SELECT * FROM orders_updates 

-- COMMAND ----------

SELECT * FROM orders 
MINUS 
SELECT * FROM orders_updates 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Reshaping Data with Pivot

-- COMMAND ----------

CREATE OR REPLACE TABLE transactions AS

SELECT * FROM (
  SELECT
    customer_id,
    book.book_id AS book_id,
    book.quantity AS quantity
  FROM orders_enriched
) PIVOT (
  sum(quantity) FOR book_id in (
    'B01', 'B02', 'B03', 'B04', 'B05', 'B06',
    'B07', 'B08', 'B09', 'B10', 'B11', 'B12'
  )
);

SELECT * FROM transactions

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Null-Safe Join
-- MAGIC Wen performing join operations in Apache Spark, the standard equality operator (=) evaluates to NULL if either or both sides of the comparison are NULL
-- MAGIC
-- MAGIC Examples:
-- MAGIC
-- MAGIC SELECT 5 = 5 → TRUE
-- MAGIC
-- MAGIC SELECT 5 = 7 → FALSE
-- MAGIC
-- MAGIC SELECT NULL = NULL → NULL
-- MAGIC
-- MAGIC SELECT 5 = NULL → NULL
-- MAGIC
-- MAGIC Because NULL represents an unknown value, standard joins will filter those records out.
-- MAGIC
-- MAGIC To handle comparisons where NULL values should be treated as equal to other NULL values, Spark provides the null-safe equal operator, which is written as <=>. For example:
-- MAGIC
-- MAGIC SELECT *
-- MAGIC FROM orders o
-- MAGIC INNER JOIN customers c
-- MAGIC ON o.customer_id <=> c.customer_id;
-- MAGIC
-- MAGIC
-- MAGIC Here, o.customer_id <=> c.customer_id returns true if both values are equal, or if both values are NULL. Otherwise, it returns false.
-- MAGIC
-- MAGIC Examples:
-- MAGIC
-- MAGIC SELECT 5 <=> 5 → TRUE
-- MAGIC
-- MAGIC SELECT 5 <=> 7 → FALSE
-- MAGIC
-- MAGIC SELECT NULL <=> NULL → TRUE
-- MAGIC
-- MAGIC SELECT 5 <=> NULL → FALSE   

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Legacy JSON Querying Syntax
-- MAGIC Before the introduction of the colon syntax (profile:first_name) for querying semi-structured data, Spark SQL commonly used the get_json_object() function to extract values from JSON strings. This older approach uses JSONPath expressions such as $.first_name and treats JSON as plain text, always returning values as strings.
-- MAGIC
-- MAGIC Example using colon syntax:
-- MAGIC
-- MAGIC SELECT customer_id,
-- MAGIC        profile:first_name,
-- MAGIC        profile:address:country
-- MAGIC FROM customers;
-- MAGIC
-- MAGIC
-- MAGIC Equivalent query using the older syntax:
-- MAGIC
-- MAGIC SELECT customer_id,
-- MAGIC        get_json_object(profile, '$.first_name') AS first_name,
-- MAGIC        get_json_object(profile, '$.address.country') AS country
-- MAGIC FROM customers;
-- MAGIC
-- MAGIC
-- MAGIC get_json_object() is still supported and useful for compatibility with older Spark code, and you may still encounter it in existing codebases and exam questions, so it is important to recognize both syntaxes.
