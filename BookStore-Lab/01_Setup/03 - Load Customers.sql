-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 03 - Load Customers

-- COMMAND ----------
%md
# 📖 Introdução

Neste notebook realizaremos a carga inicial da tabela **customers**.

Os clientes cadastrados serão utilizados durante todo o laboratório para simular pedidos, consultas, views e análises.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Inserir registros em uma tabela Delta
- Trabalhar com dados estruturados em JSON
- Validar a carga realizada
- Explorar os dados dos clientes

-- COMMAND ----------
%md
# 🧠 Conceito

Após criar a estrutura das tabelas, o próximo passo é carregar os clientes.

A coluna **profile** armazena informações em formato JSON, permitindo representar dados complexos em uma única coluna.

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
INSERT INTO customers
VALUES (...);
```

-- COMMAND ----------
%md
# 💡 Exemplo 1 - Load Customers

Carga inicial da tabela de clientes.

-- COMMAND ----------

INSERT INTO customers
VALUES

-- (MANTER EXATAMENTE TODOS OS REGISTROS DO ARQUIVO ORIGINAL)

;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_customers
FROM customers;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - Customers by Status

-- COMMAND ----------

SELECT
    status,
    COUNT(*) AS total_customers
FROM customers
GROUP BY status
ORDER BY status;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - Customers by Country

-- COMMAND ----------

SELECT
    profile:address:country AS country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY profile:address:country
ORDER BY country;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - Customers by City

-- COMMAND ----------

SELECT
    profile:address:city AS city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY profile:address:city
ORDER BY city;

-- COMMAND ----------
%md
# 💡 Exemplo 5 - Browse Customers

-- COMMAND ----------

SELECT
    customer_id,
    email,
    status,
    profile:first_name AS first_name,
    profile:last_name AS last_name
FROM customers
ORDER BY customer_id;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Execute a carga da tabela customers.
2. Conte a quantidade de clientes.
3. Liste os clientes por status.
4. Liste os clientes por país.
5. Consulte nome e sobrenome dos clientes.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT
    status,
    COUNT(*) AS total_customers
FROM customers
GROUP BY status;

SELECT
    profile:address:country AS country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY profile:address:country;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos a:

- Inserir registros em tabelas Delta.
- Trabalhar com colunas JSON.
- Validar a carga dos clientes.
- Explorar dados utilizando SQL.

-- COMMAND ----------
%md
# 🚀 Desafio

Adicione um novo cliente à tabela **customers**.

Depois valide:

- Quantidade total de clientes.
- País do novo cliente.
- Cidade do novo cliente.
