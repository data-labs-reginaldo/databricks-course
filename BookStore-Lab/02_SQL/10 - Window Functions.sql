-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 10 - Window Functions

-- COMMAND ----------
%md
# 📖 Introdução

As Window Functions permitem realizar cálculos sobre um conjunto de linhas relacionadas sem perder o nível de detalhe dos registros.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Utilizar OVER()
- Aplicar PARTITION BY
- Ordenar resultados com ORDER BY
- Utilizar as principais Window Functions do Databricks SQL

-- COMMAND ----------
%md
# 🧠 Conceito

As Window Functions calculam valores considerando uma janela de registros.

Principais funções:

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- FIRST_VALUE()
- LAST_VALUE()
- SUM()
- AVG()

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
FUNCTION() OVER (
    PARTITION BY coluna
    ORDER BY coluna
)
```

-- COMMAND ----------
%md
# 💡 Exemplo 1 - ROW_NUMBER()

Numera os pedidos de cada cliente.

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS row_number
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercício 1

Liste o número sequencial de pedidos por cliente.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_timestamp
    ) AS sequence
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - RANK()

Classifique os pedidos pelo maior valor.

-- COMMAND ----------
SELECT
    order_id,
    total_amount,
    RANK() OVER(
        ORDER BY total_amount DESC
    ) AS ranking
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercício 2

Mostre os três maiores pedidos.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT *
FROM (
    SELECT
        order_id,
        total_amount,
        RANK() OVER(
            ORDER BY total_amount DESC
        ) AS ranking
    FROM orders
)
WHERE ranking <= 3;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - DENSE_RANK()

-- COMMAND ----------
SELECT
    order_id,
    total_amount,
    DENSE_RANK() OVER(
        ORDER BY total_amount DESC
    ) AS dense_rank
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - LAG()

Valor do pedido anterior.

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    total_amount,
    LAG(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 5 - LEAD()

Próximo pedido.

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    total_amount,
    LEAD(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 6 - FIRST_VALUE()

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    FIRST_VALUE(order_id) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS first_order
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 7 - LAST_VALUE()

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    LAST_VALUE(order_id)
    OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_order
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 8 - SUM()

Total acumulado por cliente.

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    total_amount,
    SUM(total_amount)
    OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_total
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 9 - AVG()

Média dos pedidos.

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    total_amount,
    AVG(total_amount)
    OVER(
        PARTITION BY customer_id
    ) AS average_order
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Liste o primeiro pedido de cada cliente.

2. Liste o último pedido de cada cliente.

3. Calcule o total acumulado.

4. Calcule a média dos pedidos.

5. Classifique todos os pedidos pelo maior valor.

-- COMMAND ----------
%md
# ✅ Soluções

-- COMMAND ----------
SELECT
    customer_id,
    order_id,
    FIRST_VALUE(order_id)
    OVER(PARTITION BY customer_id ORDER BY order_date) AS first_order,
    LAST_VALUE(order_id)
    OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_order,
    SUM(total_amount)
    OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_total,
    AVG(total_amount)
    OVER(PARTITION BY customer_id) AS average_order,
    RANK()
    OVER(ORDER BY total_amount DESC) AS ranking
FROM orders;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos:

- OVER()
- PARTITION BY
- ORDER BY
- ROW_NUMBER
- RANK
- DENSE_RANK
- LAG
- LEAD
- FIRST_VALUE
- LAST_VALUE
- SUM OVER
- AVG OVER

-- COMMAND ----------
%md
# 🚀 Desafio

Utilizando apenas Window Functions, identifique:

- O maior pedido de cada cliente.
- O menor pedido de cada cliente.
- A diferença entre um pedido e o anterior.
- O ranking geral dos pedidos.
