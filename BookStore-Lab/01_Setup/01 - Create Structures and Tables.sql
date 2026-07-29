-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 01 - Create Structures and Tables

-- COMMAND ----------
%md
# 📖 Introdução

Este notebook prepara o ambiente do BookStore Lab.

Serão criados o catálogo de trabalho, o schema e todas as tabelas utilizadas nos demais notebooks do laboratório.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Configurar o ambiente do laboratório
- Criar o schema do projeto
- Criar tabelas Delta
- Validar a estrutura criada

-- COMMAND ----------
%md
# 🧠 Conceito

A estrutura do laboratório é composta por quatro tabelas principais:

- books
- customers
- orders
- orders_updates

Todas as tabelas serão criadas no schema **bookstore_lab**.

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Estrutura

Antes de criar as tabelas, removemos objetos existentes para permitir a reexecução do notebook.

-- COMMAND ----------
DROP TABLE IF EXISTS orders_updates;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS customers;

-- COMMAND ----------
%md
# 💡 Exemplo 1 - Customers

Criação da tabela de clientes.

-- COMMAND ----------
CREATE TABLE customers (
    customer_id STRING,
    email STRING,
    status STRING,
    profile STRING
) USING DELTA;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
DESCRIBE customers;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - Books

Criação da tabela de livros.

-- COMMAND ----------
CREATE TABLE books (
    book_id STRING,
    title STRING,
    author STRING,
    category STRING,
    price DECIMAL(10,2)
) USING DELTA;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
DESCRIBE books;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - Orders

Criação da tabela de pedidos.

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
%md
# ▶️ Execução

-- COMMAND ----------
DESCRIBE orders;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - Orders Updates

Tabela utilizada para simular cargas incrementais.

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
%md
# ▶️ Execução

-- COMMAND ----------
DESCRIBE orders_updates;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Execute todas as células.
2. Confirme que as quatro tabelas foram criadas.
3. Verifique a estrutura de cada tabela.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SHOW TABLES;

DESCRIBE customers;
DESCRIBE books;
DESCRIBE orders;
DESCRIBE orders_updates;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos a:

- Configurar o ambiente
- Criar um schema
- Criar tabelas Delta
- Definir tipos simples e complexos (ARRAY<STRUCT>)
- Validar objetos criados

-- COMMAND ----------
%md
# 🚀 Desafio

Adicione uma nova coluna chamada **created_at TIMESTAMP** à tabela **books** utilizando ALTER TABLE.

Depois utilize DESCRIBE para confirmar a alteração.
