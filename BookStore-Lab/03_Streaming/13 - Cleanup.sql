-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 13 - Cleanup

-- COMMAND ----------
%md
# 📖 Introdução

Durante o desenvolvimento de um projeto é comum criar tabelas, views, funções e objetos temporários para estudo e testes.

Ao final do laboratório é importante realizar a limpeza do ambiente para evitar consumo desnecessário de armazenamento e manter o catálogo organizado.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Remover Views
- Remover Funções
- Remover Tabelas
- Executar manutenção em tabelas Delta
- Excluir o Schema do laboratório

-- COMMAND ----------
%md
# 🧠 Conceito

Boas práticas de encerramento de um projeto:

- Remover objetos temporários
- Eliminar funções não utilizadas
- Limpar tabelas de testes
- Executar manutenção quando necessário
- Excluir ambientes de laboratório

-- COMMAND ----------
USE CATALOG workspace;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

Comandos utilizados neste notebook:

```sql
DROP VIEW
DROP FUNCTION
DROP TABLE
DROP SCHEMA
OPTIMIZE
VACUUM
```

-- COMMAND ----------
%md
# 💡 Exemplo 1

Visualizando os objetos existentes.

-- COMMAND ----------
SHOW TABLES;

-- COMMAND ----------
SHOW VIEWS;

-- COMMAND ----------
SHOW USER FUNCTIONS;

-- COMMAND ----------
%md
# 💡 Exemplo 2

Executando manutenção nas tabelas Delta.

-- COMMAND ----------
OPTIMIZE books;

OPTIMIZE customers;

OPTIMIZE orders;

OPTIMIZE orders_updates;

OPTIMIZE orders_stream;

-- COMMAND ----------
VACUUM books RETAIN 168 HOURS;

VACUUM customers RETAIN 168 HOURS;

VACUUM orders RETAIN 168 HOURS;

VACUUM orders_updates RETAIN 168 HOURS;

VACUUM orders_stream RETAIN 168 HOURS;

-- COMMAND ----------
%md
# ▶️ Execução

Removendo as Views.

-- COMMAND ----------
DROP VIEW IF EXISTS customers_details;

DROP VIEW IF EXISTS order_items;

DROP VIEW IF EXISTS customer_books;

DROP VIEW IF EXISTS orders_exploded;

-- COMMAND ----------
%md
# ▶️ Execução

Removendo as User Defined Functions.

-- COMMAND ----------
DROP FUNCTION IF EXISTS format_book_title;

DROP FUNCTION IF EXISTS calculate_discount;

DROP FUNCTION IF EXISTS get_customer_name;

DROP FUNCTION IF EXISTS get_order_url;

-- COMMAND ----------
%md
# ▶️ Execução

Removendo as tabelas.

-- COMMAND ----------
DROP TABLE IF EXISTS orders_stream;

DROP TABLE IF EXISTS orders_updates;

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS customers;

DROP TABLE IF EXISTS books;

-- COMMAND ----------
%md
# 🧪 Exercício

Confirme que todas as tabelas, views e funções foram removidas.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SHOW TABLES;

SHOW VIEWS;

SHOW USER FUNCTIONS;

-- COMMAND ----------
%md
# 💡 Exemplo Final

Removendo o schema do laboratório.

-- COMMAND ----------
DROP SCHEMA IF EXISTS bookstore_lab CASCADE;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos:

- SHOW TABLES
- SHOW VIEWS
- SHOW USER FUNCTIONS
- OPTIMIZE
- VACUUM
- DROP VIEW
- DROP FUNCTION
- DROP TABLE
- DROP SCHEMA

Esses comandos auxiliam na manutenção e limpeza de ambientes Databricks.

-- COMMAND ----------
%md
# 🚀 Desafio

Crie um novo Schema chamado:

bookstore_lab_v2

Recrie as tabelas principais do laboratório e execute novamente todo o fluxo de carga utilizando os notebooks de 01 a 12.
