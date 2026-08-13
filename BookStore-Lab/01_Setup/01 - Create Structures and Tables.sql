-- Databricks notebook source
select * from workspace.bookstore_lab.books

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # BookStore Lab
-- MAGIC ## 01 - Create Structures and Tables

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📖 Introdução
-- MAGIC
-- MAGIC Este notebook prepara o ambiente do BookStore Lab.
-- MAGIC
-- MAGIC Serão criados o catálogo de trabalho, o schema e todas as tabelas utilizadas nos demais notebooks do laboratório.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🎯 Objetivo
-- MAGIC
-- MAGIC Ao concluir este notebook você será capaz de:
-- MAGIC
-- MAGIC - Configurar o ambiente do laboratório
-- MAGIC - Criar o schema do projeto
-- MAGIC - Criar tabelas Delta
-- MAGIC - Validar a estrutura criada

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧠 Conceito
-- MAGIC
-- MAGIC A estrutura do laboratório é composta por quatro tabelas principais:
-- MAGIC
-- MAGIC - books
-- MAGIC - customers
-- MAGIC - orders
-- MAGIC - orders_updates
-- MAGIC
-- MAGIC Todas as tabelas serão criadas no schema **bookstore_lab**.

-- COMMAND ----------

USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📝 Estrutura
-- MAGIC
-- MAGIC Antes de criar as tabelas, removemos objetos existentes para permitir a reexecução do notebook.

-- COMMAND ----------

DROP TABLE IF EXISTS orders_updates;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS customers;

-- COMMAND ----------

DROP TABLE IF EXISTS customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 1 - Customers
-- MAGIC
-- MAGIC Criação da tabela de clientes.

-- COMMAND ----------

CREATE TABLE customers (
    customer_id STRING,
    email STRING,
    created TIMESTAMP,
    updated TIMESTAMP,
    status STRING,
    profile STRING
) USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

DESCRIBE customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 2 - Books
-- MAGIC
-- MAGIC Criação da tabela de livros.

-- COMMAND ----------

CREATE TABLE books (
    book_id STRING,
    title STRING,
    author STRING,
    category STRING,
    price DECIMAL(10,2)
) USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

DESCRIBE books;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 3 - Orders
-- MAGIC
-- MAGIC Criação da tabela de pedidos.

-- COMMAND ----------

CREATE TABLE orders (
    order_id STRING,
    customer_id STRING,
    order_timestamp TIMESTAMP,
    order_date DATE,
    total_items INT,
    total_amount DECIMAL(10,2),
    status STRING,
    books ARRAY<
        STRUCT<
            book_id:STRING,
            quantity:INT,
            unit_price:DECIMAL(10,2),
            discount:DECIMAL(10,2),
            subtotal:DECIMAL(10,2)
        >
    >
) USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

DESCRIBE orders;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 4 - Orders Updates
-- MAGIC
-- MAGIC Tabela utilizada para simular cargas incrementais.

-- COMMAND ----------

CREATE TABLE orders_updates (
    order_id STRING,
    customer_id STRING,
    order_timestamp TIMESTAMP,
    order_date DATE,
    total_items INT,
    total_amount DECIMAL(10,2),
    status STRING,
    books ARRAY<
        STRUCT<
            book_id:STRING,
            quantity:INT,
            unit_price:DECIMAL(10,2),
            discount:DECIMAL(10,2),
            subtotal:DECIMAL(10,2)
        >
    >
) USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

DESCRIBE orders_updates;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercícios
-- MAGIC
-- MAGIC 1. Execute todas as células.
-- MAGIC 2. Confirme que as quatro tabelas foram criadas.
-- MAGIC 3. Verifique a estrutura de cada tabela.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

-- COMMAND ----------

SHOW TABLES;

DESCRIBE customers;
DESCRIBE books;
DESCRIBE orders;
DESCRIBE orders_updates;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📌 Resumo
-- MAGIC
-- MAGIC Neste notebook aprendemos a:
-- MAGIC
-- MAGIC - Configurar o ambiente
-- MAGIC - Criar um schema
-- MAGIC - Criar tabelas Delta
-- MAGIC - Definir tipos simples e complexos (ARRAY<STRUCT>)
-- MAGIC - Validar objetos criados

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio
-- MAGIC
-- MAGIC Adicione uma nova coluna chamada **created_at TIMESTAMP** à tabela **books** utilizando ALTER TABLE.
-- MAGIC
-- MAGIC Depois utilize DESCRIBE para confirmar a alteração.
