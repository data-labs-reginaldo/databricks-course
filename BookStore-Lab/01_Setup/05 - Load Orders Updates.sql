-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 05 - Load Orders Updates

-- COMMAND ----------
%md
# 📖 Introdução

Neste notebook carregaremos a tabela **orders_updates**, utilizada para simular cargas incrementais e alterações em pedidos já existentes.

Esses dados serão utilizados posteriormente no notebook de **MERGE INTO**.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Carregar dados incrementais
- Simular atualizações de pedidos
- Preparar dados para operações de MERGE
- Validar a carga realizada

-- COMMAND ----------
%md
# 🧠 Conceito

Em projetos reais é comum receber apenas novos registros ou alterações.

A tabela **orders_updates** representa esse cenário, servindo como origem para sincronizar a tabela **orders**.

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
INSERT INTO orders_updates
VALUES (...);
```

-- COMMAND ----------
%md
# 💡 Exemplo 1 - Load Orders Updates

Carga da tabela incremental.

-- COMMAND ----------

INSERT INTO orders_updates
VALUES

-- (MANTER EXATAMENTE TODOS OS REGISTROS DO ARQUIVO ORIGINAL)

;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_updates
FROM orders_updates;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - Pedidos Atualizados

-- COMMAND ----------

SELECT
    order_id,
    customer_id,
    status,
    total_items,
    total_amount
FROM orders_updates
ORDER BY order_id;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - Itens dos Pedidos

-- COMMAND ----------

SELECT
    order_id,
    explode(books) AS book
FROM orders_updates;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - Total Calculado

-- COMMAND ----------

SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(10,2)),
        (acc, x) -> acc + x.subtotal
    ) AS calculated_total
FROM orders_updates;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Execute a carga da tabela orders_updates.
2. Conte os registros carregados.
3. Liste os pedidos atualizados.
4. Explore os itens utilizando explode().
5. Calcule o valor total com aggregate().

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------

SELECT COUNT(*) AS total_updates
FROM orders_updates;

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders_updates
GROUP BY status;

SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(10,2)),
        (acc, x) -> acc + x.subtotal
    ) AS total_amount
FROM orders_updates;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos a:

- Carregar dados incrementais.
- Preparar informações para operações MERGE.
- Validar pedidos atualizados.
- Trabalhar com ARRAY<STRUCT> em consultas SQL.

-- COMMAND ----------
%md
# 🚀 Desafio

Adicione um novo registro na tabela **orders_updates** representando uma alteração de um pedido existente.

Depois valide:

- Quantidade total de registros.
- Valor total calculado.
- Dados que serão utilizados no notebook **09 - MERGE INTO**.
