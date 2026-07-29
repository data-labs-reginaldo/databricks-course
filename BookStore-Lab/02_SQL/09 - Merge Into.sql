-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 09 - Merge Into

-- COMMAND ----------
%md
# 📖 Introdução

O comando MERGE INTO permite sincronizar dados entre uma tabela de origem e uma tabela de destino, executando INSERT, UPDATE e DELETE em uma única instrução.

-- COMMAND ----------
%md
# 🎯 Objetivo

Neste notebook você aprenderá a:

- Utilizar MERGE INTO
- Atualizar registros existentes
- Inserir novos registros
- Validar o resultado da sincronização

-- COMMAND ----------
%md
# 🧠 Conceito

O MERGE compara uma tabela origem com uma tabela destino utilizando uma chave de negócio.

Quando houver correspondência:
- UPDATE

Quando não houver correspondência:
- INSERT

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
MERGE INTO destino t
USING origem s
ON t.id = s.id
WHEN MATCHED THEN
  UPDATE SET ...
WHEN NOT MATCHED THEN
  INSERT (...);
```

-- COMMAND ----------
%md
# 💡 Exemplo

Visualizando os dados antes do MERGE.

-- COMMAND ----------
SELECT * FROM orders ORDER BY order_id;

-- COMMAND ----------
SELECT * FROM orders_updates ORDER BY order_id;

-- COMMAND ----------
%md
# ▶️ Execução

Sincronizando a tabela **orders** com **orders_updates**.

-- COMMAND ----------
MERGE INTO orders AS tgt
USING orders_updates AS src
ON tgt.order_id = src.order_id

WHEN MATCHED THEN
UPDATE SET
    tgt.customer_id     = src.customer_id,
    tgt.order_timestamp = src.order_timestamp,
    tgt.order_date      = src.order_date,
    tgt.total_items     = src.total_items,
    tgt.total_amount    = src.total_amount,
    tgt.status          = src.status,
    tgt.books           = src.books

WHEN NOT MATCHED THEN
INSERT (
    order_id,
    customer_id,
    order_timestamp,
    order_date,
    total_items,
    total_amount,
    status,
    books
)
VALUES (
    src.order_id,
    src.customer_id,
    src.order_timestamp,
    src.order_date,
    src.total_items,
    src.total_amount,
    src.status,
    src.books
);

-- COMMAND ----------
%md
# 🧪 Exercício

Execute novamente o MERGE e verifique:

- Quantos pedidos existem após a sincronização.
- Quais pedidos foram inseridos.
- Quais pedidos foram atualizados.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT COUNT(*) AS total_orders
FROM orders;

-- COMMAND ----------
SELECT
    order_id,
    customer_id,
    status,
    total_amount
FROM orders
ORDER BY order_id;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos:

- Como utilizar MERGE INTO.
- Como realizar UPSERT.
- Como sincronizar tabelas Delta.

-- COMMAND ----------
%md
# 🚀 Desafio

Crie um novo registro na tabela orders_updates.

Execute novamente o MERGE.

Confirme que o novo pedido foi inserido automaticamente na tabela orders.
