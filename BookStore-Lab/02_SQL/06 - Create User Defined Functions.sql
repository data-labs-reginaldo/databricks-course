-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 06 - Create User Defined Functions

Este notebook apresenta o conceito de SQL User Defined Functions (UDFs) no Databricks.

-- COMMAND ----------
%md
# 📖 Introdução

Uma SQL User Defined Function (UDF) permite encapsular regras de negócio em uma função reutilizável, tornando o código mais limpo, legível e fácil de manter.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Entender o que é uma SQL UDF
- Criar funções parametrizadas
- Reutilizar regras de negócio
- Aplicar funções em consultas SQL

-- COMMAND ----------
%md
# 🧠 Conceito

O Databricks possui diversas funções nativas, como:

- UPPER()
- LOWER()
- CONCAT()
- COALESCE()

Quando uma regra é utilizada repetidamente, é recomendável encapsulá-la em uma User Defined Function.

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
CREATE OR REPLACE FUNCTION nome_funcao(parametro TIPO)
RETURNS TIPO
RETURN expressao;
```

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 💡 Exemplo 1 - format_book_title()

Padroniza o título de um livro.

-- COMMAND ----------
CREATE OR REPLACE FUNCTION format_book_title(title STRING)
RETURNS STRING
RETURN upper(trim(title));

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT
    title,
    format_book_title(title) AS formatted_title
FROM books;

-- COMMAND ----------
%md
# 🧪 Exercício 1

Liste:

- Título original
- Título formatado
- Categoria

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    title,
    format_book_title(title) AS formatted_title,
    category
FROM books;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - calculate_discount()

Calcula o preço final após um desconto percentual.

-- COMMAND ----------
CREATE OR REPLACE FUNCTION calculate_discount(
    price DECIMAL(10,2),
    discount DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
RETURN price - (price * discount / 100);

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT
    title,
    price,
    calculate_discount(price,10) AS final_price
FROM books;

-- COMMAND ----------
%md
# 🧪 Exercício 2

Mostre:

- Livro
- Preço original
- Preço com 15%
- Preço com 20%

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    title,
    price,
    calculate_discount(price,15) AS price_15,
    calculate_discount(price,20) AS price_20
FROM books;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - get_customer_name()

Concatena nome e sobrenome do cliente.

-- COMMAND ----------
CREATE OR REPLACE FUNCTION get_customer_name(profile STRING)
RETURNS STRING
RETURN concat(
    profile:first_name,
    ' ',
    profile:last_name
);

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT
    customer_id,
    get_customer_name(profile) AS customer_name
FROM customers;

-- COMMAND ----------
%md
# 🧪 Exercício 3

Mostrar:

- Cliente
- Nome
- Cidade
- País

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    customer_id,
    get_customer_name(profile) AS customer_name,
    profile:address:city AS city,
    profile:address:country AS country
FROM customers;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - get_order_url()

Gera uma URL para consulta do pedido.

-- COMMAND ----------
CREATE OR REPLACE FUNCTION get_order_url(order_id STRING)
RETURNS STRING
RETURN concat(
    'https://bookstore.demo/orders/',
    order_id
);

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------
SELECT
    order_id,
    get_order_url(order_id) AS order_url
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercício 4

Mostrar:

- Pedido
- Cliente
- URL

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    order_id,
    customer_id,
    get_order_url(order_id) AS order_url
FROM orders;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos:

- O que é uma SQL UDF
- Como criar funções
- Como utilizar parâmetros
- Como reutilizar lógica de negócio

-- COMMAND ----------
%md
# 🚀 Desafio

Crie uma função chamada:

book_label(title, category)

Formato esperado:

Learning Spark (Spark)

Utilize essa função para listar todos os livros da tabela books.
