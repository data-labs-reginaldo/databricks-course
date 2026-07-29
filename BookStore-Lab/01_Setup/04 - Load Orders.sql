-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 04 - Load Orders

-- COMMAND ----------
%md
# 📖 Introdução

Neste notebook realizaremos a carga inicial da tabela **orders**, responsável por armazenar os pedidos realizados pelos clientes.

Cada pedido possui informações gerais e uma coleção de livros representada por um campo `ARRAY<STRUCT>`.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Inserir pedidos na tabela Delta
- Trabalhar com estruturas complexas (`ARRAY<STRUCT>`)
- Validar a carga realizada
- Explorar os pedidos utilizando SQL

-- COMMAND ----------
%md
# 🧠 Conceito

A tabela **orders** representa as compras realizadas pelos clientes.

Cada registro contém informações do pedido e um array com todos os livros adquiridos, permitindo armazenar múltiplos itens em uma única linha.

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
INSERT INTO orders
VALUES (...);
```

-- COMMAND ----------
%md
# 💡 Exemplo 1 - Load Orders

Carga inicial da tabela de pedidos.

-- COMMAND ----------

INSERT INTO orders
VALUES

-- (MANTER EXATAMENTE TODOS OS PEDIDOS DO ARQUIVO ORIGINAL)

;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_orders
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - Pedidos por Status

-- COMMAND ----------

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY status;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - Itens por Pedido

-- COMMAND ----------

SELECT
    order_id,
    total_items,
    total_amount
FROM orders
ORDER BY order_id;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - Explodindo os Itens

-- COMMAND ----------

SELECT
    order_id,
    explode(books) AS book
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 5 - Valor Total Calculado

-- COMMAND ----------

SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(10,2)),
        (acc, x) -> acc + x.subtotal
    ) AS calculated_total
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Execute a carga da tabela orders.
2. Conte a quantidade de pedidos.
3. Liste os pedidos por status.
4. Exploda os itens dos pedidos.
5. Calcule o valor total utilizando `aggregate()`.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status;

SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(10,2)),
        (acc, x) -> acc + x.subtotal
    ) AS total_amount
FROM orders;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos a:

- Carregar pedidos em uma tabela Delta.
- Trabalhar com estruturas `ARRAY<STRUCT>`.
- Validar a carga dos dados.
- Consultar informações dos pedidos.

-- COMMAND ----------
%md
# 🚀 Desafio

Crie um novo pedido contendo dois livros e insira-o na tabela **orders**.

Depois valide:

- Quantidade total de pedidos.
- Quantidade de itens.
- Valor total do pedido.
