-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 07 - Create Views

-- COMMAND ----------
%md
# 📖 Introdução

Views são consultas salvas que simplificam o acesso aos dados e promovem reutilização de lógica SQL. Neste notebook criaremos views que facilitarão as análises realizadas nos próximos laboratórios.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Criar Views no Databricks
- Reutilizar consultas SQL
- Simplificar consultas complexas
- Preparar objetos para análises posteriores

-- COMMAND ----------
%md
# 🧠 Conceito

Uma View é uma consulta armazenada que não duplica os dados da tabela original.

Neste laboratório serão criadas as seguintes Views:

- customers_details
- order_items
- customer_books
- orders_exploded

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
CREATE OR REPLACE VIEW nome_view AS
SELECT ...
```

-- COMMAND ----------
%md
# 💡 Exemplo 1 - customers_details

Extrai informações do perfil do cliente.

-- COMMAND ----------
CREATE OR REPLACE VIEW customers_details AS
SELECT
    customer_id,
    email,
    status,
    profile:first_name AS first_name,
    profile:last_name AS last_name,
    profile:gender AS gender,
    profile:birth_date AS birth_date,
    profile:address:city AS city,
    profile:address:state AS state,
    profile:address:country AS country
FROM customers;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT * FROM customers_details;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - order_items

Transforma o ARRAY<STRUCT> da coluna books em linhas.

-- COMMAND ----------
CREATE OR REPLACE VIEW order_items AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_timestamp,
    o.status,
    b.book_id,
    b.quantity,
    b.unit_price,
    b.discount,
    b.subtotal
FROM orders o
LATERAL VIEW explode(o.books) t AS b;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT * FROM order_items;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - customer_books

Relaciona clientes, pedidos e livros.

-- COMMAND ----------
CREATE OR REPLACE VIEW customer_books AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    i.book_id,
    bk.title,
    bk.category,
    i.quantity,
    i.subtotal
FROM customers_details c
JOIN orders o
  ON c.customer_id=o.customer_id
JOIN order_items i
  ON o.order_id=i.order_id
JOIN books bk
  ON i.book_id=bk.book_id;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT * FROM customer_books;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - orders_exploded

Explode o array de livros.

-- COMMAND ----------
CREATE OR REPLACE VIEW orders_exploded AS
SELECT
    order_id,
    customer_id,
    explode(books) AS item
FROM orders;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT * FROM orders_exploded;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Consulte customers_details.
2. Consulte order_items.
3. Consulte customer_books.
4. Consulte orders_exploded.
5. Conte a quantidade de linhas de cada View.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT COUNT(*) AS customers_details_rows FROM customers_details;

SELECT COUNT(*) AS order_items_rows FROM order_items;

SELECT COUNT(*) AS customer_books_rows FROM customer_books;

SELECT COUNT(*) AS orders_exploded_rows FROM orders_exploded;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos:

- CREATE OR REPLACE VIEW
- LATERAL VIEW
- explode()
- Reutilização de consultas
- Organização da camada lógica

-- COMMAND ----------
%md
# 🚀 Desafio

Crie uma nova View chamada customer_order_summary contendo:

- customer_id
- nome do cliente
- quantidade de pedidos
- valor total comprado

Utilize apenas as tabelas e Views criadas durante o laboratório.
