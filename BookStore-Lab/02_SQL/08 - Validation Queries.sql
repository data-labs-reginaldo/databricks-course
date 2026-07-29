-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 08 - Validation Queries

-- COMMAND ----------
%md
# 📖 Introdução

Após a criação e carga das tabelas, é importante validar se os dados foram carregados corretamente.

Neste notebook utilizaremos consultas SQL para verificar a integridade dos dados e explorar funções aplicadas sobre arrays.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Validar cargas de dados
- Conferir quantidade de registros
- Explorar arrays utilizando funções SQL
- Confirmar a consistência das tabelas do laboratório

-- COMMAND ----------
%md
# 🧠 Conceito

As consultas de validação são utilizadas para confirmar que os dados carregados estão consistentes antes de avançar para as próximas etapas do projeto.

Serão utilizadas as funções:

- COUNT()
- explode()
- transform()
- filter()
- exists()
- aggregate()
- size()
- collect_set()

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
SELECT COUNT(*) FROM tabela;

SELECT explode(array_col);

SELECT transform(array_col, x -> ...);
```

-- COMMAND ----------
%md
# 💡 Exemplo 1 - COUNT()

Validando a quantidade de registros das tabelas.

-- COMMAND ----------
SELECT COUNT(*) AS customers FROM customers;

SELECT COUNT(*) AS books FROM books;

SELECT COUNT(*) AS orders FROM orders;

SELECT COUNT(*) AS orders_updates FROM orders_updates;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - explode()

Converte cada elemento do array books em uma linha.

-- COMMAND ----------
SELECT
    order_id,
    explode(books) AS book
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - transform()

Retorna apenas os códigos dos livros.

-- COMMAND ----------
SELECT
    order_id,
    transform(books, x -> x.book_id) AS book_ids
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - filter()

Filtra itens do array.

-- COMMAND ----------
SELECT
    order_id,
    filter(books, x -> x.quantity >= 1) AS books_filtered
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 5 - exists()

Verifica se existe livro com desconto.

-- COMMAND ----------
SELECT
    order_id
FROM orders
WHERE exists(books, x -> x.discount > 0);

-- COMMAND ----------
%md
# 💡 Exemplo 6 - aggregate()

Calcula o total do pedido utilizando o array.

-- COMMAND ----------
SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(12,2)),
        (acc, x) -> acc + x.subtotal
    ) AS total
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 7 - size()

Quantidade de livros por pedido.

-- COMMAND ----------
SELECT
    order_id,
    size(books) AS total_items
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 8 - collect_set()

Categorias distintas.

-- COMMAND ----------
SELECT
    collect_set(category) AS categories
FROM books;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Conte os registros de todas as tabelas.
2. Liste os livros de cada pedido utilizando explode().
3. Retorne apenas os códigos dos livros com transform().
4. Filtre itens do array.
5. Calcule o total de cada pedido.
6. Conte quantos livros existem em cada pedido.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    (SELECT COUNT(*) FROM customers) AS customers,
    (SELECT COUNT(*) FROM books) AS books,
    (SELECT COUNT(*) FROM orders) AS orders,
    (SELECT COUNT(*) FROM orders_updates) AS updates;

SELECT
    order_id,
    size(books) AS total_items,
    aggregate(
        books,
        CAST(0 AS DECIMAL(12,2)),
        (acc,x)->acc+x.subtotal
    ) AS total_amount
FROM orders;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos a validar cargas utilizando consultas SQL e funções aplicadas sobre arrays para confirmar a consistência dos dados do laboratório.

-- COMMAND ----------
%md
# 🚀 Desafio

Crie uma consulta que apresente, para cada pedido:

- Quantidade de livros
- Valor total calculado pelo array
- Lista de book_id
- Indicação se existe algum item com desconto
