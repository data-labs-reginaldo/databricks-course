-- Databricks notebook source


-- COMMAND ----------

-- MAGIC %md
-- MAGIC # BookStore Lab
-- MAGIC ## 05 - Load Orders Updates

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📖 Introdução
-- MAGIC
-- MAGIC Neste notebook carregaremos a tabela **orders_updates**, utilizada para simular cargas incrementais e alterações em pedidos já existentes.
-- MAGIC
-- MAGIC Esses dados serão utilizados posteriormente no notebook de **MERGE INTO**.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🎯 Objetivo
-- MAGIC
-- MAGIC Ao concluir este notebook você será capaz de:
-- MAGIC
-- MAGIC - Carregar dados incrementais
-- MAGIC - Simular atualizações de pedidos
-- MAGIC - Preparar dados para operações de MERGE
-- MAGIC - Validar a carga realizada

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧠 Conceito
-- MAGIC
-- MAGIC Em projetos reais é comum receber apenas novos registros ou alterações.
-- MAGIC
-- MAGIC A tabela **orders_updates** representa esse cenário, servindo como origem para sincronizar a tabela **orders**.

-- COMMAND ----------

USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📝 Sintaxe
-- MAGIC
-- MAGIC ```sql
-- MAGIC INSERT INTO orders_updates
-- MAGIC VALUES (...);
-- MAGIC ```

-- COMMAND ----------

describe orders_updates

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 1 - Load Orders Updates
-- MAGIC
-- MAGIC Carga da tabela incremental.

-- COMMAND ----------


INSERT INTO orders_updates
(
    order_id,
    customer_id,
    order_timestamp,
    order_date,
    total_items,
    total_amount,
    status,
    books
)
VALUES
(
    'O0001',
    'C001',
    TIMESTAMP '2024-01-10 09:10:00',
    DATE '2024-01-10',
    2,
    129.80,
    'SHIPPED',
    array(
        named_struct(
            'book_id', 'B001',
            'quantity', 1,
            'unit_price', 59.90,
            'discount', 0.00,
            'subtotal', 59.90
        ),
        named_struct(
            'book_id', 'B010',
            'quantity', 1,
            'unit_price', 69.90,
            'discount', 0.00,
            'subtotal', 69.90
        )
    )
),
(
    'O0003',
    'C003',
    TIMESTAMP '2024-01-12 11:00:00',
    DATE '2024-01-12',
    3,
    204.70,
    'DELIVERED',
    array(
        named_struct(
            'book_id', 'B002',
            'quantity', 1,
            'unit_price', 69.90,
            'discount', 0.00,
            'subtotal', 69.90
        ),
        named_struct(
            'book_id', 'B014',
            'quantity', 1,
            'unit_price', 65.90,
            'discount', 0.00,
            'subtotal', 65.90
        ),
        named_struct(
            'book_id', 'B035',
            'quantity', 1,
            'unit_price', 68.90,
            'discount', 0.00,
            'subtotal', 68.90
        )
    )
),
(
    'O0004',
    'C004',
    TIMESTAMP '2024-01-13 08:40:00',
    DATE '2024-01-13',
    2,
    171.80,
    'DELIVERED',
    array(
        named_struct(
            'book_id', 'B018',
            'quantity', 1,
            'unit_price', 119.90,
            'discount', 10.00,
            'subtotal', 109.90
        ),
        named_struct(
            'book_id', 'B016',
            'quantity', 1,
            'unit_price', 61.90,
            'discount', 0.00,
            'subtotal', 61.90
        )
    )
),
(
    'O0006',
    'C006',
    TIMESTAMP '2024-01-16 13:15:00',
    DATE '2024-01-16',
    2,
    154.80,
    'PROCESSING',
    array(
        named_struct(
            'book_id', 'B029',
            'quantity', 1,
            'unit_price', 86.90,
            'discount', 10.00,
            'subtotal', 76.90
        ),
        named_struct(
            'book_id', 'B030',
            'quantity', 1,
            'unit_price', 77.90,
            'discount', 0.00,
            'subtotal', 77.90
        )
    )
),
(
    'O0009',
    'C009',
    TIMESTAMP '2024-01-19 12:30:00',
    DATE '2024-01-19',
    2,
    147.80,
    'DELIVERED',
    array(
        named_struct(
            'book_id', 'B026',
            'quantity', 1,
            'unit_price', 72.90,
            'discount', 0.00,
            'subtotal', 72.90
        ),
        named_struct(
            'book_id', 'B027',
            'quantity', 1,
            'unit_price', 74.90,
            'discount', 0.00,
            'subtotal', 74.90
        )
    )
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_updates
FROM orders_updates;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 2 - Pedidos Atualizados

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

-- MAGIC %md
-- MAGIC # 💡 Exemplo 3 - Itens dos Pedidos

-- COMMAND ----------

SELECT
    order_id,
    explode(books) AS book
FROM orders_updates;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 4 - Total Calculado

-- COMMAND ----------

SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(10,2)),
        (acc, x) -> CAST(acc + x.subtotal AS DECIMAL(10,2))
    ) AS calculated_total
FROM orders_updates;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercícios
-- MAGIC
-- MAGIC 1. Execute a carga da tabela orders_updates.
-- MAGIC 2. Conte os registros carregados.
-- MAGIC 3. Liste os pedidos atualizados.
-- MAGIC 4. Explore os itens utilizando explode().
-- MAGIC 5. Calcule o valor total com aggregate().

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

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
        (acc, x) -> CAST(acc + x.subtotal AS DECIMAL(10,2))
    ) AS total_amount
FROM orders_updates;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📌 Resumo
-- MAGIC
-- MAGIC Neste notebook aprendemos a:
-- MAGIC
-- MAGIC - Carregar dados incrementais.
-- MAGIC - Preparar informações para operações MERGE.
-- MAGIC - Validar pedidos atualizados.
-- MAGIC - Trabalhar com ARRAY<STRUCT> em consultas SQL.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio
-- MAGIC
-- MAGIC Adicione um novo registro na tabela **orders_updates** representando uma alteração de um pedido existente.
-- MAGIC
-- MAGIC Depois valide:
-- MAGIC
-- MAGIC - Quantidade total de registros.
-- MAGIC - Valor total calculado.
-- MAGIC - Dados que serão utilizados no notebook **09 - MERGE INTO**.
