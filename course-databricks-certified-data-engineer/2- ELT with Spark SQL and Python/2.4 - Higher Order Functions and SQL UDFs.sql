-- Databricks notebook source
-- MAGIC %md-sandbox
-- MAGIC
-- MAGIC <div  style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://raw.githubusercontent.com/derar-alhussein/Databricks-Certified-Data-Engineer-Associate/main/Includes/images/bookstore_schema.png" alt="Databricks Learning" style="width: 600">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %run ../Includes/Copy-Datasets

-- COMMAND ----------

SELECT * FROM orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Filtering Arrays

-- COMMAND ----------

SELECT
  order_id,
  books,
  FILTER (books, i -> i.quantity >= 2) AS multiple_copies
FROM orders_lab

-- COMMAND ----------

SELECT order_id, multiple_copies
FROM (
  SELECT
    order_id,
    FILTER (books, i -> i.quantity >= 2) AS multiple_copies
  FROM orders_lab)
WHERE size(multiple_copies) > 0;

-- COMMAND ----------

describe customers_lab

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Transforming Arrays

-- COMMAND ----------

SELECT
  order_id,
  books,
  TRANSFORM (
    books,
    b -> CAST(b.subtotal * 0.8 AS INT)
  ) AS subtotal_after_discount
FROM orders_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## User Defined Functions (UDF)

-- COMMAND ----------

CREATE OR REPLACE FUNCTION get_url(email STRING)
RETURNS STRING

RETURN concat("https://www.", split(email, "@")[1])

-- COMMAND ----------

SELECT email, get_url(email) domain
FROM customers_lab

-- COMMAND ----------

DESCRIBE FUNCTION get_url

-- COMMAND ----------

DESCRIBE FUNCTION EXTENDED get_url

-- COMMAND ----------

CREATE FUNCTION site_type(email STRING)
RETURNS STRING
RETURN CASE 
          WHEN email like "%.com" THEN "Commercial business"
          WHEN email like "%.org" THEN "Non-profits organization"
          WHEN email like "%.edu" THEN "Educational institution"
          ELSE concat("Unknow extenstion for domain: ", split(email, "@")[1])
       END;

-- COMMAND ----------

SELECT email, site_type(email) as domain_category
FROM customers

-- COMMAND ----------

DROP FUNCTION get_url;
DROP FUNCTION site_type;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ##  USER DEFINED FUNCTION (UDF)
-- MAGIC
-- MAGIC --
-- MAGIC -- Nome.......: get_url
-- MAGIC -- Objetivo...: Retornar a URL do domínio de um e-mail.
-- MAGIC --
-- MAGIC -- Exemplo:
-- MAGIC --
-- MAGIC -- Entrada:
-- MAGIC --     thomas@gmail.com
-- MAGIC --
-- MAGIC -- Saída:
-- MAGIC --     https://www.gmail.com
-- MAGIC --
-- MAGIC -- Entrada:
-- MAGIC --     maria@yahoo.com
-- MAGIC --
-- MAGIC -- Saída:
-- MAGIC --     https://www.yahoo.com
-- MAGIC --
-- MAGIC -- Funções utilizadas:
-- MAGIC --
-- MAGIC -- split()
-- MAGIC -- concat()
-- MAGIC

-- COMMAND ----------

CREATE OR REPLACE FUNCTION get_url(email STRING)
RETURNS STRING

RETURN concat(
    'https://www.',
    split(email,'@')[1]
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## EXEMPLO 1
-- MAGIC
-- MAGIC
-- MAGIC SELECT get_url('thomas@gmail.com');
-- MAGIC
-- MAGIC -- Resultado esperado:
-- MAGIC --
-- MAGIC -- https://www.gmail.com
-- MAGIC

-- COMMAND ----------

SELECT get_url('thomas@gmail.com');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ###- EXEMPLO 2
-- MAGIC
-- MAGIC
-- MAGIC SELECT get_url('reginaldo@empresa.com');
-- MAGIC
-- MAGIC -- Resultado esperado:
-- MAGIC --
-- MAGIC -- https://www.empresa.com

-- COMMAND ----------

SELECT get_url('reginaldo@empresa.com');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## EXEMPLO 3
-- MAGIC ## UTILIZANDO A TABELA CUSTOMERS
-- MAGIC
-- MAGIC

-- COMMAND ----------

SELECT
customer_id,
email,
get_url(email) AS website
FROM customers_lab;
