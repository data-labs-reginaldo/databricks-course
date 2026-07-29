-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 11 - Higher Order Functions

-- COMMAND ----------
%md
# 📖 Introdução

Higher Order Functions permitem manipular arrays e estruturas complexas utilizando funções lambda, eliminando a necessidade de explodir os dados em diversas situações.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Entender o conceito de Higher Order Functions
- Trabalhar com arrays de STRUCT
- Utilizar funções lambda
- Aplicar funções diretamente sobre a coluna books

-- COMMAND ----------
%md
# 🧠 Conceito

Neste laboratório utilizaremos a coluna **books**, presente na tabela **orders**, composta por um ARRAY<STRUCT>.

Principais funções:

- transform()
- filter()
- exists()
- forall()
- aggregate()
- arrays_zip()
- zip_with()

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
FUNCTION(array, x -> expressão)
```

Onde **x** representa cada elemento do array.

-- COMMAND ----------
%md
# 💡 Exemplo 1 - transform()

Retorna um novo array contendo apenas o código dos livros.

-- COMMAND ----------
SELECT
    order_id,
    transform(books, x -> x.book_id) AS book_ids
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercício 1

Liste todos os pedidos mostrando apenas os códigos dos livros.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    order_id,
    transform(books, x -> x.book_id) AS book_ids
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - filter()

Retorna apenas livros com desconto.

-- COMMAND ----------
SELECT
    order_id,
    filter(books, x -> x.discount > 0) AS discounted_books
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercício 2

Liste apenas os livros cujo subtotal seja maior que 80.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------
SELECT
    order_id,
    filter(books, x -> x.subtotal > 80) AS expensive_books
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - exists()

Verifica se existe algum livro com desconto.

-- COMMAND ----------
SELECT
    order_id,
    exists(books, x -> x.discount > 0) AS has_discount
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - forall()

Verifica se todos os livros possuem quantidade maior que zero.

-- COMMAND ----------
SELECT
    order_id,
    forall(books, x -> x.quantity > 0) AS valid_quantities
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 5 - aggregate()

Calcula o valor total do pedido utilizando o array.

-- COMMAND ----------
SELECT
    order_id,
    aggregate(
        books,
        CAST(0 AS DECIMAL(12,2)),
        (acc, x) -> acc + x.subtotal
    ) AS calculated_total
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 6 - arrays_zip()

Combina dois arrays posição a posição.

-- COMMAND ----------
SELECT
    order_id,
    arrays_zip(
        transform(books, x -> x.book_id),
        transform(books, x -> x.quantity)
    ) AS books_and_quantities
FROM orders;

-- COMMAND ----------
%md
# 💡 Exemplo 7 - zip_with()

Concatena código do livro e quantidade.

-- COMMAND ----------
SELECT
    order_id,
    zip_with(
        transform(books, x -> x.book_id),
        transform(books, x -> CAST(x.quantity AS STRING)),
        (id, qty) -> concat(id, ' -> ', qty)
    ) AS book_summary
FROM orders;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Retorne apenas os subtotais dos livros.
2. Filtre livros com quantidade maior que 1.
3. Verifique se existe algum desconto.
4. Calcule o valor total utilizando aggregate().
5. Combine book_id e subtotal utilizando zip_with().

-- COMMAND ----------
%md
# ✅ Soluções

-- COMMAND ----------
SELECT
    order_id,
    transform(books, x -> x.subtotal) AS subtotals,
    filter(books, x -> x.quantity > 1) AS quantities_gt1,
    exists(books, x -> x.discount > 0) AS has_discount,
    aggregate(
        books,
        CAST(0 AS DECIMAL(12,2)),
        (acc, x) -> acc + x.subtotal
    ) AS total_amount
FROM orders;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos:

- transform()
- filter()
- exists()
- forall()
- aggregate()
- arrays_zip()
- zip_with()

Essas funções permitem manipular arrays e estruturas complexas de forma eficiente utilizando SQL.

-- COMMAND ----------
%md
# 🚀 Desafio

Utilizando apenas Higher Order Functions, desenvolva uma consulta que apresente:

- Quantidade de livros por pedido.
- Valor total calculado pelo array.
- Lista de códigos dos livros.
- Indicação se existe algum item com desconto.
