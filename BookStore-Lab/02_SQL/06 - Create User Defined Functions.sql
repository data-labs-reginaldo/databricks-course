-- Databricks notebook source


-- COMMAND ----------

-- MAGIC %md
-- MAGIC # BookStore Lab
-- MAGIC ## 06 - Create User Defined Functions
-- MAGIC
-- MAGIC Este notebook apresenta o conceito de SQL User Defined Functions (UDFs) no Databricks.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📖 Introdução
-- MAGIC
-- MAGIC Uma SQL User Defined Function (UDF) permite encapsular regras de negócio em uma função reutilizável, tornando o código mais limpo, legível e fácil de manter.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🎯 Objetivo
-- MAGIC
-- MAGIC Ao concluir este notebook você será capaz de:
-- MAGIC
-- MAGIC - Entender o que é uma SQL UDF
-- MAGIC - Criar funções parametrizadas
-- MAGIC - Reutilizar regras de negócio
-- MAGIC - Aplicar funções em consultas SQL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧠 Conceito
-- MAGIC
-- MAGIC O Databricks possui diversas funções nativas, como:
-- MAGIC
-- MAGIC - UPPER()
-- MAGIC - LOWER()
-- MAGIC - CONCAT()
-- MAGIC - COALESCE()
-- MAGIC
-- MAGIC Quando uma regra é utilizada repetidamente, é recomendável encapsulá-la em uma User Defined Function.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📝 Sintaxe
-- MAGIC
-- MAGIC ```sql
-- MAGIC CREATE OR REPLACE FUNCTION nome_funcao(parametro TIPO)
-- MAGIC RETURNS TIPO
-- MAGIC RETURN expressao;
-- MAGIC ```

-- COMMAND ----------

USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 1 - format_book_title()
-- MAGIC
-- MAGIC Padroniza o título de um livro.

-- COMMAND ----------

CREATE OR REPLACE FUNCTION format_book_title(title STRING)
RETURNS STRING
RETURN upper(trim(title));

-- COMMAND ----------

select * from workspace.bookstore_lab.books

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT
    title,
    format_book_title(title) AS formatted_title
FROM books;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercício 1
-- MAGIC
-- MAGIC Liste:
-- MAGIC
-- MAGIC - Título original
-- MAGIC - Título formatado
-- MAGIC - Categoria

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

-- COMMAND ----------

SELECT
    title,
    format_book_title(title) AS formatted_title,
    category
FROM books;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 2 - calculate_discount()
-- MAGIC
-- MAGIC Calcula o preço final após um desconto percentual.

-- COMMAND ----------

CREATE OR REPLACE FUNCTION calculate_discount(
    price DECIMAL(10,2),
    discount DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
RETURN price - (price * discount / 100);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT
    title,
    price,
    calculate_discount(price,10) AS final_price
FROM books;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercício 2
-- MAGIC
-- MAGIC Mostre:
-- MAGIC
-- MAGIC - Livro
-- MAGIC - Preço original
-- MAGIC - Preço com 15%
-- MAGIC - Preço com 20%

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

-- COMMAND ----------

SELECT
    title,
    price,
    calculate_discount(price,15) AS price_15,
    calculate_discount(price,20) AS price_20
FROM books;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 3 - get_customer_name()
-- MAGIC
-- MAGIC Concatena nome e sobrenome do cliente.

-- COMMAND ----------

CREATE OR REPLACE FUNCTION get_customer_name(profile STRING)
RETURNS STRING
RETURN concat(
    profile:first_name,
    ' ',
    profile:last_name
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT
    customer_id,
    get_customer_name(profile) AS customer_name
FROM customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercício 3
-- MAGIC
-- MAGIC Mostrar:
-- MAGIC
-- MAGIC - Cliente
-- MAGIC - Nome
-- MAGIC - Cidade
-- MAGIC - País

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

-- COMMAND ----------

SELECT
    customer_id,
    get_customer_name(profile) AS customer_name,
    profile:address:city AS city,
    profile:address:country AS country
FROM customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 4 - get_order_url()
-- MAGIC
-- MAGIC Gera uma URL para consulta do pedido.

-- COMMAND ----------

CREATE OR REPLACE FUNCTION get_order_url(order_id STRING)
RETURNS STRING
RETURN concat(
    'https://bookstore.demo/orders/',
    order_id
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT
    order_id,
    get_order_url(order_id) AS order_url
FROM orders;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercício 4
-- MAGIC
-- MAGIC Mostrar:
-- MAGIC
-- MAGIC - Pedido
-- MAGIC - Cliente
-- MAGIC - URL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

-- COMMAND ----------

SELECT
    order_id,
    customer_id,
    get_order_url(order_id) AS order_url
FROM orders;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📌 Resumo
-- MAGIC
-- MAGIC Neste notebook aprendemos:
-- MAGIC
-- MAGIC - O que é uma SQL UDF
-- MAGIC - Como criar funções
-- MAGIC - Como utilizar parâmetros
-- MAGIC - Como reutilizar lógica de negócio

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio
-- MAGIC
-- MAGIC Crie uma função chamada:
-- MAGIC
-- MAGIC book_label(title, category)
-- MAGIC
-- MAGIC Formato esperado:
-- MAGIC
-- MAGIC Learning Spark (Spark)
-- MAGIC
-- MAGIC Utilize essa função para listar todos os livros da tabela books.

-- COMMAND ----------

select * from workspace.bookstore_lab.books

-- COMMAND ----------

select * from workspace.default.books

-- COMMAND ----------

SHOW TABLES DROPPED IN workspace.default;


-- COMMAND ----------

Select 'orders_updates' as tables, count(*) from workspace.default.orders_updates union all
Select 'orders'         as tables, count(*) from workspace.default.orders union all
Select 'books'          as tables, count(*) from workspace.default.books union all
Select 'customers'      as tables, count(*) from workspace.default.customers;

-- COMMAND ----------

Select 'orders_updates' as tables, count(*) from workspace.bookstore_lab.orders_updates union all
Select 'orders'         as tables, count(*) from workspace.bookstore_lab.orders union all
Select 'books'          as tables, count(*) from workspace.bookstore_lab.books union all
Select 'customers'      as tables, count(*) from workspace.bookstore_lab.customers;

-- COMMAND ----------

SHOW TABLES DROPPED IN workspace.default;

-- COMMAND ----------

ALTER TABLE workspace.default.customers
RENAME TO workspace.default.customers_nova;

-- COMMAND ----------

UNDROP TABLE WITH ID 'c9c287c3-df12-4cdd-8724-a49e4769dada'

-- COMMAND ----------

select count(*) from workspace.default.customers

-- COMMAND ----------

SHOW TABLES DROPPED IN workspace.default;


-- COMMAND ----------

DESCRIBE HISTORY workspace.default.customers;


-- COMMAND ----------

DESCRIBE HISTORY workspace.default.books;

-- COMMAND ----------

SELECT
    version,
    timestamp,
    operation,
    operationParameters
FROM (
    DESCRIBE HISTORY workspace.default.books
)
ORDER BY version;

-- COMMAND ----------

SELECT count(*)
FROM workspace.default.books VERSION AS OF 2 union all
SELECT count(*)
FROM workspace.default.books VERSION AS OF 3 

-- COMMAND ----------

SELECT *
FROM workspace.default.books VERSION AS OF 3

EXCEPT

SELECT *
FROM workspace.default.books VERSION AS OF 2;

-- COMMAND ----------

import os

import requests
import pandas as pd

def download_dataset(source, target):
    files = dbutils.fs.ls(source)

    for f in files:
        source_path = f"{source}/{f.name}"
        target_path = f"{target}/{f.name}"
        if not path_exists(target_path):
            print(f"Copying {f.name} ...")
            dbutils.fs.cp(source_path, target_path, True)


data_source_uri = "wasbs://course-resources@dalhussein.blob.core.windows.net/datasets/bookstore/v1/"
dataset_bookstore = 'dbfs:/mnt/demo-datasets/bookstore'
spark.conf.set(f"dataset.bookstore", dataset_bookstore)

download_dataset(data_source_uri, dataset_bookstore)

-- COMMAND ----------



