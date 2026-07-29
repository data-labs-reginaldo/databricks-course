-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## Criação do Ambiente

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS default;

USE SCHEMA default;

-- COMMAND ----------
%md
## Limpeza do Ambiente

-- COMMAND ----------
DROP VIEW IF EXISTS customers_details;
DROP VIEW IF EXISTS orders_exploded;
DROP VIEW IF EXISTS customer_books;
DROP VIEW IF EXISTS order_items;

DROP TABLE IF EXISTS orders_updates;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS customers;

-- COMMAND ----------
%md
## Criação da Tabela Customers

-- COMMAND ----------
CREATE TABLE customers
(
    ...
)
USING DELTA;

-- COMMAND ----------
%md
## Criação da Tabela Books

-- COMMAND ----------
CREATE TABLE books
(
    ...
)
USING DELTA;

-- COMMAND ----------
%md
## Criação da Tabela Orders

-- COMMAND ----------
CREATE TABLE orders
(
    ...
)
USING DELTA;

-- COMMAND ----------
%md
## Criação da Tabela Orders Updates

-- COMMAND ----------
CREATE TABLE orders_updates
(
    ...
)
USING DELTA;

-- COMMAND ----------
%md
## Carga da Tabela Books

-- COMMAND ----------
INSERT INTO books
...

-- COMMAND ----------
%md
## Carga da Tabela Customers

-- COMMAND ----------
INSERT INTO customers
...

-- COMMAND ----------
%md
## Carga da Tabela Orders

-- COMMAND ----------
INSERT INTO orders
...

-- COMMAND ----------
%md
## Carga da Tabela Orders Updates

-- COMMAND ----------
INSERT INTO orders_updates
...

-- COMMAND ----------
%md
## User Defined Function

-- COMMAND ----------
CREATE OR REPLACE FUNCTION get_url...

-- COMMAND ----------
%md
## Views

-- COMMAND ----------
CREATE VIEW ...

-- COMMAND ----------
%md
## Validações

-- COMMAND ----------
SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM books;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM orders_updates;
