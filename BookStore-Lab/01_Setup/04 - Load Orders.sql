-- Databricks notebook source


-- COMMAND ----------

-- MAGIC %md
-- MAGIC # BookStore Lab
-- MAGIC ## 04 - Load Orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📖 Introdução
-- MAGIC
-- MAGIC Neste notebook realizaremos a carga inicial da tabela **orders**, responsável por armazenar os pedidos realizados pelos clientes.
-- MAGIC
-- MAGIC Cada pedido possui informações gerais e uma coleção de livros representada por um campo `ARRAY<STRUCT>`.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🎯 Objetivo
-- MAGIC
-- MAGIC Ao concluir este notebook você será capaz de:
-- MAGIC
-- MAGIC - Inserir pedidos na tabela Delta
-- MAGIC - Trabalhar com estruturas complexas (`ARRAY<STRUCT>`)
-- MAGIC - Validar a carga realizada
-- MAGIC - Explorar os pedidos utilizando SQL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧠 Conceito
-- MAGIC
-- MAGIC A tabela **orders** representa as compras realizadas pelos clientes.
-- MAGIC
-- MAGIC Cada registro contém informações do pedido e um array com todos os livros adquiridos, permitindo armazenar múltiplos itens em uma única linha.

-- COMMAND ----------

USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📝 Sintaxe
-- MAGIC
-- MAGIC ```sql
-- MAGIC INSERT INTO orders
-- MAGIC VALUES (...);
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 1 - Load Orders
-- MAGIC
-- MAGIC Carga inicial da tabela de pedidos.

-- COMMAND ----------

describe orders


-- COMMAND ----------


INSERT INTO orders
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
    'O0001', 'C001', TIMESTAMP '2024-01-10 09:10:00', DATE '2024-01-10', 2, 129.80, 'DELIVERED',
    array(
        named_struct('book_id','B001','quantity',1,'unit_price',59.90,'discount',0.00,'subtotal',59.90),
        named_struct('book_id','B010','quantity',1,'unit_price',69.90,'discount',0.00,'subtotal',69.90)
    )
),
(
    'O0002', 'C002', TIMESTAMP '2024-01-11 10:15:00', DATE '2024-01-11', 1, 99.90, 'DELIVERED',
    array(
        named_struct('book_id','B005','quantity',1,'unit_price',99.90,'discount',0.00,'subtotal',99.90)
    )
),
(
    'O0003', 'C003', TIMESTAMP '2024-01-12 11:00:00', DATE '2024-01-12', 3, 204.70, 'PROCESSING',
    array(
        named_struct('book_id','B002','quantity',1,'unit_price',69.90,'discount',0.00,'subtotal',69.90),
        named_struct('book_id','B014','quantity',1,'unit_price',65.90,'discount',0.00,'subtotal',65.90),
        named_struct('book_id','B035','quantity',1,'unit_price',68.90,'discount',0.00,'subtotal',68.90)
    )
),
(
    'O0004', 'C004', TIMESTAMP '2024-01-13 08:40:00', DATE '2024-01-13', 2, 171.80, 'SHIPPED',
    array(
        named_struct('book_id','B018','quantity',1,'unit_price',119.90,'discount',10.00,'subtotal',109.90),
        named_struct('book_id','B016','quantity',1,'unit_price',61.90,'discount',0.00,'subtotal',61.90)
    )
),
(
    'O0005', 'C005', TIMESTAMP '2024-01-15 14:00:00', DATE '2024-01-15', 4, 282.60, 'DELIVERED',
    array(
        named_struct('book_id','B020','quantity',1,'unit_price',82.90,'discount',0.00,'subtotal',82.90),
        named_struct('book_id','B021','quantity',1,'unit_price',68.90,'discount',0.00,'subtotal',68.90),
        named_struct('book_id','B022','quantity',1,'unit_price',66.90,'discount',0.00,'subtotal',66.90),
        named_struct('book_id','B037','quantity',1,'unit_price',69.90,'discount',5.00,'subtotal',64.90)
    )
),
(
    'O0006', 'C006', TIMESTAMP '2024-01-16 13:15:00', DATE '2024-01-16', 2, 154.80, 'NEW',
    array(
        named_struct('book_id','B029','quantity',1,'unit_price',86.90,'discount',10.00,'subtotal',76.90),
        named_struct('book_id','B030','quantity',1,'unit_price',77.90,'discount',0.00,'subtotal',77.90)
    )
),
(
    'O0007', 'C007', TIMESTAMP '2024-01-17 09:00:00', DATE '2024-01-17', 2, 163.80, 'PROCESSING',
    array(
        named_struct('book_id','B024','quantity',1,'unit_price',76.90,'discount',0.00,'subtotal',76.90),
        named_struct('book_id','B033','quantity',1,'unit_price',86.90,'discount',0.00,'subtotal',86.90)
    )
),
(
    'O0008', 'C008', TIMESTAMP '2024-01-18 18:20:00', DATE '2024-01-18', 1, 104.90, 'DELIVERED',
    array(
        named_struct('book_id','B039','quantity',1,'unit_price',104.90,'discount',0.00,'subtotal',104.90)
    )
),
(
    'O0009', 'C009', TIMESTAMP '2024-01-19 12:30:00', DATE '2024-01-19', 2, 147.80, 'CANCELLED',
    array(
        named_struct('book_id','B026','quantity',1,'unit_price',72.90,'discount',0.00,'subtotal',72.90),
        named_struct('book_id','B027','quantity',1,'unit_price',74.90,'discount',0.00,'subtotal',74.90)
    )
),
(
    'O0010', 'C010', TIMESTAMP '2024-01-20 08:45:00', DATE '2024-01-20', 3, 239.70, 'SHIPPED',
    array(
        named_struct('book_id','B004','quantity',1,'unit_price',89.90,'discount',0.00,'subtotal',89.90),
        named_struct('book_id','B006','quantity',1,'unit_price',92.50,'discount',0.00,'subtotal',92.50),
        named_struct('book_id','B011','quantity',1,'unit_price',57.30,'discount',0.00,'subtotal',57.30)
    )
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_orders
FROM orders;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 2 - Pedidos por Status

-- COMMAND ----------

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY status;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 3 - Itens por Pedido

-- COMMAND ----------

SELECT
    order_id,
    total_items,
    total_amount
FROM orders
ORDER BY order_id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 4 - Explodindo os Itens

-- COMMAND ----------

SELECT
    order_id,
    explode(books) AS book
FROM orders;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 5 - Valor Total Calculado

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

-- MAGIC %md
-- MAGIC # 🧪 Exercícios
-- MAGIC
-- MAGIC 1. Execute a carga da tabela orders.
-- MAGIC 2. Conte a quantidade de pedidos.
-- MAGIC 3. Liste os pedidos por status.
-- MAGIC 4. Exploda os itens dos pedidos.
-- MAGIC 5. Calcule o valor total utilizando `aggregate()`.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

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
        CAST(0 AS DECIMAL(18,2)),
        (acc, x) -> acc + x.subtotal
    ) AS total_amount
FROM orders;

-- COMMAND ----------

SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(10,2)),
        (acc, x) -> CAST(acc + x.subtotal AS DECIMAL(10,2))
    ) AS total_amount
FROM orders;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📌 Resumo
-- MAGIC
-- MAGIC Neste notebook aprendemos a:
-- MAGIC
-- MAGIC - Carregar pedidos em uma tabela Delta.
-- MAGIC - Trabalhar com estruturas `ARRAY<STRUCT>`.
-- MAGIC - Validar a carga dos dados.
-- MAGIC - Consultar informações dos pedidos.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio
-- MAGIC
-- MAGIC Crie um novo pedido contendo dois livros e insira-o na tabela **orders**.
-- MAGIC
-- MAGIC Depois valide:
-- MAGIC
-- MAGIC - Quantidade total de pedidos.
-- MAGIC - Quantidade de itens.
-- MAGIC - Valor total do pedido.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio - Novo Pedido
-- MAGIC
-- MAGIC Crie um novo pedido contendo dois livros e insira-o na tabela `orders`.

-- COMMAND ----------


INSERT INTO orders
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
    'O0011',
    'C001',
    TIMESTAMP '2024-02-01 09:20:00',
    DATE '2024-02-01',
    2,
    149.80,
    'NEW',
    array(
        named_struct('book_id','B003','quantity',1,'unit_price',72.90,'discount',0.00,'subtotal',72.90),
        named_struct('book_id','B013','quantity',1,'unit_price',76.90,'discount',0.00,'subtotal',76.90)
    )
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Validação do Novo Pedido

-- COMMAND ----------

SELECT
    order_id,
    customer_id,
    total_items,
    total_amount,
    status,
    books
FROM orders
WHERE order_id = 'O0011';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📊 Quantidade Total de Pedidos

-- COMMAND ----------


SELECT COUNT(*) AS total_orders
FROM orders;
