-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 12 - Streaming

-- COMMAND ----------
%md
# 📖 Introdução

O Delta Lake oferece suporte ao processamento contínuo de dados utilizando Structured Streaming.

Neste notebook simularemos a chegada contínua de novos pedidos para a livraria.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Entender o conceito de Structured Streaming
- Ler dados continuamente
- Escrever dados em tabelas Delta
- Monitorar uma consulta de streaming

-- COMMAND ----------
%md
# 🧠 Conceito

Streaming é o processamento de dados à medida que eles chegam.

Neste laboratório utilizaremos:

- Source Delta Table
- Stream Reader
- Stream Writer
- Checkpoint
- Target Delta Table

Fluxo:

orders_updates → Streaming → orders_stream

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```python
spark.readStream.table("orders_updates")

.writeStream

.toTable("orders_stream")
```

-- COMMAND ----------
%md
# 💡 Exemplo 1

Criando a tabela destino.

-- COMMAND ----------
CREATE TABLE IF NOT EXISTS orders_stream
LIKE orders;

-- COMMAND ----------
%md
# ▶️ Execução

Leitura contínua da tabela orders_updates.

-- COMMAND ----------
from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()

(
    spark.readStream
         .table("orders_updates")
         .writeStream
         .outputMode("append")
         .option(
             "checkpointLocation",
             "/tmp/bookstore_lab/checkpoints/orders_stream"
         )
         .trigger(availableNow=True)
         .toTable("orders_stream")
)

-- COMMAND ----------
%md
# 🧪 Exercício 1

Execute o streaming.

Confirme que os registros foram copiados para a tabela orders_stream.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT *
FROM orders_stream
ORDER BY order_id;

-- COMMAND ----------
%md
# 💡 Exemplo 2

Contando os registros carregados.

-- COMMAND ----------
SELECT
    COUNT(*) AS total_orders
FROM orders_stream;

-- COMMAND ----------
%md
# 💡 Exemplo 3

Comparando origem e destino.

-- COMMAND ----------
SELECT
    (SELECT COUNT(*) FROM orders_updates) AS source_rows,
    (SELECT COUNT(*) FROM orders_stream) AS target_rows;

-- COMMAND ----------
%md
# 🧪 Exercício 2

Adicione um novo pedido na tabela orders_updates.

Execute novamente o streaming.

Verifique se o novo pedido foi carregado.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    order_id,
    customer_id,
    status,
    total_amount
FROM orders_stream
ORDER BY order_timestamp DESC;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos:

- Structured Streaming
- readStream()
- writeStream()
- outputMode()
- checkpointLocation
- trigger()
- toTable()

-- COMMAND ----------
%md
# 🚀 Desafio

Crie um segundo fluxo de streaming para carregar apenas pedidos com status 'NEW' em uma nova tabela chamada:

orders_stream_new

Utilize um checkpoint diferente e valide o resultado.
